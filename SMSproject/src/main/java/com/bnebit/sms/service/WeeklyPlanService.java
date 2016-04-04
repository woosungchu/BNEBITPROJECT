package com.bnebit.sms.service;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.DailyPlanDAO;
import com.bnebit.sms.dao.DailyReportDAO;
import com.bnebit.sms.dao.EventDAO;
import com.bnebit.sms.dao.PlanDAO;
import com.bnebit.sms.dao.WeeklyPlanDAO;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.DailyReport;
import com.bnebit.sms.vo.Dept;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Event;
import com.bnebit.sms.vo.Plan;
import com.bnebit.sms.vo.WeeklyPlan;

@Service
public class WeeklyPlanService {
	@Autowired
	private WeeklyPlanDAO weeklyPlanDAO;
	@Autowired
	private DailyPlanDAO dailyPlanDAO;
	@Autowired
	private EventDAO eventDAO;
	@Autowired
	private PlanDAO planDAO;
	@Autowired
	private DailyReportDAO dailyReportDAO;
	@Autowired
	private ModelAndView mav;

	// 페이지 전환 계산 메서드 => 최대 3개의 페이지 선택가능!!
	public HashMap<String, Integer> pageCalculator(int cnt, int rownum){
		int num=10;		// 한번에 볼 갯수
		int column=3;	// 페이지 라인에 출력할 총 갯수 => 홀수로 할 것!!
		int columnHalf=column/2 + 1;	// 페이지 라인 중 중간 페이지

		// 전체 페이징 설정
		int begin=1;
		int end=(cnt-1)/num+1;
		// 페이징이 column 갯수보다 많을 때 ... 처리!
		if(cnt>num*column){
			// rownum이 조회가능갯수보다 클 때
			if(rownum>num){
				// 마지막 페이지일때
				if((cnt-rownum)<=num){
					// 시작하는 페이징 숫자 구하기
					begin=(((cnt-1)/num)+1)-(column-1);
				// 마지막 페이지가 중간이상 일 때
				}else if((cnt-rownum)<=columnHalf*num){
					// 마지막 페이지는 그대로 가장 끝!
					// 시작 페이지는 rownum/num
					begin=(((cnt-1)/num)+1)-(column-1);
				// 마지막 페이지가 보이지 않을 경우
				}else{
					// 현재 조회하는 곳은 가운데! 시작점음 현재를 기준으로 column 절반!
					begin=((rownum/num)+1)-(columnHalf-1);
					end=(rownum/num+1)+(columnHalf-1);
				}
			}else{
				end=column;
			}
		}
		HashMap<String, Integer>map=new HashMap<String, Integer>();
		map.put("begin", begin);
		map.put("end", end);
		return map;
	}
	/*
	 * 한 사원이 작성한 모든 주간계획을 리스트로 조회
	 * empId가 일치하는 모든 주간계획을 불러온다.
	 * ModelAndView : ArrayList<WeeklyPlan>
	 * */
	public ModelAndView weeklyListEmp(HttpSession session, String empId, int rownum)throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		mav.addObject("LOGIN_USER", employee);

		//Calendar
		ArrayList<Event> eventList=eventDAO.selectEventList();
		mav.addObject("eventList", eventList);

		//Weekly
		//한 사원의 weeklyList를 조회
		ArrayList<WeeklyPlan> weeklyList=weeklyPlanDAO.selectWeeklyPlanListEmp(empId, rownum);
		mav.addObject("weeklyList", weeklyList);
		//한 사원의 weeklyPlan의 갯수 조회
		int cnt=weeklyPlanDAO.selectWeeklyListEmpCount(empId);
		//페이징
		HashMap<String, Integer> map=pageCalculator(cnt, rownum);
		int end=map.get("end");
		int begin=map.get("begin");
		mav.addObject("end", end);
		mav.addObject("begin", begin);
		mav.addObject("rownum", rownum);
		mav.addObject("count",cnt);
		//현재 페이지 이름
		mav.addObject("page", "weeklyListEmp");
		//Manager 일때
		if("Manager".equals(employee.getPosition())){
			//Calendar - 사원의 Plan 조회
			ArrayList<DailyPlan> dailyPlanList=weeklyPlanDAO.selectCalendarManager(employee.getDept().getDeptId());
			mav.addObject("dailyPlanList", dailyPlanList);
			mav.setViewName("weekly/viewWeeklyListManager");
		//SalesMan 일때
		}else{
			//Calendar - 본인의 Plan 조회
			ArrayList<Plan> planList=weeklyPlanDAO.selectCalendarPlan(empId);
			mav.addObject("planList", planList);
			mav.setViewName("weekly/viewWeeklyList");
		}
		return mav;
	}
	/*
	 * 팀원 전체가 작성한 모든 주간계획을 리스트로 조회
	 * deptId가 일치하는 모든 주간계획을 불러온다.
	 * ModelAndView : ArrayList<WeeklyPlan>
	 * */
	public ModelAndView weeklyList(HttpSession session, String deptId, int rownum)throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		mav.addObject("LOGIN_USER", employee);

		//Calendar
		ArrayList<Event> eventList=eventDAO.selectEventList();
		ArrayList<DailyPlan> dailyPlanList=weeklyPlanDAO.selectCalendarManager(deptId);
		mav.addObject("eventList", eventList);
		mav.addObject("dailyPlanList", dailyPlanList);

		//Weekly
		ArrayList<WeeklyPlan> weeklyList=weeklyPlanDAO.selectWeeklyPlanListManager(deptId, rownum);
		mav.addObject("weeklyList", weeklyList);
		//페이징
		int cnt=weeklyPlanDAO.selectWeeklyListCount(deptId);
		HashMap<String, Integer> map=pageCalculator(cnt, rownum);
		int end=map.get("end");
		int begin=map.get("begin");
		mav.addObject("end", end);
		mav.addObject("begin", begin);
		mav.addObject("rownum", rownum);
		mav.addObject("count", cnt);
		//현재 페이지
		mav.addObject("page", "weeklyList");
		mav.setViewName("weekly/viewWeeklyListManager");
		return mav;
	}
	/*
	 * 팀원중에서 특정한 주에 작성한 모든 주간계획을 리스트로 조회
	 * WeeklyPlan에 저장된 deptId와 monday가 일치하는 모든 주간계획을 불러온다.
	 * ModelAndView : ArrayList<WeeklyPlan>
	 * */
	public ModelAndView weeklyListWeek(HttpSession session, String deptId, String monday, int rownum)throws Exception{
		Employee employee=(Employee) session.getAttribute("LOGIN_USER");
		mav.addObject("LOGIN_USER", employee);

		//Calendar
		ArrayList<Event> eventList=eventDAO.selectEventList();
		ArrayList<DailyPlan> dailyPlanList=weeklyPlanDAO.selectCalendarManager(deptId);
		mav.addObject("eventList", eventList);
		mav.addObject("dailyPlanList", dailyPlanList);

		//Weekly
		ArrayList<WeeklyPlan> weeklyList=weeklyPlanDAO.selectWeeklyPlanListWeek(deptId, monday, rownum);
		mav.addObject("weeklyList", weeklyList);
		//페이징
		WeeklyPlan weeklyPlan=new WeeklyPlan();
		weeklyPlan.setMonday(monday);
		Employee emp=new Employee();
		Dept dept=new Dept();
		dept.setDeptId(deptId);
		emp.setDept(dept);
		weeklyPlan.setEmployee(emp);
		int cnt=weeklyPlanDAO.selectWeeklyListWeekCount(weeklyPlan);
		HashMap<String, Integer> map=pageCalculator(cnt, rownum);
		int end=map.get("end");
		int begin=map.get("begin");
		mav.addObject("end", end);
		mav.addObject("begin", begin);
		mav.addObject("rownum", rownum);
		mav.addObject("count", cnt);
		mav.addObject("monday", monday);
		//현재 페이지
		mav.addObject("page", "weeklyListWeek");
		mav.setViewName("weekly/viewWeeklyListManager");
		return mav;
	}
	/*
	 * 주간계획을 조회							///////////////////////////////////////////////////////////////////매개변수 수정됨!!!!!
	 * WeeklyPlan 테이블을 조회해서 이름, 부서, 날짜를 조회
	 * DailyPlan과 DailyReport 테이블을 조회해서 목표액, 달성액, 달성률 조회
	 * DailyPlan을  월요일 부터 금요일까지 다섯번 조회해서 각 날짜마다 매출액 조회
	 * Plan 테이블을 조회해서 각 날짜에 해당되는 일정을 모두 조회
	 * 조회하는 사람이 팀장이면 checked를 1로 변경
	 * ModelAndView : WeeklyPlan, ArrayList<DailyPlan>, HashMap<String, ArrayList<Plan>>
	 * */////////////////////////////////////////////////////////////////////////////////////////////
	public ModelAndView viewWeeklyPlan(HttpSession session, String weeklyPlanId) throws Exception {
		Employee employee=(Employee) session.getAttribute("LOGIN_USER");
		mav.addObject("LOGIN_USER", employee);

		//Calendar
		ArrayList<Event> eventList=eventDAO.selectEventList();

		if("null".equals(weeklyPlanId)){
			mav.addObject("error", "주간계획이 존재하지 않습니다.");
			mav.setViewName("calendar/viewCalendarPlan");
			return mav;
		}
		//Weekly
		//dailyPlan에 empId, planDate 설정
		WeeklyPlan weekly=weeklyPlanDAO.selectWeeklyPlan(weeklyPlanId);
		DailyPlan dailyPlan=new DailyPlan();
		dailyPlan.setWeeklyPlan(weekly);
		//월~금의 dailyPlan을 저장할 객체 : dailyPlanSalesList
		ArrayList<DailyPlan> dailyPlanSalesList=new ArrayList<DailyPlan>();
		//weeklyPlan에 저장된 monday를 이용해서 dailyPlan에 들어갈 날짜 찾기
		DateFormat format=new SimpleDateFormat("yy/MM/dd");
		Date date=format.parse(weekly.getMonday());
		for(int i=0;i<5;i++){
			String dateString=format.format(date);
			dailyPlan.setPlanDate(dateString);
			DailyPlan daily=dailyPlanDAO.selectDailyPlan(dailyPlan);
			//dailyPlanList에 dailyPlan 추가시키기
			dailyPlanSalesList.add(daily);
			// 하루 미루기
			long time=date.getTime();
			time+=24*60*60*1000;
			date.setTime(time);
		}
		mav.addObject("dailyPlanSalesList", dailyPlanSalesList);
		mav.addObject("weeklyPlan", weekly);
		//sales를 제외한 weeklyPlan 정보 조회
		WeeklyPlan wPlan=weeklyPlanDAO.selectWeeklyETC(weeklyPlanId);
		//팀장일때는 조회시 checked를 1로 변경
		if("Manager".equals(employee.getPosition())){
			ArrayList<DailyPlan> dailyPlanList=weeklyPlanDAO.selectCalendarManager(employee.getDept().getDeptId());
			mav.addObject("dailyPlanList", dailyPlanList);
			weeklyPlanDAO.updateWeeklyChecked1(wPlan);
		}else{
			ArrayList<Plan> planList=weeklyPlanDAO.selectCalendarPlan(employee.getEmpId());
			mav.addObject("planList", planList);
		}
		mav.addObject("eventList", eventList);
		mav.setViewName("weekly/viewWeeklyPlan");
		return mav;
	}
	public ModelAndView viewEmpPlan(String empId, String planDate) throws Exception{
		SimpleDateFormat sdf=new SimpleDateFormat("yy/MM/dd");
		Date dateObject=sdf.parse(planDate);
		int dayOfWeek=dateObject.getDay();
		int dayOfMonth=dateObject.getDate();
		switch(dayOfWeek){
		case 1:
			dateObject.setDate(dayOfMonth);
			break;
		case 2:
			dateObject.setDate(dayOfMonth-1);
			break;
		case 3:
			dateObject.setDate(dayOfMonth-2);
			break;
		case 4:
			dateObject.setDate(dayOfMonth-3);
			break;
		case 5:
			dateObject.setDate(dayOfMonth-4);
			break;
		}
		String monday=sdf.format(dateObject);

		WeeklyPlan weeklyPlan=new WeeklyPlan();
		Employee employee=new Employee();
		employee.setEmpId(empId);
		weeklyPlan.setEmployee(employee);
		weeklyPlan.setMonday(monday);
		String weeklyPlanId=weeklyPlanDAO.selectWeeklyPlanByEmpMonday(weeklyPlan);
		mav.setViewName("redirect:/viewWeeklyPlan?weeklyPlanId="+weeklyPlanId);
		return mav;
	}
	/*
	 * 특정 날짜, 특정 사원의 Plan 조회
	 * */
	public ModelAndView viewPlan(String empId, String planDate) throws Exception{
		Event event=eventDAO.selectEvent(planDate);
		DailyPlan dailyPlan=new DailyPlan();
		WeeklyPlan weekly=new WeeklyPlan();
		Employee employee=new Employee();
		employee.setEmpId(empId);
		weekly.setEmployee(employee);
		dailyPlan.setWeeklyPlan(weekly);
		//event가 있으면 event 전송
		if(event!=null){
			mav.addObject("JSON", event);
		//event가 없으면 plan 전송
		}else{
			dailyPlan.setPlanDate(planDate);
			ArrayList<Plan> planList=planDAO.selectPlan(dailyPlan);
			if(planList!=null){
				mav.addObject("JSON", planList);
			}
		}
		mav.setViewName("jsonView");
		return mav;
	}
	/* monday로 title 받아오는 메서드 */
	public String getTitle(String monday) throws Exception{
		DateFormat format=new SimpleDateFormat("yy/MM/dd");
		Date date=format.parse(monday);
		long time=date.getTime();
		time+=24*60*60*1000*2;
		date.setTime(time);

		int month=date.getMonth()+1;
		int wedDay=date.getDate();
		int week;
		if(wedDay!=1){
			week=(wedDay-1)/7 + 1;
		}else{
			week=1;
		}
		String title=month+"월 "+week+"주차 주간계획";
		return title;
	}
	/*
	 * 주간계획 입력화면 접근시
	 * WeeklyPlan 테이블에 emp_id, reg_date, title, monday, checked를 삽입
	 * DailyPlan을 월~금으로 5개 생성, 이때 목표금액은 작성전이므로 목표금액을 제외한 데이터를 넣음
	 * Event테이블을 조회해 그 주에 해당하는 날짜에 일정이 없는지 확인
	 * 일정이 있으면 그 날은 Plan입력 불가
	 * 일정이 없으면 그 날에 Plan을 넣을 수 있음
	 * ModelAndView : ArrayList<Event>
	 * */
	public ModelAndView inputWeeklyPlan(HttpSession session, String empId, String monday)throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		mav.addObject("LOGIN_USER", employee);

		//Calendar
		ArrayList<Event> eventList=eventDAO.selectEventList();
		ArrayList<Plan> planList=weeklyPlanDAO.selectCalendarPlan(empId);
		mav.addObject("eventList", eventList);
		mav.addObject("planList", planList);

		//Weekly
		WeeklyPlan weeklyPlan=new WeeklyPlan();
		Employee emp=new Employee();
		emp.setEmpId(empId);
		weeklyPlan.setEmployee(emp);
		weeklyPlan.setMonday(monday);
		//monday로 title 계산!
		String title=getTitle(monday);
		weeklyPlan.setTitle(title);

		//Weekly Plan의 시퀀스를 리턴받아서 Daily Plan 객체를 생성할 때 사용
		String seqWeeklyId=weeklyPlanDAO.insertWeeklyPlan(weeklyPlan);		// employee.empId, title, monday
		weeklyPlan.setWeeklyPlanId(seqWeeklyId);
		DailyPlan dailyPlan=new DailyPlan();
		WeeklyPlan weekly=weeklyPlanDAO.selectWeeklyETC(seqWeeklyId);
		dailyPlan.setWeeklyPlan(weekly);

		// 생성한 Daily Plan을 저장할 객체 : dailyPlanList
		ArrayList<DailyPlan> dailyPlanList=new ArrayList<DailyPlan>();
		//weeklyPlan에 저장된 monday를 이용해서 dailyPlan에 들어갈 날짜 찾기
		DateFormat format=new SimpleDateFormat("yy/MM/dd");
		Date date=format.parse(weeklyPlan.getMonday());
		for(int i=0;i<5;i++){
			String dateString=format.format(date);
			dailyPlan.setPlanDate(dateString);
			dailyPlanDAO.insertDailyPlan(dailyPlan);
			DailyPlan dPlan=dailyPlanDAO.selectDailyPlan(dailyPlan);
			dailyPlanList.add(dPlan);
			Event event=eventDAO.selectEvent(dailyPlan.getPlanDate());
			if(event!=null){
				eventList.add(event);
			}
			// 하루 미루기
			long time=date.getTime();
			time+=24*60*60*1000;
			date.setTime(time);
		}
		weeklyPlan=weeklyPlanDAO.selectWeeklyETC(seqWeeklyId);
		// monday를 기간으로 수정하기!
		date=format.parse(weeklyPlan.getMonday());
		String mondayString=monday+"~";
		long time=date.getTime();
		time+=24*60*60*1000*4;
		date.setTime(time);
		mondayString+=format.format(date);
		weeklyPlan.setMonday(mondayString);
		mav.addObject("weeklyPlan", weeklyPlan);		// deptName, empName, title, monday
		mav.addObject("dailyPlanList", dailyPlanList);
		mav.setViewName("weekly/inputWeeklyPlan");
		return mav;
	}
	/*
	 * 주간계획 수정
	 * */
	public ModelAndView editWeeklyPlan(HttpSession session, String weeklyPlanId)throws Exception{
		Employee employee=(Employee) session.getAttribute("LOGIN_USER");

		//Calendar
		ArrayList<Event> eventList=eventDAO.selectEventList();
		ArrayList<Plan> planList=weeklyPlanDAO.selectCalendarPlan(employee.getEmpId());
		mav.addObject("LOGIN_USER", employee);
		mav.addObject("eventList", eventList);
		mav.addObject("planList", planList);

		//Weekly
		WeeklyPlan weekly=weeklyPlanDAO.selectWeeklyPlan(weeklyPlanId);
		DailyPlan dailyPlan=new DailyPlan();
		dailyPlan.setWeeklyPlan(weekly);

		//월~금의 dailyPlan을 저장할 객체 : dailyPlanList
		ArrayList<DailyPlan> dailyPlanList=new ArrayList<DailyPlan>();
		//weeklyPlan에 저장된 monday를 이용해서 dailyPlan에 들어갈 날짜 찾기
		DateFormat format=new SimpleDateFormat("yy/MM/dd");
		Date date=format.parse(weekly.getMonday());
		for(int i=0;i<5;i++){
			String dateString=format.format(date);
			dailyPlan.setPlanDate(dateString);
			DailyPlan daily=dailyPlanDAO.selectDailyPlan(dailyPlan);
			//dailyPlanList에 dailyPlan 추가시키기
			dailyPlanList.add(daily);

			// 하루 미루기
			long time=date.getTime();
			time+=24*60*60*1000;
			date.setTime(time);
		}

		WeeklyPlan wPlan=weeklyPlanDAO.selectWeeklyETC(weeklyPlanId);
		weeklyPlanDAO.updateWeeklyChecked0(wPlan);

		mav.addObject("dailyPlanList", dailyPlanList);
		mav.addObject("weeklyPlan", weekly);
		mav.setViewName("weekly/inputWeeklyPlan");
		return mav;
	}
	/*
	 * monday로 현재 접속한 사원의 weeklyPlanId 불러오기
	 * */
	public String checkWeeklyPlanId(HttpSession session, String monday) throws Exception{
		Employee employee=(Employee) session.getAttribute("LOGIN_USER");
		WeeklyPlan weekly=new WeeklyPlan();
		Employee emp=new Employee();
		emp.setEmpId(employee.getEmpId());
		weekly.setEmployee(emp);
		weekly.setMonday(monday);
		String weeklyPlanId=weeklyPlanDAO.selectWeeklyPlanByEmpMonday(weekly);
		return weeklyPlanId;
	}
	/*
	 * 주간계획이 존재하면 editWeeklyPlan으로..
	 * 존재하지 않으면 inputWeeklyPlan으로...
	 * */
	public ModelAndView checkWeeklyPlan(HttpSession session, String monday) throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		WeeklyPlan weekly=new WeeklyPlan();
		Employee emp=new Employee();
		emp.setEmpId(employee.getEmpId());
		weekly.setEmployee(emp);
		weekly.setMonday(monday);
		String weeklyPlanId=weeklyPlanDAO.selectWeeklyPlanByEmpMonday(weekly);

		Date nowDate=new Date();
		Date monDate=new Date(monday);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
        if(nowDate.compareTo(monDate)<0){
        	//입력 및 수정
        	if(weeklyPlanId==null){
        		mav.setViewName("redirect:/inputWeeklyPlan?empId="+employee.getEmpId()+"&monday="+monday);
        	}else{
        		mav.setViewName("redirect:/editWeeklyPlan?weeklyPlanId="+weeklyPlanId);
        	}
        }else{
        	//조회
        	mav.setViewName("redirect:/viewWeeklyPlan?weeklyPlanId="+weeklyPlanId);
        }
		return mav;
	}
	/*
	 * 계획 삽입
	 * 해당하는 날에 계획을 넣는다.
	 * ModelAndView : -
	 * */
	public String inputPlan(String dailyPlanId, String content)throws Exception{
		Plan plan=new Plan();
		DailyPlan daily=new DailyPlan();
		daily.setDailyPlanId(dailyPlanId);
		plan.setDailyPlan(daily);
		plan.setContent(content);
		plan.setType("0");
		String planId=planDAO.insertPlan(plan);
		return planId;
	}
	/*
	 * 계획 삭제
	 * 선택한 계획을 삭제한다.
	 * ModelAndView : -
	 * */
	public String removePlan(String planId)throws Exception{
		planDAO.deletePlan(planId);
		return "성공";
	}
	/*
	 * 저장버튼 클릭
	 * WeeklyPlan에 저장된 날짜를 불러와 각각의 날짜의 DailyPlanId를 찾는다
	 * 각각의 DailyPlan에 목표금액을 추가한다.
	 * weeklyPlan 에서 날짜와 empId를 가져와서  ?? empId는 왜?
	 * ModelAndView : -
	 * */			// weeklyPlan => monday, empId,
	public ModelAndView saveWeeklyPlan(HttpSession session, String monday, ArrayList<DailyPlan> dailyPlanList)throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		ArrayList<Event> eventList=eventDAO.selectEventList();
		//Calendar
		ArrayList<Plan> planList=weeklyPlanDAO.selectCalendarPlan(employee.getEmpId());
		String empName=planList.get(0).getDailyPlan().getWeeklyPlan().getEmployee().getEmpName();
		mav.addObject("LOGIN_USER", employee);
		mav.addObject("eventList", eventList);
		mav.addObject("planList", planList);
		mav.addObject("empName", empName);

		//Weekly
		WeeklyPlan weeklyPlan=new WeeklyPlan();
		weeklyPlan.setEmployee(employee);
		// weeklyPlan으로 empId 설정
		DailyPlan daily=new DailyPlan();
		daily.setWeeklyPlan(weeklyPlan);

		for(int i=0;i<5;i++){
			DailyPlan dailyPlanSales=dailyPlanList.get(i);
			Long salesGoal=dailyPlanSales.getSalesGoal();
			daily.setPlanDate(dailyPlanSales.getPlanDate());

			// 그 날짜와 empId에 맞는 dailyPlanId 찾기
			String dailyPlanId=dailyPlanDAO.selectDailyPlanId(daily);
			daily.setDailyPlanId(dailyPlanId);
			daily.setSalesGoal(salesGoal);

			dailyPlanDAO.updateDailyPlanSales(daily);

		}
		mav.setViewName("redirect:/weeklyListEmp?empId="+employee.getEmpId()+"&rownum=0");
		return mav;
	}
	/*
	 * 현재날짜를 기준으로 수정가능한 plan이면 true, 수정불가능한 plan이면 false
	 * */
	public boolean dayCompare(String date) throws Exception{
		Date d=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yy/MM/dd");
		Date dateObject=sdf.parse(date);
		int dayOfWeek=dateObject.getDay();
		int dayOfMonth=dateObject.getDate();
		switch(dayOfWeek){
		case 1:
			dateObject.setDate(dayOfMonth);
			break;
		case 2:
			dateObject.setDate(dayOfMonth-1);
			break;
		case 3:
			dateObject.setDate(dayOfMonth-2);
			break;
		case 4:
			dateObject.setDate(dayOfMonth-3);
			break;
		case 5:
			dateObject.setDate(dayOfMonth-4);
			break;
		}
		if(d.compareTo(dateObject)<0){
			return true;
		}
		return false;
	}
	/*
	 * 해당 날짜에 plan을 넣을 수 있는지 확인
	 * */
	public boolean checkDailyPlan(HttpSession session, String planDate) throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		DailyPlan dailyPlan=new DailyPlan();
		WeeklyPlan weeklyPlan=new WeeklyPlan();
		weeklyPlan.setEmployee(employee);
		dailyPlan.setWeeklyPlan(weeklyPlan);
		dailyPlan.setPlanDate(planDate);
		String dailyPlanId=dailyPlanDAO.selectIdByEmpDate(dailyPlan);
		if(dailyPlanId==null){
			return false;
		}else{
			Event event=eventDAO.selectEvent(planDate);
			if(event==null){
				if(dayCompare(planDate)==true){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}
	}
	/*
	 * 달력 클릭시 이벤트 등록
	 * */
	public ModelAndView inputPlanCalendar(HttpSession session, String planDate, String content) throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		DailyPlan dailyPlan=new DailyPlan();
		WeeklyPlan weeklyPlan=new WeeklyPlan();
		weeklyPlan.setEmployee(employee);
		dailyPlan.setWeeklyPlan(weeklyPlan);
		dailyPlan.setPlanDate(planDate);
		//특정한 날짜의 본인의 dailyPlanId 불러오기
		String dailyPlanId=dailyPlanDAO.selectIdByEmpDate(dailyPlan);
		Plan plan=new Plan();
		DailyPlan daily=new DailyPlan();
		daily.setDailyPlanId(dailyPlanId);
		plan.setDailyPlan(daily);
		plan.setType("0");
		plan.setContent(content);
		//plan 추가
		planDAO.insertPlan(plan);
		mav.setViewName("redirect:/calendarPlan");
		return mav;
	}
	/*
	 * Session 정보 불러오기
	 * */
	public String getSessionData(HttpSession session) throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		if("Manager".equals(employee.getPosition())){
			return "Manager";
		}
		return employee.getEmpId();
	}
	/*
	 * 특정 사원의 Plan 불러오기
	 * */
	public ModelAndView calendarGetPlan(HttpSession session, String empId) throws Exception{
		ArrayList<Event> eventList=eventDAO.selectEventList();
		ArrayList<Plan> planList=weeklyPlanDAO.selectCalendarPlan(empId);
		HashMap<String, Object>map=new HashMap<String, Object>();
		if(eventList!=null){
			map.put("Event", eventList);
		}
		if(planList!=null){
			map.put("Plan", planList);
		}
		mav.addObject("JSON", map);
		mav.setViewName("jsonView");
		return mav;
	}
	/*
	 * 특정 부서의 Plan 불러오기(Manager)
	 * */
	public ModelAndView calendarGetPlanManager(HttpSession session) throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		ArrayList<Event> eventList=eventDAO.selectEventList();
		ArrayList<DailyPlan> dailyPlanList=weeklyPlanDAO.selectCalendarManager(employee.getDept().getDeptId());
		HashMap<String, Object>map=new HashMap<String, Object>();
		if(eventList!=null){
			map.put("Event", eventList);
		}
		if(dailyPlanList!=null){
			map.put("DailyPlanList", dailyPlanList);
		}
		mav.addObject("JSON", map);
		mav.setViewName("jsonView");
		return mav;
	}
	/*
	 * 팀원 달력
	 * 달력에서 본인의 모든 plan을 가져와서 달력에 출력
	 * 하나의 일정은 달력의 하나의 event가 됨
	 * Event테이블에서 해당하는 달의 이벤트가 있으면 가져화서 달력에 출력
	 * ModelAndView : ArrayList<Event>, ArrayList<Plan>
	 * */
	public ModelAndView calendarPlan(HttpSession session)throws Exception{
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		ArrayList<Event> eventList=eventDAO.selectEventList();
		ArrayList<Plan> planList=weeklyPlanDAO.selectCalendarPlan(employee.getEmpId());
		mav.addObject("LOGIN_USER", employee);
		mav.addObject("eventList", eventList);
		mav.addObject("planList", planList);
		mav.setViewName("calendar/viewCalendarPlan");
		return mav;
	}
	public ModelAndView viewDailyReport(String empId, String planDate) throws Exception{
		DailyReport dailyReport=new DailyReport();
		Employee emp=new Employee();
		emp.setEmpId(empId);
		dailyReport.setRegDate(planDate);
		dailyReport.setEmployee(emp);
		String dailyReportId=dailyReportDAO.selectDailyReportByEmpDate(dailyReport);
		if(dailyReportId!=null){
			mav.setViewName("redirect:/dailyReport/selectDailyReportView?dailyReportId="+dailyReportId+"&empId="+empId+"&regDate="+planDate);
		}else{
			mav.setViewName("redirect:/viewEmpPlan?empId="+empId+"&planDate="+planDate);
		}
		return mav;
	}
}
