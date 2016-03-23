package com.bnebit.sms.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.EmployeeService;
import com.bnebit.sms.service.MainService;
import com.bnebit.sms.vo.Employee;

@Controller
@RequestMapping
public class MainController {
	
	@Autowired
	private MainService mainService;
	@Autowired
	private EmployeeService employeeService; 

	private Logger log = Logger.getLogger(getClass());

	@RequestMapping()
	public ModelAndView index(@CookieValue(value="JSESSIONID", defaultValue="-1") String cookieID,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session){
//		session.removeAttribute("LOGIN_USER");
		ModelAndView mav = employeeService.sessionCheck(cookieID,request,session);
		if("mainPage".equals(mav.getViewName())){
			mav = mainService.followMe(session);
		}
		return mav;
	}
	
	@RequestMapping(value="/loginForm")
	public ModelAndView loginForm(HttpSession session){
		ModelAndView mav = employeeService.securePacket(session);
		return mav;
	}
	
	@RequestMapping(value="/login")
	public ModelAndView login(Employee inputEmployee, HttpSession session,
			HttpServletRequest request, HttpServletResponse response){
		ModelAndView mav = employeeService.login(inputEmployee, session, request, response);
		return mav;
	}
	
	@RequestMapping("/logout")
	public ModelAndView logout(HttpSession session, HttpServletResponse response){
		ModelAndView mav = employeeService.logout(session, response);
		return mav;
	}
	
	@RequestMapping("/requestValidation")
	public ModelAndView requestValidation(Employee inputEmployee){
		ModelAndView mav = employeeService.requestValidation(inputEmployee);
		return mav;
	}
	
	@RequestMapping("/checkValidation")
	public ModelAndView checkValidation(Employee inputEmployee, @RequestParam String code,
			HttpServletRequest request, HttpSession session, HttpServletResponse response){
		ModelAndView mav = 
				employeeService.checkValidation(inputEmployee, code, request,session,response);
		
		return mav;
	}
	@RequestMapping("/getRSAKey")
	public ModelAndView getRSAKey(HttpSession session){
		ModelAndView mav = employeeService.securePacketJSON(session);
		return mav;
	}
	@RequestMapping("/modifyPwd")
	public ModelAndView modifyPwd(HttpSession session, String currentPwd, String newPassword){
		ModelAndView mav = employeeService.changePassword(session, currentPwd, newPassword);
		return mav;
	}
	@RequestMapping("/modifyProfileImg")
	public ModelAndView modifyProfileImg(MultipartFile file, HttpSession session){
		ModelAndView mav = employeeService.modifyProfileImg(file,session);
		return mav;
	}
	
	@RequestMapping("/planCheck")
	public ModelAndView planCheck(String planId , String checked){
		System.out.println(planId + checked);
		ModelAndView mav = mainService.planCheck(planId, checked);
		return mav;
	}
	
}
