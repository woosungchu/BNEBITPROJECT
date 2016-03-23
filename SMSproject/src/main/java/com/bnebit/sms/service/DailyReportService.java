package com.bnebit.sms.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.DailyReportDAO;
import com.bnebit.sms.dao.EmployeeDAO;
import com.bnebit.sms.dao.EventDAO;
import com.bnebit.sms.util.page.PageUtil;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.DailyReport;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Event;

@Service("dailyReportService")
public class DailyReportService {

	@Autowired
	private DailyReportDAO dailyReportDAO;

	@Autowired
	private EventDAO eventDAO;

	@Autowired
	private EmployeeDAO employeeDAO;

	static int currentPage = 1;
	static int currentBlock = 1;

	// 일일보고 목록조회
	public ModelAndView selectDailyReportList(HttpServletRequest request) throws SQLException {
		ModelAndView mav = new ModelAndView();

		// session 정보에서 position과 empId, deptId를 받아옴
		HttpSession session = request.getSession();
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		String deptId = employee.getDept().getDeptId();
		String empId = employee.getEmpId();
		String position = employee.getPosition();

		Map<String, Object> paramMap = new HashMap<String, Object>();
		if ("Manager".equals(position)) {
			paramMap.put("deptId", deptId);
		} else if ("Salesman".equals(position)) {
			paramMap.put("empId", empId);
		}

		// search parameter : searchKey, searchValue
		// sort parameter : sortKey, sortBy
		paramMap.put("searchKey", request.getParameter("searchKey"));
		paramMap.put("searchValue", request.getParameter("searchValue"));
		paramMap.put("sortKey", request.getParameter("sortKey"));
		paramMap.put("sortBy", request.getParameter("sortBy"));

		// Event 정보를 받아서 휴일 여부에 따라 일일보고 작성 버튼 막기
		ArrayList<DailyReport> dailyReportList = new ArrayList<DailyReport>();
		Event event = eventDAO.selectTodayEvent();

		// paging
		PageUtil pageUtil = new PageUtil();
		int totalCount = dailyReportDAO.countDailyReport(paramMap);

		String param = request.getParameter("currentPage");
		if (param != null) {
			currentPage = Integer.parseInt(param);
		}

		PageUtil.currentPage = currentPage;
		PageUtil.currentBlock = currentBlock;

		int startNum = pageUtil.startNum(totalCount);
		int endNum = pageUtil.endNum(totalCount);

		if (startNum != endNum) {
			paramMap.put("startNum", startNum);
			paramMap.put("endNum", endNum);
		}

		int totalPageCount = pageUtil.pageCountSize(totalCount);
		int totalBlockCount = pageUtil.blockCountSize(totalCount);

		currentBlock = pageUtil.moveBlock(currentPage);

		pageUtil.setTotalCount(totalCount);
		pageUtil.setTotalPageCount(totalPageCount);
		pageUtil.setTotalBlockCount(totalBlockCount);

		boolean isFirstBlock = pageUtil.isFirstBlock();
		boolean isLastBlock = pageUtil.isLastBlock();
		paramMap.put("isFirstBlock", isFirstBlock);
		paramMap.put("isLastBlock", isLastBlock);

		int blockSize = PageUtil.BLOCKSIZE;
		int pageSize = PageUtil.PAGESIZE;

		if (totalPageCount < PageUtil.BLOCKSIZE) {
			blockSize = totalPageCount;
		}

		paramMap.put("blockSize", blockSize);
		paramMap.put("pageSize", pageSize);

		if ("Manager".equals(position)) {
			dailyReportList = dailyReportDAO.selectDailyReportListLeader(paramMap);
		} else if ("Salesman".equals(position)) {
			dailyReportList = dailyReportDAO.selectDailyReportListWorker(paramMap);
		}

		Iterator<String> iterator = paramMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			System.out.println("key : " + key + ", value : " + paramMap.get(key));
		}

		for (int i = 0; i < dailyReportList.size(); i++) {
			System.out.println(dailyReportList.get(i));
		}

		mav.addObject("pageUtil", pageUtil);
		mav.addObject("dailyReportList", dailyReportList);
		mav.addObject("paramMap", paramMap);
		if (event != null) {
			mav.addObject("event", event);
		}
		mav.setViewName("dailyReport/dailyReportList");
		return mav;
	}

	// 일일보고 내용조회
	// parameter : dailyReport
	public ModelAndView selectDailyReportView(HttpServletRequest request) throws SQLException, ParseException {
		// session 정보에서 position과 empId, deptId를 받아옴
		HttpSession session = request.getSession();

		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		employee = employeeDAO.selectOneById(employee.getEmpId());

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dailyReportId", request.getParameter("dailyReportId"));
		paramMap.put("empId", request.getParameter("empId"));
		paramMap.put("planDate", request.getParameter("regDate"));

		Iterator<String> iterator = paramMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			System.out.println("key : " + key + ", value : " + paramMap.get(key));
		}

		DailyReport dailyReport = (DailyReport) dailyReportDAO.selectDailyReportView(paramMap);
		DailyPlan dailyPlan = (DailyPlan) dailyReportDAO.selectSalesGoal(paramMap);
		System.out.println("dailyReport : " + dailyReport);
		System.out.println("dailyPlan : " + dailyPlan);

		ModelAndView mav = new ModelAndView();
		mav.addObject("employee", employee);
		mav.addObject("dailyReport", dailyReport);
		mav.addObject("dailyPlan", dailyPlan);
		mav.setViewName("dailyReport/dailyReportView");
		return mav;
	}

	// 일일보고 결재
	public void updateDailyReportConfirm(DailyReport dailyReport) throws SQLException {
		System.out.println(dailyReport);
		dailyReportDAO.updateDailyReportConfirm(dailyReport);
	}

	// 일일보고 작성 페이지로 이동
	public ModelAndView insertDailyReportForm(HttpServletRequest request) throws SQLException {
		Employee employee = new Employee();
		employee = employeeDAO.selectOneById(request.getParameter("empId"));

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empId", request.getParameter("empId"));
		paramMap.put("planDate", request.getParameter("regDate"));

		Iterator<String> iterator = paramMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			System.out.println("key : " + key + ", value : " + paramMap.get(key));
		}

		DailyPlan dailyPlan = (DailyPlan) dailyReportDAO.selectSalesGoal(paramMap);
		System.out.println("dailyPlan : " + dailyPlan);

		ModelAndView mav = new ModelAndView();
		mav.addObject("employee", employee);
		mav.addObject("dailyPlan", dailyPlan);
		mav.setViewName("dailyReport/insertDailyReportForm");
		return mav;
	}

	// 일일보고 작성
	public ModelAndView insertDailyReport(DailyReport dailyReport) throws SQLException {
		dailyReportDAO.insertDailyReport(dailyReport);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/dailyReport/selectDailyReportList");
		return mav;
	}

	// 일일보고 수정 페이지로 이동
	public ModelAndView updateDailyReportForm(HttpServletRequest request) throws SQLException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dailyReportId", request.getParameter("dailyReportId"));
		paramMap.put("empId", request.getParameter("empId"));
		paramMap.put("planDate", request.getParameter("regDate"));

		Iterator<String> iterator = paramMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			System.out.println("key : " + key + ", value : " + paramMap.get(key));
		}

		DailyReport dailyReport = (DailyReport) dailyReportDAO.selectDailyReportView(paramMap);
		DailyPlan dailyPlan = (DailyPlan) dailyReportDAO.selectSalesGoal(paramMap);
		System.out.println("dailyReport : " + dailyReport);
		System.out.println("dailyPlan : " + dailyPlan);

		ModelAndView mav = new ModelAndView();
		mav.addObject("dailyReport", dailyReport);
		mav.addObject("dailyPlan", dailyPlan);
		mav.setViewName("dailyReport/updateDailyReportForm");
		return mav;
	}

	// 일일보고 수정
	public ModelAndView updateDailyReportWorker(DailyReport dailyReport) throws SQLException {
		dailyReportDAO.updateDailyReportWorker(dailyReport);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/dailyReport/selectDailyReportView?dailyReportId="
		+dailyReport.getDailyReportId()+"&empId="+dailyReport.getEmployee().getEmpId()+"&regDate="+dailyReport.getRegDate());
		return mav;
	}

}
