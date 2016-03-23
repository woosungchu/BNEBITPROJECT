package com.bnebit.sms.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.ClientService;
import com.bnebit.sms.util.page.PageSet;

@Controller
@SessionAttributes("clientUpdateInfo")
@RequestMapping("/client")
public class ClientController {

	@Autowired
	private ClientService clientService;

	@RequestMapping(value = "/clientUpdate", method = RequestMethod.GET)
	public ModelAndView clientUpdate(PageSet pageSet, String clientId, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("client", clientService.selectClient(pageSet, clientId));
		mav.addObject("pageInfo", clientService.selectClientList(pageSet, request));
		mav.setViewName("client/clientUpdate");
		return mav;
	}

	@RequestMapping(value = "/clientAddForm", method = RequestMethod.GET)
	public ModelAndView clientAddForm(PageSet pageSet, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageInfo", clientService.selectClientList(pageSet, request));
		mav.setViewName("client/clientAddForm");
		return mav;
	}

	@RequestMapping(value = "/clientView", method = RequestMethod.GET)
	public ModelAndView clientView(PageSet pageSet, String clientId, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("client", clientService.selectClient(pageSet, clientId));
		mav.addObject("pageInfo", clientService.selectClientList(pageSet, request));
		mav.setViewName("client/clientView");
		return mav;
	}

}
