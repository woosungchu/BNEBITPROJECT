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

import com.bnebit.sms.dao.ClientDAO;
import com.bnebit.sms.dao.ConsultingDAO;
import com.bnebit.sms.dao.DailyReportDAO;
import com.bnebit.sms.dao.EmployeeDAO;
import com.bnebit.sms.dao.PlanDAO;
import com.bnebit.sms.dao.WeeklyPlanDAO;
import com.bnebit.sms.vo.Client;
import com.bnebit.sms.vo.Consulting;
import com.bnebit.sms.vo.DailyReport;
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
	@Autowired
	private ClientDAO clientDAO;
	
	private Logger log = Logger.getLogger(getClass());
	private static final int ROWNUM = 10;
	private static final int FIRST_PAGE = 1;

	public ModelAndView followMe(HttpSession session){
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		switch (employee.getPosition()) {
		case "Admin":
			mav.setViewName("redirect:/admin");
			break;
		case "Manager":
			getManagerData(session);
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
		
		//주간매출액 //주간 매출목표액
		int weeklyProfits = 0;
		int weeklySalesGoal = 0;
		try {
			weeklyProfits = dailyReportDAO.selectWeeklyProfits(employee.getEmpId());
			weeklySalesGoal = weeklyPlanDAO.selectWeeklySalesGoal(employee.getEmpId());
		} catch (Exception e) {
			log.info("이 세션에 저장된 유저의 지난 매출 관련 기록이 없습니다");
		}
		
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
	
	public void getManagerData(HttpSession session){
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		
		//각 팀원들 오늘 일정 갯수
		ArrayList<Employee> salesmanList = employeeDAO.selectSalesmanList(employee.getDept().getDeptId());
		
		//부서연락망
		ArrayList<Employee> contactList = 
				employeeDAO.selectEmployeeByDept(employee.getDept().getDeptId());
		
		int weeklyProfits = 0;
		int weeklySalesGoal = 0;
		//부서주간매출
		try {
			weeklyProfits = dailyReportDAO.selectWeeklyProfitsManager(employee.getDept().getDeptId());
			weeklySalesGoal = weeklyPlanDAO.selectWeeklySalesGoalManager(employee.getDept().getDeptId());
		} catch (Exception e) {
			log.info("이 세션에 저장된 유저의 지난 매출 관련 기록이 없습니다");
		}
		
		//차트
		
		//최근 거래처 //not tested elsa밖에 없음
		ArrayList<Consulting> contractList = 
				consultingDAO.selectContractManager(employee.getDept().getDeptId());
		
		mav.addObject("salesmanList", salesmanList);
		mav.addObject("contactList", contactList);
		mav.addObject("contractList", contractList);
		mav.addObject("weeklyProfits", weeklyProfits);
		mav.addObject("weeklySalesGoal", weeklySalesGoal);
	}

	public ModelAndView planCheck(String planId, String checked) {
		planDAO.updateType(planId,checked);
		
		mav.addObject("JSON", "success");
		mav.setViewName("jsonView");
		return mav;
	}

	public ModelAndView staffInfo(String empId, HttpSession session) {
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		Employee staff = employeeDAO.selectEmpById(empId);
//		System.out.println(staff);
//		System.out.println(staff.getDept().getDeptId());
		if(!employee.getDept().getDeptId().equals(staff.getDept().getDeptId())){
			throw new RuntimeException("악의적인 의도로 접근한 사용자를 잡았습니다");
		}
		mav.addObject("JSON", staff);
		mav.setViewName("jsonView");
		return mav;
	}

	public ModelAndView countPlan(HttpSession session) {
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		ArrayList<HashMap<String,String>> planList = 
				planDAO.selectTodayDeptPlan(employee.getDept().getDeptId());
		
		mav.addObject("JSON", planList);
		mav.setViewName("jsonView");
		return mav;
	}

	public ModelAndView searchKeyword(String keyword, HttpSession session) {
		String[] keywordList = keyword.split(" ");
		Employee employee= (Employee) session.getAttribute("LOGIN_USER");
		String empId = employee.getEmpId();
		String deptId = employee.getDept().getDeptId();
		
		//공통
		//1.직원
		ArrayList<Employee> empList = 
				employeeDAO.searchEmployee(deptId ,keywordList, ROWNUM, FIRST_PAGE);
		//2.거래처
		ArrayList<Client> clientList = clientDAO.searchClient(keywordList, ROWNUM, FIRST_PAGE);
		
		//3.일일보고
		//4.일정
		//5.상담일지
		ArrayList<DailyReport> reportList = new ArrayList<DailyReport>();
		ArrayList<Plan> planList = new ArrayList<Plan>();
		ArrayList<Consulting> consultingList = new ArrayList<Consulting>();
		//직원
		if(employee.getPosition().equals("Salesman")){
			reportList = dailyReportDAO.searchDailyReport(empId, keywordList, ROWNUM, FIRST_PAGE);
			planList = planDAO.searchPlan(empId, keywordList, ROWNUM, FIRST_PAGE);
			consultingList = consultingDAO.searchConsulting(empId, keywordList, ROWNUM, FIRST_PAGE);
		}else{
			//팀장
			reportList = dailyReportDAO.searchDailyReportByDept(deptId, keywordList, ROWNUM, FIRST_PAGE);
			planList = planDAO.searchPlanByDept(deptId, keywordList, ROWNUM, FIRST_PAGE);
			consultingList = consultingDAO.searchConsultingByDept(deptId, keywordList, ROWNUM, FIRST_PAGE);
		}
		
		mav.addObject("consultingList", consultingList);
		mav.addObject("reportList", reportList);
		mav.addObject("clientList", clientList);
		mav.addObject("empList", empList);
		mav.addObject("planList", planList);
		mav.addObject("keyword", keyword);
		mav.setViewName("/include/searchResult");
		return mav;
	}

	public ModelAndView morePage( String list ,String keyword, int page, HttpSession session) {
		Map <String,Object> map = new HashMap<String,Object>();
		String[] keywordList = keyword.split(" ");
		
		Employee employee= (Employee) session.getAttribute("LOGIN_USER");
		String empId = employee.getEmpId();
		String deptId = employee.getDept().getDeptId();
		String position = employee.getPosition();
		
		switch (list) {
		case "empList":
			ArrayList<Employee> empList = 
			employeeDAO.searchEmployee(deptId ,keywordList, ROWNUM, page);
			map.put("list", empList);
			break;
		case "planList":
			ArrayList<Plan> planList = 
			planDAO.searchPlan(empId,keywordList, ROWNUM, page);
			map.put("list", planList);
			break;
		case "clientList":
			ArrayList<Client> clientList = clientDAO.searchClient(keywordList, ROWNUM, page);
			map.put("list", clientList);
			break;
		case "reportList":
			ArrayList<DailyReport> reportList = new ArrayList<DailyReport>();
			if(position.equals("Salesman")){
				reportList = dailyReportDAO.searchDailyReport(empId, keywordList, ROWNUM, page);
			}else{
				reportList = dailyReportDAO.searchDailyReportByDept(deptId, keywordList, ROWNUM, page);
			}
			map.put("list", reportList);
			break;
		case "consultingList":
			ArrayList<Consulting> consultingList = new ArrayList<Consulting>();
			if(position.equals("Salesman")){
				consultingList = consultingDAO.searchConsulting(empId, keywordList, ROWNUM, page);
			}else{
				consultingList = consultingDAO.searchConsultingByDept(deptId, keywordList, ROWNUM, page);
			}
			map.put("list", consultingList);
			break;
		default:
			throw new RuntimeException("잘못된 list-data 값입니다.");
		}
		map.put("user", employee);
		mav.addObject("JSON", map);
		mav.setViewName("jsonView");
		return mav;
	}



	
	
}
