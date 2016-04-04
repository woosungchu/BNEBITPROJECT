package com.bnebit.sms.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.ClientService;
import com.bnebit.sms.util.page.GridPageSet;
import com.google.gson.Gson;

@Controller
@SessionAttributes("clientUpdateInfo")
@RequestMapping("/admin/client")
public class AdminClientController {
	@Autowired
	private ClientService clientService;

	@RequestMapping(value = "/clientList", method = RequestMethod.GET)
	public ModelAndView clientList(GridPageSet gridPageSet) {
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		String jsonPageSet = gson.toJson(gridPageSet);
		mav.addObject("jsonPage", jsonPageSet);
		mav.setViewName("admin/adminClientList");
		return mav;
	}

	@RequestMapping(value = "/clientAddForm", method = RequestMethod.GET)
	public ModelAndView clientAddForm(GridPageSet gridPageSet, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		gridPageSet.setPageParamMap();
		mav.addObject("pageSet", gridPageSet);
		mav.setViewName("admin/adminClientAddForm");
		return mav;
	}

	@RequestMapping(value = "/clientUpdate", method = RequestMethod.GET)
	public ModelAndView clientUpdate(GridPageSet gridPageSet, String clientId, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		gridPageSet.setPageParamMap();
		mav.addObject("clientUpdateInfo", clientService.selectClient(gridPageSet, clientId));
		mav.addObject("pageSet", gridPageSet);
		mav.setViewName("admin/adminClientUpdate");
		return mav;
	}

	@RequestMapping(value = "/clientView", method = RequestMethod.GET)
	public ModelAndView clientView(GridPageSet gridPageSet, String clientId, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		gridPageSet.setPageParamMap();
		mav.addObject("client", clientService.selectClient(gridPageSet, clientId));
		mav.addObject("pageSet", gridPageSet);
		mav.setViewName("admin/adminClientView");
		return mav;
	}
}
