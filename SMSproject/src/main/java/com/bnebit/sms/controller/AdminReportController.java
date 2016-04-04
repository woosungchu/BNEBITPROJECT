package com.bnebit.sms.controller;

import java.lang.reflect.Type;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.AdminReportService;
import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.Consulting;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.DailyReport;
import com.bnebit.sms.vo.Employee;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping(value = "/admin/report")
public class AdminReportController {

	@Autowired
	private AdminReportService service;


	// ******************************************* WeeklyPlan ********************************************************** //
	@RequestMapping(value = "/weeklyPlanList", method = RequestMethod.GET)
	public ModelAndView weeklyPlanList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav = service.configHistoryPageWeeklyPlanList(session);
		return mav;
	}

	@RequestMapping(value="/viewWeeklyPlan", method = RequestMethod.GET)
	public ModelAndView viewWeeklyPlan(String weeklyPlanId, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav = service.getWeeklyPlan(weeklyPlanId, session);
		return mav;
	}

	@RequestMapping(value="/viewWeeklyPlanUpdateForm", method = RequestMethod.GET)
	public ModelAndView viewWeeklyPlanUpdateForm(String weeklyPlanId, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav = service.viewWeeklyPlanUpdateForm(weeklyPlanId);
		return mav;
	}

	@RequestMapping(value="/inputPlan", method = RequestMethod.POST)
	public @ResponseBody String inputPlan(String dailyPlanId, String content)throws Exception{
		return service.inputPlan(dailyPlanId, content);
	}

	@RequestMapping(value="/removePlan", method = RequestMethod.POST)
	public @ResponseBody String removePlan(String planId)throws Exception{
		return service.removePlan(planId);
	}

	@RequestMapping(value="/saveWeeklyPlan", method = RequestMethod.POST)
	public @ResponseBody int saveWeeklyPlan(String title, String weeklyPlanId, @RequestParam("monday") String monday, @RequestParam("dailyPlanList") String dailyPlanListJson, HttpSession session) throws Exception{
		Gson gson = new Gson();
		Type type = new TypeToken<ArrayList<DailyPlan>>() {}.getType();
		ArrayList<DailyPlan> dailyPlanList = gson.fromJson(dailyPlanListJson, type);

		return service.saveWeeklyPlan(title, weeklyPlanId, monday, dailyPlanList, session);
	}

	@RequestMapping(value = "/getWeeklyPlanListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Map<String, Object>> getWeeklyPlanListJsonData(PageOption<Map<String, Object>> pageOption, @RequestParam("_search") String search, HttpSession session) throws Exception {
		return service.getPageOptionWeeklyPlanList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteWeeklyPlanList", method = RequestMethod.POST)
	public @ResponseBody void deleteWeeklyPlanList(@RequestParam(value="ids[]") String[] ids, HttpSession session) throws SQLException {
		service.removeWeeklyPlanList(ids);
	}

	@RequestMapping(value = "/deleteWeeklyPlan", method = RequestMethod.GET)
	public ModelAndView deleteWeeklyPlan(String weeklyPlanId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeWeeklyPlan(weeklyPlanId, session);
		return mav;
	}
	// ****************************************************************************************************************** //




	// ******************************************* DailyReport ********************************************************** //
	@RequestMapping(value = "/dailyReportList", method = RequestMethod.GET)
	public ModelAndView dailyReportList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav = service.configHistoryPageDailyReportList(session);
		return mav;
	}

	@RequestMapping(value="/viewDailyReport", method = RequestMethod.GET)
	public ModelAndView viewDailyReport(DailyReport dailyReport, String weeklyPlanId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.getDailyReport(dailyReport, weeklyPlanId, session);
		return mav;
	}

	@RequestMapping(value="/updateDailyReportForm", method = RequestMethod.POST)
	public ModelAndView updateDailyReportForm(DailyReport dailyReport, String weeklyPlanId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.updateDailyReportForm(dailyReport, weeklyPlanId, session);
		return mav;
	}

	@RequestMapping(value="/updateDailyReport", method = RequestMethod.POST)
	public ModelAndView updateDailyReport(DailyReport dailyReport, String weeklyPlanId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.updateDailyReport(dailyReport, weeklyPlanId, session);
		return mav;
	}

	@RequestMapping(value = "/getDailyReportListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Map<String, Object>> getDailyReportListJsonData(PageOption<Map<String, Object>> pageOption, @RequestParam("_search") String search, HttpSession session) throws Exception {
		return service.getPageOptionDailyReportList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteDailyReportList", method = RequestMethod.POST)
	public @ResponseBody void deleteDailyReportList(@RequestParam(value="ids[]") String[] ids, HttpSession session) throws SQLException {
		service.removeDailyReportList(ids);
	}

	@RequestMapping(value = "/deleteDailyReport", method = RequestMethod.GET)
	public ModelAndView deleteDailyReport(String dailyReportId, String weeklyPlanId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeDailyReport(dailyReportId, weeklyPlanId, session);
		return mav;
	}
	// ****************************************************************************************************************** //



	// ******************************************** Consulting ********************************************************** //
	@RequestMapping(value = "/consultingList", method = RequestMethod.GET)
	public ModelAndView consultingList(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav = service.configHistoryPageConsultingList(session);
		return mav;
	}

	@RequestMapping(value="/viewConsulting", method = RequestMethod.GET)
	public ModelAndView viewConsulting(String consultingId, Employee employee, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.viewConsulting(consultingId, employee, session);
		return mav;
	}

	@RequestMapping(value="/updateConsultingForm", method = RequestMethod.POST)
	public ModelAndView updateConsultingForm(Consulting consulting, Employee employee, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.updateConsultingForm(consulting, employee, session);
		return mav;
	}

	@RequestMapping(value="/updateConsulting", method = RequestMethod.POST)
	public ModelAndView updateConsulting(Consulting consulting, Employee employee, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.updateConsulting(consulting, employee, session);
		return mav;
	}

	@RequestMapping(value = "/getConsultingListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Map<String, Object>> getConsultingListJsonData(PageOption<Map<String, Object>> pageOption, @RequestParam("_search") String search, HttpSession session) throws Exception {
		return service.getPageOptionConsultingList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteConsultingList", method = RequestMethod.POST)
	public @ResponseBody void deleteConsultingList(@RequestParam(value="ids[]") String[] ids, HttpSession session) throws SQLException {
		service.removeConsultingList(ids);
	}

	@RequestMapping(value = "/deleteConsulting", method = RequestMethod.GET)
	public ModelAndView deleteConsulting(String consultingId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeConsulting(consultingId, session);
		return mav;
	}
	// ****************************************************************************************************************** //

	@RequestMapping(value = "/clearHistory", method = RequestMethod.POST)
	public void clearHistory(HttpSession session) throws Exception {
		session.removeAttribute("HISTORY_FLAG");
		session.removeAttribute("HISTORY_PAGE");
	}

	@RequestMapping(value = "/checkDailyReportExist", method = RequestMethod.POST)
	public @ResponseBody int checkDailyReportExist(DailyReport dailyReport, HttpSession session) throws Exception {
		return service.checkDailyReportExist(dailyReport);
	}
}
