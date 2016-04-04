package com.bnebit.sms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.ChartDAO;
import com.bnebit.sms.dao.EmployeeDAO;
import com.bnebit.sms.vo.Chart;
import com.bnebit.sms.vo.Employee;

@Service
public class ChartService {

	@Autowired
	private ChartDAO chartDAO;
	@Autowired
	private EmployeeDAO employeeDAO;
	@Autowired
	private ModelAndView mav;

	// 매출 달성율 차트
	public ModelAndView profitRateChart(HttpSession session, String chartType, String type, String empId) throws SQLException {
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if("Manager".equals(employee.getPosition())){
			paramMap.put("chartType", chartType);
			if("1".equals(chartType)){
				paramMap.put("deptId", employee.getDept().getDeptId());
			}else if("2".equals(chartType)){
				paramMap.put("empId", empId);
			}
		}else{
			paramMap.put("chartType", "2");
			paramMap.put("empId", employee.getEmpId());
		}
		paramMap.put("key", type);
		ArrayList<Chart> profitRateList = (ArrayList<Chart>) chartDAO.profitRateChart(paramMap);
		mav.addObject("JSON",profitRateList);
		mav.setViewName("jsonView");
		return mav;
	}

	// 매출액, 매출목표 차트
	public ModelAndView profitChart(HttpSession session, String chartType, String type, String empId) throws SQLException {
		Employee employee=(Employee)session.getAttribute("LOGIN_USER");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if("Manager".equals(employee.getPosition())){
			paramMap.put("chartType", chartType);
			if("1".equals(chartType)){
				paramMap.put("deptId", employee.getDept().getDeptId());
			}else if("2".equals(chartType)){
				paramMap.put("empId", empId);
			}
		}else{
			paramMap.put("chartType", "2");
			paramMap.put("empId", employee.getEmpId());
		}
		paramMap.put("key", type);
		ArrayList<Chart> salesGoalList=(ArrayList<Chart>) chartDAO.salesGoalChart(paramMap);
		ArrayList<Chart> profitList = (ArrayList<Chart>) chartDAO.profitChart(paramMap);
		HashMap<String, ArrayList<Chart>> map=new HashMap<String, ArrayList<Chart>> ();
		map.put("SalesGoal", salesGoalList);
		map.put("Profit", profitList);

		mav.addObject("JSON",map);
		mav.setViewName("jsonView");
		return mav;
	}

	// 주행거리 차트
	public ModelAndView distanceChart(HttpSession session, String chartType, String type, String empId) throws SQLException {
		Employee employee=(Employee) session.getAttribute("LOGIN_USER");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if("Manager".equals(employee.getPosition())){
			paramMap.put("chartType", chartType);
			if("1".equals(chartType)){
				paramMap.put("deptId", employee.getDept().getDeptId());
			}else if("2".equals(chartType)){
				paramMap.put("empId", empId);
			}
		}else{
			paramMap.put("chartType", "2");
			paramMap.put("empId", employee.getEmpId());
		}
		paramMap.put("key", type);
		ArrayList<Chart> distanceList = (ArrayList<Chart>) chartDAO.distanceChart(paramMap);

		mav.addObject("JSON", distanceList);
		mav.setViewName("jsonView");
		return mav;
	}

	// 부서에 속하는 모든 empName 불러오기
	public ModelAndView selectEmployeeByDept(HttpSession session) throws Exception{
		Employee employee=(Employee) session.getAttribute("LOGIN_USER");
		ArrayList<Employee>empList=employeeDAO.selectEmployeeByDept(employee.getDept().getDeptId());
		mav.addObject("JSON", empList);
		mav.setViewName("jsonView");
		return mav;
	}

	public ModelAndView viewChart(HttpSession session) throws Exception{
		Employee employee=(Employee) session.getAttribute("LOGIN_USER");
		if("Manager".equals(employee.getPosition())){
			mav.setViewName("chart/viewChartManager");
		}else{
			mav.setViewName("chart/viewChart");
		}
		return mav;
	}
}
