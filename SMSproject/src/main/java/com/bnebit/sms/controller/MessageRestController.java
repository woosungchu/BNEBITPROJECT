package com.bnebit.sms.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bnebit.sms.service.MessageService;
import com.bnebit.sms.util.RestResult;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Message;

@RestController
@RequestMapping("/rest/message")
public class MessageRestController {

	@Autowired
	private MessageService messageService;

	@RequestMapping(value = "/insertMessage", method = RequestMethod.POST)
	public RestResult insertMessage(Message message) {
		RestResult result = new RestResult();
		String code = "success";
		try {
			messageService.insertMessage(message);
		} catch(Exception e) {
			code = "fail";
			result.setMessage("server error!!! 관리자에게 문의바랍니다");
		}
		result.setCode(code);
		return result;
	}

	@RequestMapping(value = "/searchEmployee" , method = RequestMethod.GET)
	public List<Employee> searchEmployee(String searchName, HttpSession session) {
		Employee loginEmployee = (Employee) session.getAttribute("LOGIN_USER");
		return messageService.searchEmployee(searchName, loginEmployee);
	}

	@RequestMapping(value = "/selectUncheckedMessageConut", method = RequestMethod.GET)
	public int selectUncheckedMessageConut(HttpSession session) {
		Employee loginEmployee = (Employee) session.getAttribute("LOGIN_USER");
		return messageService.selectUncheckedMessageConut(loginEmployee);
	}

	@RequestMapping(value = "/updateReadMessage", method = RequestMethod.POST)
	public RestResult updateReadMessage(String msgId) {
		RestResult result = new RestResult();
		String code = "success";
		try {
			messageService.updateReadMessage(msgId);
		} catch(Exception e) {
			code = "fail";
			result.setMessage("server error!!! 관리자에게 문의바랍니다");
		}
		result.setCode(code);
		return result;
	}
}
