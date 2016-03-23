package com.bnebit.sms.controller;

import java.lang.reflect.Type;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.WeeklyPlanService;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.Plan;
import com.bnebit.sms.vo.WeeklyPlan;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
public class WeeklyController {

	@Autowired
	private WeeklyPlanService weeklyService;
	/*
	 * 한 사원의 주간계획 리스트를 조회
	 * viewWeeklyList.jsp 페이지로 이동
	 * */
	@RequestMapping(value="weeklyListEmp")
	public ModelAndView weeklyListEmp(HttpSession session, String empId, int rownum)throws Exception{
		ModelAndView mav=weeklyService.weeklyListEmp(session, empId, rownum);
		return mav;
	}
	/*
	 * 같은 부서에 속하는 모든 주간계획 리스트를 조회
	 * viewWeeklyListManager.jsp 페이지로 이동
	 * */
	@RequestMapping(value="weeklyList")
	public ModelAndView weeklyList(HttpSession session, String deptId, int rownum)throws Exception{
		ModelAndView mav=weeklyService.weeklyList(session, deptId, rownum);
		return mav;
	}
	/*
	 * 같은 부서에서 한 주에 속하는 주간계획 리스트 조회
	 * viewWeeklyListManager.jsp 페이지로 이동
	 * */
	@RequestMapping(value="weeklyListWeek")
	public ModelAndView weeklyListWeek(HttpSession session, String deptId, String monday, int rownum)throws Exception{
		ModelAndView mav=weeklyService.weeklyListWeek(session, deptId, monday, rownum);
		return mav;
	}
	/*
	 * 주간계획 조회
	 * viewWeeklyPlan.jsp 페이지로 이동
	 * */////////////////////////////////////////////////////////////////////////////////////////////
	@RequestMapping(value="viewWeeklyPlan")
	public ModelAndView viewWeeklyPlan(HttpSession session, String weeklyPlanId)throws Exception{
		ModelAndView mav = weeklyService.viewWeeklyPlan(session, weeklyPlanId);
		return mav;
	}
	/////////////////////////////////////////////////////////ajax!!!!!!!!!!!
	@RequestMapping(value="viewPlan")
	public ModelAndView viewPlan(String empId, String planDate) throws Exception{
		ModelAndView mav=weeklyService.viewPlan(empId, planDate);
		return mav;
	}
	/*
	 * 주간계획 입력 화면으로 접근
	 * insertWeeklyPlan.jsp 페이지로 접근
	 * *////////////////////////////////////////////////////////// 매개변수 WeeklyPlan weeklyPlan => String empId, String title, String monday
	@RequestMapping(value="inputWeeklyPlan")
	public ModelAndView inputWeeklyPlan(HttpSession session, String empId, String monday)throws Exception{
		ModelAndView mav=weeklyService.inputWeeklyPlan(session, empId, monday);
		return mav;
	}
	/*
	 * 주간계획이 존재하는지 확인
	 * */
	@RequestMapping(value="checkWeeklyPlan")
	public ModelAndView checkWeeklyPlan(String empId, String monday) throws Exception{
		ModelAndView mav=weeklyService.checkWeeklyPlan(empId, monday);
		return mav;
	}
	/*
	 * 주간계획 수정
	 * */
	@RequestMapping(value="editWeeklyPlan")
	public ModelAndView editWeeklyPlan(HttpSession session, String weeklyPlanId) throws Exception{
		ModelAndView mav=weeklyService.editWeeklyPlan(session, weeklyPlanId);
		return mav;
	}
	/*
	 * 계획 삽입
	 *
	 * */
	@RequestMapping(value="inputPlan")
	public ModelAndView inputPlan(String dailyPlanId, String content)throws Exception{
		Plan plan=new Plan();
		DailyPlan daily=new DailyPlan();
		daily.setDailyPlanId(dailyPlanId);
		plan.setDailyPlan(daily);
		plan.setContent(content);
		plan.setType("0");
		System.out.println(plan);
		ModelAndView mav=weeklyService.inputPlan(plan);
		return mav;
	}
	/*
	 * 계획 삭제
	 *
	 * */
	@RequestMapping(value="removePlan")
	public ModelAndView removePlan(String planId)throws Exception{
		ModelAndView mav=weeklyService.removePlan(planId);
		return mav;
	}
	/*
	 * 저장버튼 클릭
	 * viewWeeklyPlanList.jsp 페이지로 이동
	 * */
	@RequestMapping(value="saveWeeklyPlan")
	public ModelAndView saveWeeklyPlan(@RequestParam("monday") String monday, @RequestParam("dailyPlanList") String dailyPlanListJson, HttpSession session) throws Exception{
			System.out.println(monday);
		Gson gson = new Gson();
		Type type = new TypeToken<ArrayList<DailyPlan>>() {}.getType();
		ArrayList<DailyPlan> dailyPlanList = gson.fromJson(dailyPlanListJson, type);

		ModelAndView mav=weeklyService.saveWeeklyPlan(monday, dailyPlanList, session);
		return mav;
	}
	/*
	 * 팀장 달력조회
	 * viewCalendarLeader.jsp 페이지로 이동
	 * */
	@RequestMapping(value="calendarLeader")
	public ModelAndView calendarLeader(String deptId)throws Exception{
		ModelAndView mav=weeklyService.calendarLeader(deptId);
		return mav;
	}
	@RequestMapping(value="checkDailyPlan")
	public ModelAndView checkDailyPlan(String empId, String planDate) throws Exception{
		ModelAndView mav=weeklyService.checkDailyPlan(empId, planDate);
		return mav;
	}
	@RequestMapping(value="inputPlanCalendar")
	public ModelAndView inputPlanCalendar(String empId, String planDate, String content) throws Exception{
		ModelAndView mav=weeklyService.inputPlanCalendar(empId, planDate, content);
		return mav;
	}
	@RequestMapping(value="calendarGetPlan")
	public ModelAndView calendarGetPlan(String empId) throws Exception{
		ModelAndView mav=weeklyService.calendarGetPlan(empId);
		return mav;
	}
	/*
	 * 팀원 달력조회
	 * viewCalendarPlan.jsp 페이지로 이동
	 * */
	@RequestMapping(value="calendarPlan")
	public ModelAndView calendarPlan(HttpSession session, String empId)throws Exception{
		ModelAndView mav=weeklyService.calendarPlan(session, empId);
		return mav;
	}

}
