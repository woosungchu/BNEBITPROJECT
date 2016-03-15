package com.bnebit.sms.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.DailyReport;
import com.bnebit.sms.vo.Event;

@Repository
public class DailyReportDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;

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

	// 일일보고 목록조회(팀장)
	@SuppressWarnings("unchecked")
	public ArrayList<DailyReport> selectDailyReportListLeader(Map<String, Object> paramMap) throws SQLException {
		ArrayList<DailyReport> dailyReportListLeader = (ArrayList<DailyReport>) sqlMapClientTemplate
				.queryForList("dailyReport.selectDailyReportListLeader", paramMap);
		return dailyReportListLeader;
	}

	// 일일보고 목록조회(팀원)
	@SuppressWarnings("unchecked")
	public ArrayList<DailyReport> selectDailyReportListWorker(Map<String, Object> paramMap) throws SQLException {
		ArrayList<DailyReport> dailyReportListWorker = (ArrayList<DailyReport>) sqlMapClientTemplate
				.queryForList("dailyReport.selectDailyReportListWorker", paramMap);
		return dailyReportListWorker;
	}

	// 이벤트 조회
	public Event selectEvent() throws SQLException {
		Event event = (Event) sqlMapClientTemplate.queryForObject("dailyReport.selectEvent");
		return event;
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

}
