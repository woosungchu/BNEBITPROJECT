package com.bnebit.sms.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.ChartService;

@Controller
public class ChartController {

	@Autowired
	private ChartService chartService;

	// 매출 달성율 차트
	@RequestMapping(value = "/chart/profitRateChart")
	public ModelAndView profitRateChart(HttpServletRequest request) throws SQLException {
		ModelAndView mav = chartService.profitRateChart(request);
		return mav;
	}

	// 주행거리 차트
	@RequestMapping(value = "/chart/distanceChart")
	public ModelAndView distanceChart(HttpServletRequest request) throws SQLException {
		ModelAndView mav = chartService.distanceChart(request);
		return mav;
	}

	// 매출액 차트
	@RequestMapping(value = "/chart/profitChart")
	public ModelAndView profitChart(HttpServletRequest request) throws SQLException {
		ModelAndView mav = chartService.profitChart(request);
		return mav;
	}
}
