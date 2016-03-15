package com.bnebit.sms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.ChartDAO;

@Service
public class ChartService {

	@Autowired
	private ChartDAO chartDAO;

	// 매출 달성율 차트
	public ModelAndView profitRateChart(HttpServletRequest request) throws SQLException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("chartType", request.getParameter("chartType"));
		paramMap.put("monday", request.getParameter("monday"));
		paramMap.put("deptId", request.getParameter("deptId"));
		paramMap.put("empId", request.getParameter("empId"));
		ArrayList<Double> percentList = (ArrayList<Double>) chartDAO.profitRateChart(paramMap);

		ModelAndView mav = new ModelAndView();
		mav.addObject(percentList);
		return mav;
	}

	// 주행거리 차트
	public ModelAndView distanceChart(HttpServletRequest request) throws SQLException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("chartType", request.getParameter("chartType"));
		paramMap.put("monday", request.getParameter("monday"));
		paramMap.put("deptId", request.getParameter("deptId"));
		paramMap.put("empId", request.getParameter("empId"));
		ArrayList<Double> distanceList = (ArrayList<Double>) chartDAO.distanceChart(paramMap);

		ModelAndView mav = new ModelAndView();
		mav.addObject(distanceList);
		return mav;
	}

	// 매출액 차트
	public ModelAndView profitChart(HttpServletRequest request) throws SQLException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("chartType", request.getParameter("chartType"));
		paramMap.put("deptId", request.getParameter("deptId"));
		paramMap.put("empId", request.getParameter("empId"));
		ArrayList<Double> profitList = (ArrayList<Double>) chartDAO.profitChart(paramMap);

		ModelAndView mav = new ModelAndView();
		mav.addObject(profitList);
		return mav;
	}
}
