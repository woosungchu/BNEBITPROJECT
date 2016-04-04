package com.bnebit.sms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.MessageService;
import com.bnebit.sms.util.page.PageSet;
import com.bnebit.sms.vo.Employee;

@Controller
@RequestMapping("/message")
public class MessageController {

	@Autowired
	private MessageService messageService;


	/**
	 * 받은 메시지 목록 조회 및 페이지로 이동
	 *
	 * @param pageSet
	 * @param session
	 */
	@RequestMapping(value = "/receiveMessageList", method = RequestMethod.GET)
	public ModelAndView receiveMessageList(PageSet pageSet, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");

		mav.addObject("pageInfo", messageService.receiveMessageList(pageSet, employee));
		mav.setViewName("message/receiveMessageList");
		return mav;
	}

	/**
	 * 보낸 메시지 목록 조회 및 페이지로 이동
	 *
	 * @param pageSet
	 * @param session
	 */
	@RequestMapping(value = "/sendMessageList", method = RequestMethod.GET)
	public ModelAndView sendMessageList(PageSet pageSet, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");

		mav.addObject("pageInfo", messageService.sendMessageList(pageSet, employee));
		mav.setViewName("message/sendMessageList");
		return mav;
	}
}
