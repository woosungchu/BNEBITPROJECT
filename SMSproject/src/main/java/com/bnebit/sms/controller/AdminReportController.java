package com.bnebit.sms.controller;

import java.sql.SQLException;
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

	@RequestMapping(value="/checkWeeklyPlan", method = RequestMethod.GET)
	public ModelAndView checkWeeklyPlan(String empId, String monday) throws Exception{
		ModelAndView mav = service.checkWeeklyPlan(empId, monday);
		return mav;
	}

	@RequestMapping(value="/inputPlan", method = RequestMethod.POST)
	public @ResponseBody String inputPlan(String dailyPlanId, String content)throws Exception{
		return service.inputPlan(dailyPlanId, content);
	}

	@RequestMapping(value = "/getWeeklyPlanListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Map<String, Object>> getWeeklyPlanListJsonData(PageOption<Map<String, Object>> pageOption, @RequestParam("_search") String search, HttpSession session) throws Exception {
		return service.getPageOptionWeeklyPlanList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteWeeklyPlanList", method = RequestMethod.GET)
	public void deleteWeeklyPlanList(@RequestParam(value="ids") String[] ids, HttpSession session) throws SQLException {
		service.removeWeeklyPlanList(ids);
	}

	@RequestMapping(value = "/deleteWeeklyPlan", method = RequestMethod.GET)
	public ModelAndView deleteWeeklyPlan(String id, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeWeeklyPlan(id, session);
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

	/*@RequestMapping(value="/tiles/viewDailyReport", method = RequestMethod.GET)
	public ModelAndView viewDailyReport(String dailyReportId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		return mav;
	}*/

	@RequestMapping(value = "/getDailyReportListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Map<String, Object>> getDailyReportListJsonData(PageOption<Map<String, Object>> pageOption, @RequestParam("_search") String search, HttpSession session) throws Exception {
		return service.getPageOptionDailyReportList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteDailyReportList", method = RequestMethod.GET)
	public void deleteDailyReportList(@RequestParam(value="ids") String[] ids, HttpSession session) throws SQLException {
		service.removeDailyReportList(ids);
	}

	@RequestMapping(value = "/deleteDailyReport", method = RequestMethod.GET)
	public ModelAndView deleteDailyReport(String id, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeDailyReport(id, session);
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

	/*@RequestMapping(value="/tiles/viewDailyReport", method = RequestMethod.GET)
	public ModelAndView viewDailyReport(String dailyReportId, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		return mav;
	}*/

	@RequestMapping(value = "/getConsultingListJsonData", method = RequestMethod.POST)
	public @ResponseBody PageOption<Map<String, Object>> getConsultingListJsonData(PageOption<Map<String, Object>> pageOption, @RequestParam("_search") String search, HttpSession session) throws Exception {
		return service.getPageOptionConsultingList(pageOption, search, session);
	}

	@RequestMapping(value = "/deleteConsultingList", method = RequestMethod.GET)
	public void deleteConsultingList(@RequestParam(value="ids") String[] ids, HttpSession session) throws SQLException {
		service.removeConsultingList(ids);
	}

	@RequestMapping(value = "/deleteConsulting", method = RequestMethod.GET)
	public ModelAndView deleteConsulting(String id, HttpSession session) throws SQLException {
		ModelAndView mav = new ModelAndView();
		mav = service.removeConsulting(id, session);
		return mav;
	}
	// ****************************************************************************************************************** //
}
