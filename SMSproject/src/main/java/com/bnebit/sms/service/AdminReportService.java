package com.bnebit.sms.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.ConsultingDAO;
import com.bnebit.sms.dao.DailyReportDAO;
import com.bnebit.sms.dao.WeeklyPlanDAO;
import com.bnebit.sms.util.PageOption;
import com.google.gson.Gson;

@Service
public class AdminReportService {

	@Autowired
	private DailyReportDAO dailyReportDAO;
	@Autowired
	private ConsultingDAO consultingDAO;
	@Autowired
	private WeeklyPlanDAO weeklyPlanDAO;
	@Autowired
	private ModelAndView mav;


	// ******************************************* WeeklyPlan ********************************************************** //
	public ModelAndView configHistoryPageWeeklyPlanList(HttpSession session)
	{
		mav.setViewName("admin/adminWeeklyPlanList");
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			Gson gson = new Gson();
			String historyPage = gson.toJson(session.getAttribute("HISTORY_PAGE"));
			mav.addObject("historyPage", historyPage);
		}
		return mav;
	}

	@SuppressWarnings("unchecked")
	public PageOption<Map<String, Object>> getPageOptionWeeklyPlanList(PageOption<Map<String, Object>> pageOption, String search, HttpSession session) throws SQLException
	{
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			pageOption = null;
			pageOption = (PageOption<Map<String, Object>>) session.getAttribute("HISTORY_PAGE");
			session.setAttribute("HISTORY_FLAG", "0");
			return pageOption;
		}
		pageOption.setSearch(search);
		if("true".equals(search) && "c.checked".equals(pageOption.getSearchField()))	// checked 필드로 검색을 하려 할 때... ( 읽음 = 1 / 읽지 않음 0 ) 으로 치환 함.
		{
			pageOption.setSearchString("읽음".equals(pageOption.getSearchString())?"1":"읽지 않음".equals(pageOption.getSearchString())?"0":pageOption.getSearchString());
		}
		if(!pageOption.getSidx().equals(""))
		{
			pageOption.setFullSidx(pageOption.getSidx()+" "+pageOption.getSord());
		}
		pageOption.setEnd(pageOption.getPage()*pageOption.getRows());
		pageOption.setStart(pageOption.getEnd()-pageOption.getRows()+1);

		pageOption.setRecords(weeklyPlanDAO.selectWeeklyPlanListCount(pageOption));
		int total;
		if ( pageOption.getRecords()%pageOption.getRows() == 0 )
			total = pageOption.getRecords()/pageOption.getRows();
		else
			total = pageOption.getRecords()/pageOption.getRows() + 1;
		pageOption.setTotal(total);

		List<Map<String,Object>> dataList = weeklyPlanDAO.selectWeeklyPlanList(pageOption);
		pageOption.setDataList(dataList);

		session.setAttribute("HISTORY_PAGE", pageOption);

		return pageOption;
	}

	public void removeWeeklyPlanList(String[] ids) throws SQLException
	{
		weeklyPlanDAO.deleteWeeklyPlanList(ids);
	}

	public ModelAndView removeWeeklyPlan(String id, HttpSession session) throws SQLException
	{
		session.setAttribute("HISTORY_FLAG", "0");
		weeklyPlanDAO.deleteWeeklyPlan(id);
		mav.setViewName("/admin/report/weeklyPlanList");
		return mav;
	}
	// ****************************************************************************************************************** //





	// ******************************************* DailyReport ********************************************************** //
	public ModelAndView configHistoryPageDailyReportList(HttpSession session)
	{
		mav.setViewName("admin/adminDailyReportList");
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			Gson gson = new Gson();
			String historyPage = gson.toJson(session.getAttribute("HISTORY_PAGE"));
			mav.addObject("historyPage", historyPage);
		}
		return mav;
	}

	@SuppressWarnings("unchecked")
	public PageOption<Map<String, Object>> getPageOptionDailyReportList(PageOption<Map<String, Object>> pageOption, String search, HttpSession session) throws SQLException
	{
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			pageOption = null;
			pageOption = (PageOption<Map<String, Object>>) session.getAttribute("HISTORY_PAGE");
			session.setAttribute("HISTORY_FLAG", "0");
			return pageOption;
		}
		pageOption.setSearch(search);
		if(!pageOption.getSidx().equals(""))
		{
			pageOption.setFullSidx(pageOption.getSidx()+" "+pageOption.getSord());
		}
		pageOption.setEnd(pageOption.getPage()*pageOption.getRows());
		pageOption.setStart(pageOption.getEnd()-pageOption.getRows()+1);

		pageOption.setRecords(dailyReportDAO.selectDailyReportListCount(pageOption));
		int total;
		if ( pageOption.getRecords()%pageOption.getRows() == 0 )
			total = pageOption.getRecords()/pageOption.getRows();
		else
			total = pageOption.getRecords()/pageOption.getRows() + 1;
		pageOption.setTotal(total);

		List<Map<String,Object>> dataList = dailyReportDAO.selectDailyReportList(pageOption);
		pageOption.setDataList(dataList);

		session.setAttribute("HISTORY_PAGE", pageOption);

		return pageOption;
	}

	public void removeDailyReportList(String[] ids) throws SQLException
	{
		dailyReportDAO.deleteDailyReportList(ids);
	}

	public ModelAndView removeDailyReport(String id, HttpSession session) throws SQLException
	{
		session.setAttribute("HISTORY_FLAG", "0");
		dailyReportDAO.deleteDailyReport(id);
		mav.setViewName("/admin/report/dailyReportList");
		return mav;
	}
	// ****************************************************************************************************************** //


	// ******************************************** Consulting ********************************************************** //
	public ModelAndView configHistoryPageConsultingList(HttpSession session)
	{
		mav.setViewName("admin/adminConsultingList");
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			Gson gson = new Gson();
			String historyPage = gson.toJson(session.getAttribute("HISTORY_PAGE"));
			mav.addObject("historyPage", historyPage);
		}
		return mav;
	}

	@SuppressWarnings("unchecked")
	public PageOption<Map<String, Object>> getPageOptionConsultingList(PageOption<Map<String, Object>> pageOption, String search, HttpSession session) throws SQLException
	{
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			pageOption = null;
			pageOption = (PageOption<Map<String, Object>>) session.getAttribute("HISTORY_PAGE");
			session.setAttribute("HISTORY_FLAG", "0");
			return pageOption;
		}
		pageOption.setSearch(search);
		if(!pageOption.getSidx().equals(""))
		{
			pageOption.setFullSidx(pageOption.getSidx()+" "+pageOption.getSord());
		}
		pageOption.setEnd(pageOption.getPage()*pageOption.getRows());
		pageOption.setStart(pageOption.getEnd()-pageOption.getRows()+1);

		pageOption.setRecords(consultingDAO.selectConsultingListCount(pageOption));
		int total;
		if ( pageOption.getRecords()%pageOption.getRows() == 0 )
			total = pageOption.getRecords()/pageOption.getRows();
		else
			total = pageOption.getRecords()/pageOption.getRows() + 1;
		pageOption.setTotal(total);

		List<Map<String,Object>> dataList = consultingDAO.selectConsultingList(pageOption);
		pageOption.setDataList(dataList);

		session.setAttribute("HISTORY_PAGE", pageOption);

		return pageOption;
	}

	public void removeConsultingList(String[] ids) throws SQLException
	{
		consultingDAO.deleteConsultingList(ids);
	}

	public ModelAndView removeConsulting(String id, HttpSession session) throws SQLException
	{
		session.setAttribute("HISTORY_FLAG", "0");
		consultingDAO.deleteConsulting(id);
		mav.setViewName("/admin/report/consultingList");
		return mav;
	}
	// ****************************************************************************************************************** //

}
