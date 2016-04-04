package com.bnebit.sms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.util.page.GridPageSet;
import com.google.gson.Gson;

@Controller
@RequestMapping("/admin/message")
public class AdminMessageController {

	@RequestMapping(value = "/messageList", method = RequestMethod.GET)
	public ModelAndView messageList(GridPageSet gridPageSet) {
		ModelAndView mav = new ModelAndView();
		Gson gson = new Gson();
		String jsonPageSet = gson.toJson(gridPageSet);
		mav.addObject("jsonPage", jsonPageSet);
		mav.setViewName("admin/adminMessageList");
		return mav;
	}

	@RequestMapping(value = "/popup/messageForm", method = RequestMethod.GET)
	public ModelAndView messageForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/popup/adminMessageForm");
		return mav;
	}
}
