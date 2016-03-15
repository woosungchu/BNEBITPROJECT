package com.bnebit.sms.controller;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.DailyReportService;
import com.bnebit.sms.vo.DailyReport;

@Controller
@Component
public class DailyReportController {

		@Autowired
		private DailyReportService dailyReportService;

		//일일보고 목록조회
		@RequestMapping(value="/dailyReport/selectDailyReportList")
		public ModelAndView selectDailyReportList(HttpServletRequest request) throws SQLException {
			ModelAndView mav = new ModelAndView();
			mav = dailyReportService.selectDailyReportList(request);
			return mav;
		}

		//일일보고 내용조회, 상담일지 목록조회
		@RequestMapping(value="/dailyReport/selectDailyReportView")
		public ModelAndView selectDailyReportView(HttpServletRequest request) throws SQLException, ParseException {
			ModelAndView mav = new ModelAndView();
			mav = dailyReportService.selectDailyReportView(request);
			//mav = dailyReportService.selectConsultingList(request);
			return mav;
		}

		/*@RequestMapping(value="/dailyReport/selectDailyReportView")
		public ModelAndView selectDailyReportView(@RequestParam("dailyReport") DailyReport dailyReport, HttpServletRequest request) throws SQLException {
			ModelAndView mav = dailyReportService.selectDailyReportView(dailyReport);
			//mav = dailyReportService.selectConsultingList(request);
			return mav;
		}*/

		//일일보고 결재
		@RequestMapping(value="/dailyReport/updateDailyReportConfirm")
		public void updateDailyReportConfirm(@RequestParam("dailyReport") DailyReport dailyReport) throws SQLException {
			dailyReportService.updateDailyReportConfirm(dailyReport);
			//일일보고 내용조회 페이지로 이동
		}

		//일일보고 작성
		@RequestMapping(value="/dailyReport/insertDailyReport")
		public void insertDailyReport(@RequestParam("dailyReport") DailyReport dailyReport) throws SQLException {
			dailyReportService.insertDailyReport(dailyReport);
		}

		//일일보고 수정
		@RequestMapping(value="/dailyReport/updateDailyReport")
		public void updateDailyReportWorker(@RequestParam("dailyReport") DailyReport dailyReport) throws SQLException {
			dailyReportService.updateDailyReportWorker(dailyReport);
		}

}
