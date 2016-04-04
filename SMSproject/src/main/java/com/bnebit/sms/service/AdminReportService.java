package com.bnebit.sms.service;

import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
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
import com.bnebit.sms.vo.Consulting;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.DailyReport;
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
		ArrayList<WeeklyPlan> empWeeklyList = weeklyPlanDAO.selectWeeklyListFromEmp(weekly.getEmployee().getEmpId());
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


		mav.addObject("empWeeklyList", empWeeklyList);
		mav.addObject("dailyPlanList", dailyPlanList);
		mav.addObject("weeklyPlan", weekly);
		mav.setViewName("admin/adminWeeklyPlanUpdate");
		return mav;
	}

	public String inputPlan(String dailyPlanId, String content)throws Exception {

		Plan plan=new Plan();
		DailyPlan daily=new DailyPlan();
		daily.setDailyPlanId(dailyPlanId);
		plan.setDailyPlan(daily);
		plan.setContent(content);
		plan.setType("0");

		return planDAO.insertPlan(plan);
	}

	public String removePlan(String planId)throws Exception{
		planDAO.deletePlan(planId);
		return "성공";
	}

	public int saveWeeklyPlan(String title, String weeklyPlanId, String monday, ArrayList<DailyPlan> dailyPlanList, HttpSession session)throws Exception{
		WeeklyPlan weeklyPlan = weeklyPlanDAO.selectWeeklyPlan(weeklyPlanId);
		weeklyPlan.setTitle(title);
		DailyPlan daily = new DailyPlan();
		daily.setWeeklyPlan(weeklyPlan);

		for(int i=0;i<5;i++){
			DailyPlan dailyPlanSales=dailyPlanList.get(i);
			Long salesGoal=dailyPlanSales.getSalesGoal();
			daily.setPlanDate(dailyPlanSales.getPlanDate());

			// 그 날짜와 empId에 맞는 dailyPlanId 찾기
			String dailyPlanId=dailyPlanDAO.selectDailyPlanId(daily);
			daily.setDailyPlanId(dailyPlanId);
			daily.setSalesGoal(salesGoal);

			dailyPlanDAO.updateDailyPlanSales(daily);
		}
		weeklyPlanDAO.updateWeeklyPlanTitle(weeklyPlan);

		updateDataListOnHistory("WeeklyPlan",session);

		return Integer.parseInt(weeklyPlanId);
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
		mav.setViewName("redirect:/admin/report/weeklyPlanList");
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

	public ModelAndView getDailyReport(DailyReport dailyReport, String weeklyPlanId, HttpSession session) throws SQLException
	{
		session.setAttribute("HISTORY_FLAG", "1");
		setDailyReportData(dailyReport);
		mav.addObject("weeklyPlanId", weeklyPlanId);
		mav.setViewName("admin/adminDailyReportView");
		return mav;
	}

	public int checkDailyReportExist(DailyReport dailyReport) throws Exception
	{
		String dailyReportId=dailyReportDAO.selectDailyReportByEmpDate(dailyReport);
		if(dailyReportId!=null){
			return Integer.parseInt(dailyReportId);
		}
		else{
			return 0;
		}
	}

	public ModelAndView updateDailyReportForm(DailyReport dailyReport, String weeklyPlanId, HttpSession session) throws SQLException
	{
		setDailyReportData(dailyReport);
		mav.addObject("weeklyPlanId", weeklyPlanId);
		mav.setViewName("admin/adminDailyReportUpdate");
		return mav;
	}

	public ModelAndView updateDailyReport(DailyReport dailyReport, String weeklyPlanId, HttpSession session) throws SQLException
	{
		dailyReportDAO.updateDailyReport(dailyReport);
		mav.setViewName("redirect:/admin/report/viewDailyReport?dailyReportId="
				+dailyReport.getDailyReportId()+"&employee.empId="+dailyReport.getEmployee().getEmpId()+"&regDate="+dailyReport.getRegDate()+"&weeklyPlanId="+weeklyPlanId);
		if(weeklyPlanId == null || weeklyPlanId==""){
			updateDataListOnHistory("DailyReport",session);
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

	public ModelAndView removeDailyReport(String dailyReportId, String weeklyPlanId, HttpSession session) throws SQLException
	{
		dailyReportDAO.deleteDailyReport(dailyReportId);
		if(weeklyPlanId == null || weeklyPlanId==""){
			session.setAttribute("HISTORY_FLAG", "0");
			mav.setViewName("redirect:/admin/report/dailyReportList");
		}
		else{
			mav.setViewName("redirect:/admin/report/viewWeeklyPlan?weeklyPlanId="+weeklyPlanId);
		}
		return mav;
	}

	/* 일일보고 조회, 수정 페이지에서 출력할 일일보고 데이터를 mav에 넣는 메소드 */
	private void setDailyReportData (DailyReport dailyReport) throws SQLException{
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dailyReportId", dailyReport.getDailyReportId());
		paramMap.put("empId", dailyReport.getEmployee().getEmpId());
		paramMap.put("planDate", dailyReport.getRegDate());

		DailyReport dailyReport2 = (DailyReport) dailyReportDAO.selectDailyReportView(paramMap);
		DailyPlan dailyPlan = (DailyPlan) dailyReportDAO.selectSalesGoal(paramMap);

		mav.addObject("dailyReport", dailyReport2);
		mav.addObject("dailyPlan", dailyPlan);
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

	public ModelAndView viewConsulting(String consultingId, Employee employee, HttpSession session) throws SQLException
	{
		session.setAttribute("HISTORY_FLAG", "1");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("consultingId", consultingId);

		ArrayList<Consulting> consultingList = consultingDAO.selectConsultingListWorker(paramMap);
		Object consulting = consultingList.get(0);

		mav.addObject("consulting", consulting);
		mav.addObject("employee", employee);
		mav.setViewName("admin/adminConsultingView");
		return mav;
	}

	public ModelAndView updateConsultingForm(Consulting consulting, Employee employee, HttpSession session) throws SQLException
	{
		mav.addObject("consulting", consulting);
		mav.addObject("employee", employee);
		mav.setViewName("admin/adminConsultingUpdate");
		return mav;
	}


	public ModelAndView updateConsulting(Consulting consulting, Employee employee, HttpSession session) throws SQLException
	{
		consultingDAO.updateConsulting(consulting);
		mav.setViewName("redirect:/admin/report/viewConsulting?consultingId="+consulting.getConsultingId()+
				                                             "&empName="+employee.getEmpName()+
															 "&dept.deptName="+employee.getDept().getDeptName());
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
		mav.setViewName("redirect:/admin/report/consultingList");
		return mav;
	}
	// ****************************************************************************************************************** //

	@SuppressWarnings("unchecked")
	private void updateDataListOnHistory(String listType, HttpSession session)
	{
		try{
			PageOption<Map<String, Object>> pageOption = (PageOption<Map<String, Object>>) session.getAttribute("HISTORY_PAGE");
			List<Map<String,Object>> dataList;
			switch(listType){
			case "WeeklyPlan" :
				dataList = weeklyPlanDAO.selectWeeklyPlanList(pageOption);
				pageOption.setDataList(dataList);
				break;
			case "DailyReport" :
				dataList = dailyReportDAO.selectDailyReportList(pageOption);
				pageOption.setDataList(dataList);
				break;
			case "Consulting" :
				dataList = consultingDAO.selectConsultingList(pageOption);
				pageOption.setDataList(dataList);
				break;
			}
			session.setAttribute("HISTORY_PAGE", pageOption);
		}catch(Exception e){e.printStackTrace();}
	}
}
