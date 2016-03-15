package com.bnebit.sms.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.AdminEmployeeService;
import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.Employee;

@Controller
@RequestMapping(value = "/admin/employee")
public class AdminEmployeeController {

	@Autowired
	private AdminEmployeeService service;


	// ********************************************** Employee ********************************************************** //
	@RequestMapping(value = "/employeeList", method = RequestMethod.GET)
	public ModelAndView employeeList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav = service.configHistoryPageEmployeeList(session);
		return mav;
	}

	@RequestMapping(value="/viewEmployee", method = RequestMethod.GET)
	public ModelAndView viewDailyReport(String empId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.getEmployee(empId, session);
		return mav;
	}

	@RequestMapping(value = "/getEmployeeListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Employee> getEmployeeListJsonData(PageOption<Employee> pageOption, @RequestParam("_search") String search, HttpSession session) throws Exception {
		return service.getPageOptionEmployeeList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteEmployeeList", method = RequestMethod.GET)
	public void deleteEmloyeeList(@RequestParam(value="ids") String[] ids) throws SQLException {
		service.removeEmployeeList(ids);
	}

	@RequestMapping(value = "/deleteEmployee", method = RequestMethod.GET)
	public ModelAndView deleteEmployee(String id, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeEmployee(id, session);
		return mav;
	}
	// ****************************************************************************************************************** //
}
