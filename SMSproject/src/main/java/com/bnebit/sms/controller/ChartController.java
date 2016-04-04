package com.bnebit.sms.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	public ModelAndView profitRateChart(HttpSession session, String chartType, String type, String empId) throws SQLException {
		ModelAndView mav = chartService.profitRateChart(session, chartType, type, empId);
		return mav;
	}

	// 주행거리 차트
	@RequestMapping(value = "/chart/distanceChart")
	public ModelAndView distanceChart(HttpSession session, String chartType, String type, String empId) throws SQLException {
		ModelAndView mav = chartService.distanceChart(session, chartType, type, empId);
		return mav;
	}

	// 매출액 차트
	@RequestMapping(value = "/chart/profitChart")
	public ModelAndView profitChart(HttpSession session, String chartType, String type, String empId) throws SQLException {
		ModelAndView mav = chartService.profitChart(session, chartType, type, empId);
		return mav;
	}

	// 부서에 속하는 모든 empName 불러오기
	@RequestMapping(value="selectEmployeeByDept")
	public ModelAndView selectEmployeeByDept(HttpSession session) throws Exception{
		ModelAndView mav=chartService.selectEmployeeByDept(session);
		return mav;
	}
/*
	// 매출달성률 - 우경아
	@RequestMapping(value="viewProfitRate")
	public ModelAndView viewProfitRate(HttpSession session)throws Exception{
		ModelAndView mav=chartService.viewProfitRate(session);
		return mav;
	}

	// 주행거리 일별 - 우경아
	@RequestMapping(value="viewDistanceDay")
	public ModelAndView viewDistanceDay(HttpSession session)throws Exception{
		ModelAndView mav=chartService.viewDistanceDay(session);
		return mav;
	}*/

	// 차트조회
	@RequestMapping(value="viewChart")
	public ModelAndView viewChart(HttpSession session) throws Exception{
		ModelAndView mav=chartService.viewChart(session);
		return mav;
	}
}
