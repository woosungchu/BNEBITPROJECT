package com.bnebit.sms.service;

import java.net.InetAddress;

import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.security.PrivateKey;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.EmployeeDAO;
import com.bnebit.sms.dao.SessionDAO;
import com.bnebit.sms.dao.ValidationDAO;
import com.bnebit.sms.util.CryptUtil;
import com.bnebit.sms.util.Cryptable;
import com.bnebit.sms.util.MailUtil;
import com.bnebit.sms.util.UploadUtil;
import com.bnebit.sms.util.exception.LoginCheckException;
import com.bnebit.sms.util.exception.SessionCheckException;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.SessionKey;
import com.bnebit.sms.vo.Validation;
import com.sun.xml.internal.ws.util.StringUtils;

@Service
public class EmployeeService implements Cryptable{

	@Autowired
	private ModelAndView mav;
	@Autowired
	private EmployeeDAO employeeDAO;
	@Autowired
	private SessionDAO	sessionDAO;
	@Autowired
	private ValidationDAO validationDAO;
	@Autowired
	private MailUtil mailUtil;
	
	private Logger log = Logger.getLogger(getClass());
	private CryptUtil cryptUtil = CryptUtil.getInstance(this);
	
	static final int COOKIE_AGE = 60 * 60 * 24 * 7 ;// 일주일
	static final int TIME_LIMIT = 30 ; //30분
	
	
	private ModelAndView goLoginForm(String message) {
		mav.addObject("MESSAGE", message);
		mav.setViewName("redirect:/");
		return mav;
	}
	
	public ModelAndView securePacket(HttpSession session){
		Map<String,String> map = cryptUtil.encryptRSA(session);
		mav.addObject("RSAModulus",map.get("RSAModulus"));
		mav.addObject("RSAExponent",map.get("RSAExponent"));
		mav.setViewName("welcome");
		return mav;
	}
	public ModelAndView securePacketJSON(HttpSession session){
		Map<String,String> map = cryptUtil.encryptRSA(session);
		mav.addObject("JSON",map);
		mav.setViewName("jsonView");
		return mav;
	}
	
	public ModelAndView login(Employee inputEmployee, HttpSession session, HttpServletResponse response){
		String ipAddr = getIpAddr();
		Employee employee=new Employee();
		String decryptedEmail = "";
		String decryptedPassword = "";

		PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
        session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
        
        if(privateKey == null){
        	return goLoginForm("암호화 비밀키 정보를 찾을 수 없습니다.");
        }
        
		try {
        	//inputEmployee에 담긴 input Data를 복호화
            decryptedEmail = cryptUtil.decryptRsa(privateKey,inputEmployee.getEmail());
            inputEmployee.setEmail(decryptedEmail);
            
            //Hashing Pwd
            decryptedPassword = cryptUtil.decryptRsa(privateKey, inputEmployee.getPassword());
            String hashingPwd = cryptUtil.hashing(decryptedPassword);
            inputEmployee.setPassword(hashingPwd);
            
        } catch (Exception ex) {
            log.info("복호화를 위한 데이터가 이상합니다 다시 로그인을 시도해주세요....");
        }
        
        //DB에서 로그인한 계정 가져옴
        employee = employeeDAO.selectOneByEmailPw(inputEmployee);
        
        if(employee == null){
			return goLoginForm("이메일이나 비밀번호가 잘못되었습니다");
		}else{
			//세션저장
			session.setAttribute("LOGIN_USER",employee);
			//쿠키생성
			SessionKey sessionKey = new SessionKey();
			sessionKey.setEmployee(employee);
			sessionKey.setSessionId(session.getId());
			sessionKey.setIp(ipAddr);
			sessionKey.setMacAddr(formatMacAddress(ipAddr));
			sessionDAO.insert(sessionKey);

			//쿠키생성
			Cookie cookie = new Cookie("JSESSIONID",session.getId());
			cookie.setMaxAge(COOKIE_AGE);//1시간
			response.addCookie(cookie);
			
			mav.setViewName("redirect:/");

			return mav;
		}
	}
	
	//세션과 쿠키에 계정정보 넣어줌.
	private void setSessionCookie(Employee employee, HttpSession session, HttpServletResponse response) {
		String ipAddr = getIpAddr();
		
		//세션저장
		session.setAttribute("LOGIN_USER",employee);
		//쿠키생성
		SessionKey sessionKey = new SessionKey();
		sessionKey.setEmployee(employee);
		sessionKey.setSessionId(session.getId());
		sessionKey.setIp(ipAddr);
		sessionKey.setMacAddr(formatMacAddress(ipAddr));
		sessionDAO.insert(sessionKey);

		//쿠키생성
		Cookie cookie = new Cookie("JSESSIONID",session.getId());
		cookie.setMaxAge(COOKIE_AGE);//1시간
		response.addCookie(cookie);
	}
	
	public ModelAndView sessionCheck(String cookieID, HttpSession session) {
		String ipAddr = getIpAddr();
		
		Employee vo = (Employee) session.getAttribute("LOGIN_USER");
		
		//session check
		if(vo != null){
			log.info("세션에서 유효계정 발견!");
			mav.setViewName("mainPage");
			return mav;
		//cookie check
		}else if(!"-1".equals(cookieID) && ipAddr != null){
			//일단 ip,mac,sessionID 일치하는 SessionKey가져오기
			SessionKey inputKey = new SessionKey();
			inputKey.setSessionId(cookieID);
			inputKey.setIp(ipAddr);
			inputKey.setMacAddr(formatMacAddress(ipAddr));

			SessionKey sessionKey = sessionDAO.selectOne(inputKey);
			
			if(sessionKey != null){
				log.info("쿠키에서 유효계정 발견!");
				Employee empVo = employeeDAO.selectOneById(sessionKey.getEmployee().getEmpId());
				
				//date 비교
				if(checkDateValidation(sessionKey)){ //만료시간 아직 안지났으면 true 리턴
					session.setAttribute("LOGIN_USER", empVo);
					mav.setViewName("mainPage");
					return mav;
				}else{
					//-넘었으면 기존 아이디만 보여줄것.
					empVo.setPassword(null);
					mav.addObject("RECENT_USER",empVo);
					log.info("RECENT_USER = " + empVo.toString());
				}
			}
		}
		log.info("세션에도 없고 쿠키에도 없음 ");
		mav.setViewName("redirect:/loginForm");
		return mav;
	}
	
	public String getIpAddr(){
		String ipAddr = "";
		InetAddress ip = null ;
		
		try {
			ip = InetAddress.getLocalHost();//핵심
			ipAddr = ip.getHostAddress();//핵심
			
		} catch (UnknownHostException e) {
			ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
			  HttpServletRequest request = servletRequestAttributes.getRequest();
			ipAddr = request.getRemoteAddr();
		}
	
		return ipAddr;
	}
	
	public ModelAndView logout(HttpSession session, HttpServletResponse response) {
		session.removeAttribute("LOGIN_USER");
		
		Cookie cookie = new Cookie("JSESSIONID",null);
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		session.invalidate();//중요!
		
		return goLoginForm("로그아웃에 성공하셨습니다");
	}
	
	private String formatMacAddress(String ipAddr) {
		NetworkInterface network;
		StringBuilder sb = null;
		try {
			//After
			network = NetworkInterface.getByInetAddress(InetAddress.getByName(ipAddr));

			byte[] mac = network.getHardwareAddress();
			sb = new StringBuilder();
			for (int i = 0; i < mac.length; i++) {
			  sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
			}
			
		} catch (SocketException | UnknownHostException e1) {e1.printStackTrace();
		}
		return sb.toString();
	}
	
	public boolean checkDateValidation(SessionKey sessionKey) {
		String expiration = sessionKey.getExpiration();

		try {
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss", Locale.KOREA);
			cal.setTime(sdf.parse(expiration));

			if(cal.after(Calendar.getInstance())){
				//만료시간 아직 여유있다는 뜻.
				return true;
			} 
			log.info("쿠키에 저장된 계정 유효기간 지났습니다!");

		} catch (ParseException e) {e.printStackTrace();}

		return false;
	}

	public ModelAndView requestValidation(Employee inputEmployee) {
		Employee employee = employeeDAO.selectEmployeeByEmailName(inputEmployee);
//		Employee employee = null;
		if(employee != null){
			//1.인증번호 생성
//			String code = Long.toHexString(Double.doubleToLongBits(Math.random())); // 3fedc09093052c8c
			String code = RandomStringUtils.randomAlphanumeric(7).toUpperCase();
			
			//2.인증번호 서버에 전송
			Validation validation = new Validation();
			validation.setEmployee(employee);
			validation.setCode(code);
			validationDAO.insert(validation, TIME_LIMIT); //VALIDATION
			
			//3. DB에 잘 저장되면 메일로 전송
			mailUtil.sendMessage(employee.getEmail(),
								"woosungchutest@gmail.com",
								"BBT Company : 안녕하세요! "+employee.getEmpName()+" 님! 인증번호가 도착하였습니다!",
								"인증코드 : "+validation.getCode());
//			
			mav.addObject("JSON", "SUCCESS");
		}else{
			mav.addObject("JSON", "ERROR");
		}
		
    	mav.setViewName("jsonView");
		return mav;
	}
	
	public ModelAndView checkValidation(Employee inputEmployee, String code, 
			HttpServletRequest request,	HttpSession session, HttpServletResponse response) {
		//인증번호 확인
		Employee employee = employeeDAO.selectEmployeeByEmailName(inputEmployee);
		
		Validation inputValidation = new Validation();
		inputValidation.setEmployee(employee);
		
		Validation validation = validationDAO.selectOne(inputValidation);
		
		if(code.equals(validation.getCode())){
			mav.addObject("JSON", "PASS");
			
			//비밀번호 변경
			//start
			PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
	        session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
	        
	        if(privateKey == null){
	        	return goLoginForm("암호화 비밀키 정보를 찾을 수 없습니다.");
	        }
	        
	        try {
	        	//비밀번호 복호화 후 SHA256
	            String decryptedPassword = cryptUtil.decryptRsa(privateKey, inputEmployee.getPassword());
	            String hashingPwd = cryptUtil.hashing(decryptedPassword);
	            employee.setPassword(hashingPwd);
	            
	            employeeDAO.updatePassword(employee);
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
			//end
			
			//session에 저장, 쿠키에 저장, 후 :/에서 변경페이지로 이동하는 것이 어떤가...
			setSessionCookie(employee, session, response);
			
			log.info("인증번호가 일치합니다");
		}else{
			mav.addObject("JSON", "DENIED");
			log.info("인증번호가 일치하지 않습니다");
		}
		
		mav.setViewName("jsonView");
		return mav;
	}
	public ModelAndView changePassword(HttpSession session, String currentPwd, String newPassword) {
		String decryptedCurPwd = "";
		String decryptedNewPwd = "";
		
		//0.RSA 복구
		PrivateKey privateKey = (PrivateKey) session.getAttribute("__rsaPrivateKey__");
        session.removeAttribute("__rsaPrivateKey__"); // 키의 재사용을 막는다. 항상 새로운 키를 받도록 강제.
        
        if(privateKey == null){
			return goLoginForm("암호화 비밀키 정보를 찾을 수 없습니다.");
        }
        
		try {
			decryptedCurPwd = cryptUtil.decryptRsa(privateKey, currentPwd);
			decryptedNewPwd = cryptUtil.decryptRsa(privateKey, newPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//1.실 사용자 맞는지 확인
		Employee inputEmployee = (Employee) session.getAttribute("LOGIN_USER");
		inputEmployee.setPassword(cryptUtil.hashing(decryptedCurPwd));
		Employee employee = employeeDAO.selectOneByEmailPw(inputEmployee);
			//이메일과 비밀번호가 일치 //인증성공
		if(employee!=null){
			//2.update
			employee.setPassword(cryptUtil.hashing(decryptedNewPwd));
			employeeDAO.updatePassword(employee);
			mav.addObject("RESULT", "PWD_SUCCESS");
		}else{
			mav.addObject("RESULT", "WRONG_PWD");
		}
		mav.setViewName("redirect:/");
		return mav;
		
	}
	
	public ModelAndView modifyProfileImg(MultipartFile file, HttpSession session) {
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		String priorImage = employee.getImgName();
		String imgName = "";
		
		if("NONAME".equals(priorImage)){
			//사진이 없으면 만듬
			imgName = "("+employee.getEmail()+")profileImage.png";
			employee.setImgName(imgName);
			try {
				System.out.println(employee);
				employeeDAO.updateEmp(employee);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else{
			//원래 사진이 있으면 덮어씌우기만함.
			imgName = priorImage;
		}
		
		UploadUtil.uploadHelper(file, imgName);
		
		//Session, DB update가 필요 없네 .. 같은 파일명에 덮어 씌우는거니까..
		mav.addObject("RESULT", "IMG_SUCCESS");
		mav.setViewName("redirect:/");
		return mav;
	}

}

