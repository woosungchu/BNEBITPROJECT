package com.bnebit.sms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminController {

	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public ModelAndView dailyReportList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/admin/report/weeklyPlanList");
		return mav;
	}


}
