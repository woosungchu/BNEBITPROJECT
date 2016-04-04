package com.bnebit.sms.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.DailyReport;
import com.bnebit.sms.vo.Event;
import com.bnebit.sms.vo.Plan;

@Repository
public class DailyReportDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;

	public int selectWeeklyProfits(String empId) throws Exception{
		return (int) sqlMapClientTemplate.queryForObject("dailyReport.selectWeeklyProfits",empId);
	}

	public int selectWeeklyProfitsManager(String deptId) throws Exception{
		return (int)sqlMapClientTemplate.queryForObject("dailyReport.selectWeeklyProfitsManager",deptId);
	}

	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★  Admin 용 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectDailyReportList(PageOption<Map<String, Object>> pageOption) throws SQLException {
		List<Map<String,Object>> list = (List<Map<String,Object>>) sqlMapClientTemplate.queryForList("dailyReport.selectDailyReportList",pageOption);
		return list;
	}

	public int selectDailyReportListCount(PageOption<Map<String, Object>> pageOption) throws SQLException {
		int records =  (Integer) sqlMapClientTemplate.queryForObject("dailyReport.selectDailyReportListCount", pageOption);
		return records;
	}

	public void deleteDailyReportList(String[] ids) throws SQLException {
		sqlMapClientTemplate.delete("dailyReport.deleteDailyReportList",ids);
	}

	public void deleteDailyReport(String id) throws SQLException {
		sqlMapClientTemplate.delete("dailyReport.deleteDailyReport",id);
	}

	public void updateDailyReport(DailyReport dailyReport) throws SQLException {
		sqlMapClientTemplate.update("dailyReport.updateDailyReport", dailyReport);
	}
	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */

	// 일일보고 개수조회
	public int countDailyReport(Map<String, Object> paramMap) throws SQLException {
		int countDailyReport = (int) sqlMapClientTemplate.queryForObject("dailyReport.countDailyReport", paramMap);
		return countDailyReport;
	}

	// 일일보고 목록조회
	@SuppressWarnings("unchecked")
	public ArrayList<DailyReport> selectDailyReportListForUser(Map<String, Object> paramMap) throws SQLException {
		ArrayList<DailyReport> dailyReportList = (ArrayList<DailyReport>) sqlMapClientTemplate
				.queryForList("dailyReport.selectDailyReportListForUser", paramMap);
		return dailyReportList;
	}

	// 일일보고 내용조회
	public DailyReport selectDailyReportView(Map<String, Object> paramMap) throws SQLException {
		DailyReport dailyReport = (DailyReport) sqlMapClientTemplate.queryForObject("dailyReport.selectDailyReportView",paramMap);
		return dailyReport;
	}

	public DailyPlan selectSalesGoal(Map<String, Object> paramMap) throws SQLException {
		DailyPlan dailyPlan = (DailyPlan) sqlMapClientTemplate.queryForObject("dailyReport.selectSalesGoal", paramMap);
		return dailyPlan;
	}

	// 일일보고 결재
	public void updateDailyReportConfirm(DailyReport dailyReport) throws SQLException {
		sqlMapClientTemplate.update("dailyReport.updateDailyReportConfirm", dailyReport);
	}

	// 일일보고 작성
	public void insertDailyReport(DailyReport dailyReport) throws SQLException {
		sqlMapClientTemplate.insert("dailyReport.insertDailyReport", dailyReport);
	}

	// 일일보고 수정
	public void updateDailyReportWorker(DailyReport dailyReport) throws SQLException {
		sqlMapClientTemplate.update("dailyReport.updateDailyReportWorker", dailyReport);
	}

	/********************    Weekly Plan과 연결         *****************************************************/
	public String selectDailyReportByEmpDate(DailyReport dailyReport) throws Exception{
		return (String)sqlMapClientTemplate.queryForObject("dailyReport.selectDailyReportByEmpDate", dailyReport);
	}

	public ArrayList<DailyReport> searchDailyReport(String empId, String[] keywordList, int rownum, int page) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("empId", empId);
		map.put("keywordList", keywordList);
		map.put("rownum", rownum); //늘어날 list 수
		map.put("page", page);//지금 마지막 list

		ArrayList<DailyReport> reportList = (ArrayList<DailyReport>)
				sqlMapClientTemplate.queryForList("dailyReport.searchDailyReport",map);
		return reportList;
	}
	public ArrayList<DailyReport> searchDailyReportByDept(String deptId, String[] keywordList, int rownum, int page) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("deptId", deptId);
		map.put("keywordList", keywordList);
		map.put("rownum", rownum); //늘어날 list 수
		map.put("page", page);//지금 마지막 list

		ArrayList<DailyReport> reportList = (ArrayList<DailyReport>)
				sqlMapClientTemplate.queryForList("dailyReport.searchDailyReport",map);
		return reportList;
	}

}
