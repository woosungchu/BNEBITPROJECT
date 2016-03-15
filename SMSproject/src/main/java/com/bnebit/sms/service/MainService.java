package com.bnebit.sms.service;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.EmployeeDAO;
import com.bnebit.sms.vo.Employee;

@Service
public class MainService {
	
	@Autowired
	private ModelAndView mav;
	@Autowired
	private EmployeeDAO employeeDAO;
	
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
	
	
}
