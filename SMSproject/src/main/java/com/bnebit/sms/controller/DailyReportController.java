package com.bnebit.sms.controller;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.ConsultingService;
import com.bnebit.sms.service.DailyReportService;
import com.bnebit.sms.vo.DailyReport;

import jdk.nashorn.internal.ir.RuntimeNode.Request;

@Controller
public class DailyReportController {

	@Autowired
	private DailyReportService dailyReportService;


	// 일일보고 목록조회
	@RequestMapping(value = "/dailyReport/selectDailyReportList", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView selectDailyReportListForUser(HttpServletRequest request) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = dailyReportService.selectDailyReportListForUser(request);
		return mav;
	}

	// 일일보고 내용조회, 상담일지 목록조회
	@RequestMapping(value = "/dailyReport/selectDailyReportView", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView selectDailyReportView(HttpServletRequest request) throws SQLException, ParseException {
		ModelAndView mav = new ModelAndView();
		mav = dailyReportService.selectDailyReportView(request);
		return mav;

	}

	/*
	 * @RequestMapping(value="/dailyReport/selectDailyReportView") public
	 * ModelAndView selectDailyReportView(@RequestParam("dailyReport")
	 * DailyReport dailyReport, HttpServletRequest request) throws SQLException
	 * { ModelAndView mav =
	 * dailyReportService.selectDailyReportView(dailyReport); //mav =
	 * dailyReportService.selectConsultingList(request); return mav; }
	 */

	// 일일보고 결재
	@RequestMapping(value = "/dailyReport/updateDailyReportConfirm", method = RequestMethod.POST)
	@ResponseBody
	public void updateDailyReportConfirm(DailyReport dailyReport) throws SQLException {
		dailyReportService.updateDailyReportConfirm(dailyReport);
	}

	// 일일보고 작성 페이지로 이동
	@RequestMapping(value = "/dailyReport/insertDailyReportForm")
	public ModelAndView insertDailyReportForm(HttpServletRequest request) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = dailyReportService.insertDailyReportForm(request);
		return mav;
	}

	// 일일보고 작성
	@RequestMapping(value = "/dailyReport/insertDailyReport")
	public ModelAndView insertDailyReport(DailyReport dailyReport) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = dailyReportService.insertDailyReport(dailyReport);
		return mav;
	}

	// 일일보고 수정 페이지로 이동
	@RequestMapping(value = "/dailyReport/updateDailyReportForm")
	public ModelAndView updateDailyReportForm(HttpServletRequest request) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = dailyReportService.updateDailyReportForm(request);
		return mav;
	}

	// 일일보고 수정
	@RequestMapping(value = "/dailyReport/updateDailyReport")
	public ModelAndView updateDailyReportWorker(DailyReport dailyReport) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = dailyReportService.updateDailyReportWorker(dailyReport);
		return mav;
	}

}
