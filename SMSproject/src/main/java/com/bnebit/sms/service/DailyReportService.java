package com.bnebit.sms.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.DailyReportDAO;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.DailyReport;
import com.bnebit.sms.vo.Event;

@Service("dailyReportService")
public class DailyReportService {

	@Autowired
	private DailyReportDAO dailyReportDAO;

	// 일일보고 목록조회
	// parameter : HttpServletRequest request로 검색키와 검색어를 받아서 전달. order by 컬럼명도
	// 받아서 전달할 것
	public ModelAndView selectDailyReportList(HttpServletRequest request) throws SQLException {
		ModelAndView mav = new ModelAndView();

		// session 정보에서 position과 empId, deptId를 받아옴
		/*HttpSession session = request.getSession();
		Employee employee = (Employee) session.getAttribute("emp");
		String deptId = employee.getDept().getDeptId();
		String empId = employee.getEmpId();
		String position = employee.getPosition();*/

		String deptId = "1";
		String empId = "1";
		String position = "팀원";

		// Map에 검색키와 검색어, sortkey를 넣어서 전달
		// 팀원일 경우 empId도 필요
		Map<String, Object> paramMap = new HashMap<String, Object>();
		/*paramMap.put("searchKey", request.getParameter("searchKey"));
		paramMap.put("searchValue", request.getParameter("searchValue"));
		paramMap.put("sortKey", request.getParameter("sortKey"));*/
		paramMap.put("searchKey", request.getParameter("searchKey"));
		paramMap.put("searchValue", request.getParameter("searchValue"));
		//paramMap.put("sortKey", request.getParameter("sortKey"));

		// position에 따라서 다른 DAO실행
		// Event 정보를 받아서 휴일 여부에 따라 일일보고 작성 버튼 막기
		ArrayList<DailyReport> dailyReportList = new ArrayList<DailyReport>();
		Event event = dailyReportDAO.selectEvent();

		if ("팀장".equals(position)) {
			paramMap.put("deptId", deptId);
			dailyReportList = dailyReportDAO.selectDailyReportListLeader(paramMap);
		} else {
			paramMap.put("empId", empId);
			dailyReportList = dailyReportDAO.selectDailyReportListWorker(paramMap);
		}
		mav.addObject(dailyReportList);
		mav.addObject(event);
		mav.setViewName("test/DailyReportList");
		return mav;
	}

	// 일일보고 내용조회
	// parameter : dailyReport
	public ModelAndView selectDailyReportView(HttpServletRequest request) throws SQLException, ParseException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("planDate", request.getParameter("regDate"));
		paramMap.put("dailyReportId", request.getParameter("dailyReportId"));

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
		mav.addObject(dailyReport);
		mav.addObject(dailyPlan);
		mav.setViewName("test/DailyReportView");
		return mav;
	}

	// 일일보고 결재
	public void updateDailyReportConfirm(DailyReport dailyReport) throws SQLException {
		dailyReportDAO.updateDailyReportConfirm(dailyReport);
	}

	// 일일보고 작성
	public void insertDailyReport(DailyReport dailyReport) throws SQLException {
		dailyReportDAO.insertDailyReport(dailyReport);
	}

	// 일일보고 수정
	public void updateDailyReportWorker(DailyReport dailyReport) throws SQLException {
		dailyReportDAO.updateDailyReportWorker(dailyReport);
	}

}
