package com.bnebit.sms.service;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.ConsultingDAO;
import com.bnebit.sms.dao.DailyPlanDAO;
import com.bnebit.sms.dao.DailyReportDAO;
import com.bnebit.sms.dao.PlanDAO;
import com.bnebit.sms.dao.WeeklyPlanDAO;
import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Plan;
import com.bnebit.sms.vo.WeeklyPlan;
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
	private DailyPlanDAO dailyPlanDAO;
	@Autowired
	private PlanDAO planDAO;
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

	public ModelAndView getWeeklyPlan(String weeklyPlanId, HttpSession session) throws Exception
	{
		session.setAttribute("HISTORY_FLAG", "1");
		WeeklyPlan weekly=weeklyPlanDAO.selectWeeklyPlan(weeklyPlanId);
		DailyPlan dailyPlan=new DailyPlan();
		dailyPlan.setWeeklyPlan(weekly);

		//월~금의 dailyPlan을 저장할 객체 : dailyPlanList
		ArrayList<DailyPlan> dailyPlanList=new ArrayList<DailyPlan>();
		//weeklyPlan에 저장된 monday를 이용해서 dailyPlan에 들어갈 날짜 찾기
		DateFormat format=new SimpleDateFormat("yy/MM/dd");
		Date date=format.parse(weekly.getMonday());
		for(int i=0;i<5;i++){
			String dateString=format.format(date);
			dailyPlan.setPlanDate(dateString);
			DailyPlan daily = dailyPlanDAO.selectDailyPlan(dailyPlan);
			//dailyPlanList에 dailyPlan 추가시키기
			dailyPlanList.add(daily);

			// 하루 미루기
			long time=date.getTime();
			time+=24*60*60*1000;
			date.setTime(time);
		}

		mav.addObject("dailyPlanList", dailyPlanList);
		mav.addObject("weeklyPlan", weekly);

		mav.setViewName("admin/adminWeeklyPlanView");
		return mav;
	}

	public ModelAndView viewWeeklyPlanUpdateForm(String id) throws Exception
	{
		WeeklyPlan weekly=weeklyPlanDAO.selectWeeklyPlan(id);
		DailyPlan dailyPlan=new DailyPlan();
		dailyPlan.setWeeklyPlan(weekly);

		//월~금의 dailyPlan을 저장할 객체 : dailyPlanList
		ArrayList<DailyPlan> dailyPlanList=new ArrayList<DailyPlan>();
		//weeklyPlan에 저장된 monday를 이용해서 dailyPlan에 들어갈 날짜 찾기
		DateFormat format=new SimpleDateFormat("yy/MM/dd");
		Date date=format.parse(weekly.getMonday());
		for(int i=0;i<5;i++){
			String dateString=format.format(date);
			dailyPlan.setPlanDate(dateString);
			DailyPlan daily=dailyPlanDAO.selectDailyPlan(dailyPlan);
			//dailyPlanList에 dailyPlan 추가시키기
			dailyPlanList.add(daily);

			// 하루 미루기
			long time=date.getTime();
			time+=24*60*60*1000;
			date.setTime(time);
		}

		WeeklyPlan wPlan=weeklyPlanDAO.selectWeeklyETC(id);
		weeklyPlanDAO.updateWeeklyChecked0(wPlan);

		mav.addObject("dailyPlanList", dailyPlanList);
		mav.addObject("weeklyPlan", weekly);
		mav.setViewName("admin/adminWeeklyPlanUpdate");
		return mav;
	}

	@SuppressWarnings("deprecation")
	public ModelAndView checkWeeklyPlan(String empId, String monday) throws Exception{
		WeeklyPlan weekly=new WeeklyPlan();
		Employee emp=new Employee();
		emp.setEmpId(empId);
		weekly.setEmployee(emp);
		weekly.setMonday(monday);
		String weeklyPlanId=weeklyPlanDAO.selectWeeklyPlanByEmpMonday(weekly);

		Date nowDate=new Date();
		Date monDate=new Date(monday);
        if(nowDate.compareTo(monDate)<0){
        	//입력 및 수정
        	if(weeklyPlanId==null){
        		mav.setViewName("redirect:/inputWeeklyPlan?empId="+empId+"&monday="+monday);
        	}else{
        		mav.setViewName("redirect:/editWeeklyPlan?weeklyPlanId="+weeklyPlanId);
        	}
        }else{
        	//조회
        	mav.setViewName("redirect:/viewWeeklyPlan?weeklyPlanId="+weeklyPlanId);
        }
		return mav;
	}

	public String inputPlan(String dailyPlanId, String content)throws Exception {

		Plan plan=new Plan();
		DailyPlan daily=new DailyPlan();
		daily.setDailyPlanId(dailyPlanId);
		plan.setDailyPlan(daily);
		plan.setContent(content);
		plan.setType("0");
		System.out.println(plan);

		return planDAO.insertPlan(plan);
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
			if("1".equals(pageOption.getSearchString()) || "0".equals(pageOption.getSearchString()))
				pageOption.setSearchString("");
			else
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

	public void removeWeeklyPlanList(String[] ids) throws SQLException{
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
