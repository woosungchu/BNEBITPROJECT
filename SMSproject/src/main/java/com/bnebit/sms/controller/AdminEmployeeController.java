package com.bnebit.sms.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
	public ModelAndView viewEmployee(String empId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.getEmployee(empId, session);
		return mav;
	}

	@RequestMapping(value="/viewEmployeeAddForm", method = RequestMethod.GET)
	public ModelAndView viewEmployeeAddForm(HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.viewEmployeeAddForm(session);
		return mav;
	}

	@RequestMapping(value="/viewEmployeeUpdateForm", method = RequestMethod.GET)
	public ModelAndView viewEmployeeUpdateForm(String empId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.viewEmployeeUpdateForm(empId);
		return mav;
	}

	@RequestMapping(value="/addEmployee", method = RequestMethod.POST)
	public ModelAndView addEmployee(@ModelAttribute Employee employee,
													BindingResult bindingResult,
							        @RequestParam("file") MultipartFile file,
							        HttpSession session) throws SQLException, IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();
		mav = service.addEmployee(employee,bindingResult,file,session);
		return mav;
	}

	@RequestMapping(value="/updateEmployee", method = RequestMethod.POST)
	public ModelAndView updateEmployee(@ModelAttribute Employee employee,
													   BindingResult bindingResult,
									   @RequestParam("file") MultipartFile file,
									   				   String inputNoImage,
									   				   HttpSession session) throws SQLException, IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();
		mav = service.updateEmployee(employee,bindingResult,file,inputNoImage,session);
		return mav;
	}

	@RequestMapping(value = "/getEmployeeListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Employee> getEmployeeListJsonData(PageOption<Employee> pageOption,
																	  @RequestParam("_search") String search,
																	  HttpSession session) throws Exception {
		return service.getPageOptionEmployeeList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteEmployeeList", method = RequestMethod.GET)
	public void deleteEmployeeList(@RequestParam(value="ids") String[] ids, HttpSession session) throws SQLException {
		service.removeEmployeeList(ids);
	}

	@RequestMapping(value = "/deleteEmployee", method = RequestMethod.GET)
	public ModelAndView deleteEmployee(String empId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeEmployee(empId, session);
		return mav;
	}

	@RequestMapping(value = "/configEmailDuplicate", method = RequestMethod.POST)
	public @ResponseBody String configEmailDuplicate(String email) throws Exception {
		return service.getEmailDuplicateResult(email);
	}
	// ****************************************************************************************************************** //
}
