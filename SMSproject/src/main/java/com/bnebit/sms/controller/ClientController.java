package com.bnebit.sms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.ClientService;
import com.bnebit.sms.util.page.PageSet;

@Controller
@RequestMapping("/client")
public class ClientController {

	@Autowired
	private ClientService clientService;

	@RequestMapping(value = "/clientList", method = RequestMethod.GET)
	public ModelAndView clientList(PageSet pageSet) {
		ModelAndView mav = clientService.selectClientList(pageSet);
		return mav;
	}

	@RequestMapping(value = "/clientUpdate", method = RequestMethod.GET)
	public ModelAndView clientUpdate(PageSet pageSet, String clientCode) {
		ModelAndView mav = clientService.selectClient(pageSet, clientCode);
		mav.setViewName("client/clientUpdate");
		return mav;
	}

}
