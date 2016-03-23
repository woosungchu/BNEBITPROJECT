package com.bnebit.sms.service;

import java.sql.SQLException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.ConsultingDAO;
import com.bnebit.sms.dao.DailyReportDAO;
import com.bnebit.sms.dao.EmployeeDAO;
import com.bnebit.sms.dao.PlanDAO;
import com.bnebit.sms.dao.WeeklyPlanDAO;
import com.bnebit.sms.vo.Consulting;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Plan;

@Service
public class MainService {
	
	@Autowired
	private ModelAndView mav;
	@Autowired
	private EmployeeDAO employeeDAO;
	@Autowired
	private PlanDAO planDAO;
	@Autowired
	private ConsultingDAO consultingDAO;
	@Autowired
	private DailyReportDAO dailyReportDAO;
	@Autowired
	private WeeklyPlanDAO weeklyPlanDAO;
	
	private Logger log = Logger.getLogger(getClass());

	public ModelAndView followMe(HttpSession session){
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		switch (employee.getPosition()) {
		case "Admin":
			mav.setViewName("redirect:/admin");
			break;
		case "Manager":
			mav.setViewName("index/indexManager");
			//DATA DAO에서 싹 끌어오는 작업
			break;
		case "Salesman":
			getSalesmanData(session);
			mav.setViewName("index/indexSalesman");
			//DATA DAO에서 싹 끌어오는 작업
			break;
		default:
			mav.setViewName("/error/errorPage");
			mav.addObject("MESSAGE","접속한 계정의 직위(position)이 Admin, Manager, Salesman이 아닙니다");
			break;
		}
		return mav;
	}
	
	public void getSalesmanData(HttpSession session){
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		
		//오늘의 일정 
		ArrayList<Plan> planList = planDAO.selectTodayPlan(employee.getEmpId());
			
		//최근 거래처 // Client_Name, Second_Name, CEO, Dept_Name, Position, Emp_Name, phone, address
		ArrayList<Consulting> contractList = consultingDAO.selectContract(employee.getEmpId());
		
		//주간매출액
		int weeklyProfits = dailyReportDAO.selectWeeklyProfits(employee.getEmpId());
		//주간 매출목표액
		int weeklySalesGoal = weeklyPlanDAO.selectWeeklySalesGoal(employee.getEmpId());
		
		//차트// 
		
		//부서연락망 // List<Employee> where dept_id = session.employee.dept_id
		ArrayList<Employee> contactList = 
				employeeDAO.selectEmployeeByDept(employee.getDept().getDeptId());
		
		mav.addObject("planList", planList);
		mav.addObject("contractList", contractList);
		mav.addObject("contactList", contactList);
		mav.addObject("weeklyProfits", weeklyProfits);
		mav.addObject("weeklySalesGoal", weeklySalesGoal);
	}
	
	public Map<String, Object> getManagerData(){
		Map<String, Object> map = new HashMap<>();
		//주간일정
		
		//최근 거래처
		
		//차트
		
		//부서연락망
		
		return map;
	}

	public ModelAndView planCheck(String planId, String checked) {
		planDAO.updateType(planId,checked);
		
		mav.addObject("JSON", "success");
		mav.setViewName("jsonView");
		return mav;
	}



	
	
}
