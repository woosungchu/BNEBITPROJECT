package com.bnebit.sms.service;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.DailyPlanDAO;
import com.bnebit.sms.dao.EventDAO;
import com.bnebit.sms.dao.PlanDAO;
import com.bnebit.sms.dao.WeeklyPlanDAO;
import com.bnebit.sms.vo.DailyPlan;
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
	private ModelAndView mav;


	/*
	 * 한 사원이 작성한 모든 주간계획을 리스트로 조회
	 * empId가 일치하는 모든 주간계획을 불러온다.
	 * ModelAndView : ArrayList<WeeklyPlan>
	 * */
	public ModelAndView weeklyListEmp(String empId, int rownum)throws Exception{
		//Employee employee=(Employee) session.getAttribute("LOGIN_USER");
		ArrayList<WeeklyPlan> weeklyList=weeklyPlanDAO.selectWeeklyPlanListEmp(empId, rownum);
		mav.addObject("weeklyList", weeklyList);
		mav.addObject("page", "weeklyListEmp");
		//if("Manager".equals(employee.getPosition())){
		//	mav.setViewName("weekly/viewWeeklyListManager");
		//}else{
			mav.setViewName("main/weekly/viewWeeklyList");
		//}
		return mav;
	}
	/*
	 * 팀원 전체가 작성한 모든 주간계획을 리스트로 조회
	 * deptId가 일치하는 모든 주간계획을 불러온다.
	 * ModelAndView : ArrayList<WeeklyPlan>
	 * */
	public ModelAndView weeklyList(String deptId, int rownum)throws Exception{
		ArrayList<WeeklyPlan> weeklyList=weeklyPlanDAO.selectWeeklyPlanListManager(deptId, rownum);
		mav.addObject("weeklyList", weeklyList);
		mav.addObject("page", "weeklyList");
		mav.setViewName("main/weekly/viewWeeklyListManager");
		return mav;
	}
	/*
	 * 팀원중에서 특정한 주에 작성한 모든 주간계획을 리스트로 조회
	 * WeeklyPlan에 저장된 deptId와 monday가 일치하는 모든 주간계획을 불러온다.
	 * ModelAndView : ArrayList<WeeklyPlan>
	 * */
	public ModelAndView weeklyListWeek(WeeklyPlan weeklyPlan, int rownum)throws Exception{
		ArrayList<WeeklyPlan> weeklyList=weeklyPlanDAO.selectWeeklyPlanListWeek(weeklyPlan, rownum);
		mav.addObject("weeklyList", weeklyList);
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
	public ModelAndView viewWeeklyPlan(String weeklyPlanId) throws Exception {
		//Employee employee=(Employee) session.getAttribute("LOGIN_USER");
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

		mav.addObject("dailyPlanList", dailyPlanList);
		mav.addObject("weeklyPlan", weekly);
		WeeklyPlan wPlan=weeklyPlanDAO.selectWeeklyETC(weeklyPlanId);
		//팀장일때는 조회시 checked를 1로 변경
		//if("Manager".equals(employee.getPosition())){
			weeklyPlanDAO.updateWeeklyChecked1(wPlan);
		//}
		mav.setViewName("main/weekly/viewWeeklyPlan");
		return mav;
	}
	public ModelAndView viewPlan(String empId, String planDate) throws Exception{
		Event event=eventDAO.selectEvent(planDate);
		DailyPlan dailyPlan=new DailyPlan();
		WeeklyPlan weekly=new WeeklyPlan();
		Employee employee=new Employee();
		employee.setEmpId(empId);
		weekly.setEmployee(employee);
		dailyPlan.setWeeklyPlan(weekly);
		if(event!=null){
			mav.addObject("JSON", event);
		}else{
			dailyPlan.setPlanDate(planDate);
			ArrayList<Plan> planList=planDAO.selectPlan(dailyPlan);
			if(planList!=null){
				mav.addObject("JSON", planList);
				//hashPlanList에 planList 추가시키기
			}else{
			}
		}
		mav.setViewName("jsonView");
		return mav;
	}
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
			week=(wedDay-1)/7;
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
	public ModelAndView inputWeeklyPlan(String empId, String monday)throws Exception{
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

		// 월~금의 event를 담을 객체 : eventList
		ArrayList<Event>eventList=new ArrayList<Event>();
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
		mav.addObject("eventList", eventList);
		mav.addObject("dailyPlanList", dailyPlanList);
		mav.setViewName("main/weekly/inputWeeklyPlan");
		return mav;
	}
	/*
	 * 주간계획 수정
	 * */
	public ModelAndView editWeeklyPlan(String weeklyPlanId)throws Exception{
		//Employee employee=(Employee) session.getAttribute("LOGIN_USER");
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

		mav.addObject("dailyPlanList", dailyPlanList);
		mav.addObject("weeklyPlan", weekly);
		mav.setViewName("main/weekly/inputWeeklyPlan");
		return mav;
	}
	/*
	 * 주간계획이 존재하면 editWeeklyPlan으로..
	 * 존재하지 않으면 inputWeeklyPlan으로...
	 * */
	public ModelAndView checkWeeklyPlan(String empId, String monday) throws Exception{
		WeeklyPlan weekly=new WeeklyPlan();
		Employee emp=new Employee();
		emp.setEmpId(empId);
		weekly.setEmployee(emp);
		weekly.setMonday(monday);
		String weeklyPlanId=weeklyPlanDAO.selectWeeklyPlanByEmpMonday(weekly);
		if(weeklyPlanId==null){
			mav.setViewName("redirect:/inputWeeklyPlan?empId="+empId+"&monday="+monday);
		}else{
			mav.setViewName("redirect:/editWeeklyPlan?weeklyPlanId="+weeklyPlanId);
		}
		return mav;
	}
	/*
	 * 계획 삽입
	 * 해당하는 날에 계획을 넣는다.
	 * ModelAndView : -
	 * */
	public ModelAndView inputPlan(Plan plan)throws Exception{
		String planId=planDAO.insertPlan(plan);
		String weeklyPlanId=weeklyPlanDAO.selectWeeklyPlanByPlan(planId);
		mav.setViewName("redirect:/editWeeklyPlan?weeklyPlanId="+weeklyPlanId);
		return mav;
	}
	/*
	 * 계획 삭제
	 * 선택한 계획을 삭제한다.
	 * ModelAndView : -
	 * */
	public ModelAndView removePlan(String planId)throws Exception{
		String weeklyPlanId=weeklyPlanDAO.selectWeeklyPlanByPlan(planId);
		planDAO.deletePlan(planId);
		mav.setViewName("redirect:/editWeeklyPlan?weeklyPlanId="+weeklyPlanId);
		return mav;
	}
	/*
	 * 저장버튼 클릭
	 * WeeklyPlan에 저장된 날짜를 불러와 각각의 날짜의 DailyPlanId를 찾는다
	 * 각각의 DailyPlan에 목표금액을 추가한다.
	 * weeklyPlan 에서 날짜와 empId를 가져와서  ?? empId는 왜?
	 * ModelAndView : -
	 * */
	public ModelAndView saveWeeklyPlan(WeeklyPlan weeklyPlan, HashMap<String, Long> sales)throws Exception{
		// 매개변수로 Weekly Plan 받아서 날짜로 Daily Plan 찾기
		String monday=weeklyPlan.getMonday();

		// weeklyPlan으로 empId 설정
		DailyPlan daily=new DailyPlan();
		daily.setWeeklyPlan(weeklyPlan);

		//weeklyPlan에 저장된 monday를 이용해서 dailyPlan에 들어갈 날짜 찾기
		DateFormat format=new SimpleDateFormat("yy/MM/dd");
		Date date=format.parse(weeklyPlan.getMonday());
		for(int i=0;i<5;i++){
			String dateString=format.format(date);
			Long salesGoal=sales.get(dateString);
			// 목표금액이 없으면 salesGoal이 null! null 아닐때 업데이트
			if(salesGoal!=null){
				// planDate 설정
				daily.setPlanDate(dateString);
				// 그 날짜와 empId에 맞는 dailyPlanId 찾기
				String dailyPlanId=dailyPlanDAO.selectDailyPlanId(daily);
				DailyPlan dailyPlan=new DailyPlan();
				// dailyPlanId와 salesGoal으로 dailyPlan 업데이트하기
				dailyPlan.setDailyPlanId(dailyPlanId);
				dailyPlan.setSalesGoal(salesGoal);

				dailyPlanDAO.updateDailyPlanSales(dailyPlan);
			}
			// 하루 미루기
			long time=date.getTime();
			time+=24*60*60*1000;
			date.setTime(time);
		}
		return mav;
	}
	/*
	 * 주의 : dailyPlan 의 planDate는 그 달의 첫날로 한다.
	 * 팀장 달력
	 * 달력에서 한 달의 모든 event와 plan을 가지고 있는 사원의 이름을 중복되지않게 달력에 출력
	 * ModelAndView : ArrayList<Event>, ArrayList<DailyPlan>
	 * */
	public ModelAndView calendarLeader(DailyPlan dailyPlan)throws Exception{
		//deptId, planDate
		ArrayList<Event> eventList=eventDAO.selectEventMonth(dailyPlan.getPlanDate());
		ArrayList<DailyPlan> dailyPlanList=weeklyPlanDAO.selectCalendarManager(dailyPlan);
		mav.addObject("eventList", eventList);
		mav.addObject("dailyPlanList", dailyPlanList);
		return mav;
	}
	/*
	 * 팀원 달력
	 * 달력에서 본인의 모든 plan을 가져와서 달력에 출력
	 * 하나의 일정은 달력의 하나의 event가 됨
	 * Event테이블에서 해당하는 달의 이벤트가 있으면 가져화서 달력에 출력
	 * ModelAndView : ArrayList<Event>, ArrayList<Plan>
	 * */
	public ModelAndView calendarPlan(DailyPlan dailyPlan)throws Exception{
		ArrayList<Event> eventList=eventDAO.selectEventMonth(dailyPlan.getPlanDate());
		ArrayList<Plan> planList=weeklyPlanDAO.selectCalendarPlan(dailyPlan);
		mav.addObject("eventList", eventList);
		mav.addObject("planList", planList);
		return mav;
	}
}
