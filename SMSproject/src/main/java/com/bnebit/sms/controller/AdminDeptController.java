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

import com.bnebit.sms.service.AdminDeptService;
import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.Dept;

@Controller
@RequestMapping(value = "/admin/dept")
public class AdminDeptController {

	@Autowired
	private AdminDeptService service;


	// ********************************************** Employee ********************************************************** //
	@RequestMapping(value = "/deptList", method = RequestMethod.GET)
	public ModelAndView deptList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav = service.configHistoryPageDeptList(session);
		return mav;
	}

	@RequestMapping(value="/addDept", method = RequestMethod.POST)
	public @ResponseBody void addDept(Dept dept, HttpSession session) throws Exception {
		service.addDept(dept,session);
	}

	/*@RequestMapping(value="/updateEmployee", method = RequestMethod.POST)
	public ModelAndView updateEmployee(@ModelAttribute Employee employee,
													   BindingResult bindingResult,
									   @RequestParam("file") MultipartFile file,
									   				   String inputNoImage,
									   				   HttpSession session) throws SQLException, IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();
		mav = service.updateEmployee(employee,bindingResult,file,inputNoImage,session);
		return mav;
	}*/

	@RequestMapping(value = "/getDeptListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Dept> getDeptListJsonData(PageOption<Dept> pageOption,
																	  @RequestParam("_search") String search,
																	  HttpSession session) throws Exception {
		return service.getPageOptionDeptList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteDeptList", method = RequestMethod.POST)
	public @ResponseBody void deleteDeptList(@RequestParam(value="ids[]") String[] ids, HttpSession session) throws SQLException {
		service.removeDeptList(ids);
	}

	/*@RequestMapping(value = "/deleteEmployee", method = RequestMethod.GET)
	public ModelAndView deleteEmployee(String empId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeEmployee(empId, session);
		return mav;
	}*/

	// ****************************************************************************************************************** //
}
