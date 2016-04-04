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
import com.bnebit.sms.vo.Plan;
import com.bnebit.sms.vo.WeeklyPlan;

@Repository
public class WeeklyPlanDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;;

	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★  Admin 용 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectWeeklyPlanList(PageOption<Map<String, Object>> pageOption) throws SQLException {
		List<Map<String,Object>> list = (List<Map<String,Object>>) sqlMapClientTemplate.queryForList("weeklyPlan.selectWeeklyPlanList",pageOption);
		return list;
	}

	public int selectWeeklyPlanListCount(PageOption<Map<String, Object>> pageOption) throws SQLException {
		int records = (Integer) sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklyPlanListCount", pageOption);
		return records;
	}

	@SuppressWarnings("unchecked")
	public ArrayList<WeeklyPlan> selectWeeklyListFromEmp(String empId) {
		ArrayList<WeeklyPlan> list = (ArrayList<WeeklyPlan>)sqlMapClientTemplate.queryForList("weeklyPlan.selectWeeklyListFromEmp",empId);
		return list;
	}

	public void deleteWeeklyPlanList(String[] ids) throws SQLException {
		sqlMapClientTemplate.delete("weeklyPlan.deleteWeeklyPlanList",ids);
	}

	public void deleteWeeklyPlan(String id) throws SQLException {
		sqlMapClientTemplate.delete("weeklyPlan.deleteWeeklyPlan",id);
	}

	public void updateWeeklyPlanTitle(WeeklyPlan weeklyPlan) throws SQLException {
		sqlMapClientTemplate.update("weeklyPlan.updateWeeklyPlanTitle",weeklyPlan);
	}
	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */
	public ArrayList<WeeklyPlan> selectWeeklyPlanListEmp(String empId, int rownum) throws Exception{
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("empId", empId);
		map.put("rownum", rownum);
		ArrayList <WeeklyPlan> planList=(ArrayList<WeeklyPlan>)sqlMapClientTemplate.queryForList("weeklyPlan.selectWeeklyPlanListEmp", map);
		return planList;
	}

	public ArrayList<WeeklyPlan> selectWeeklyPlanListManager (String deptId, int rownum) throws Exception{
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("deptId", deptId);
		map.put("rownum", rownum);
		ArrayList <WeeklyPlan> planList=(ArrayList<WeeklyPlan>)sqlMapClientTemplate.queryForList("weeklyPlan.selectWeeklyPlanListManager", map);
		return planList;
	}

	public ArrayList<WeeklyPlan> selectWeeklyPlanListWeek (String deptId, String monday, int rownum) throws Exception{
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("deptId", deptId);
		map.put("monday", monday);
		map.put("rownum", rownum);
		ArrayList<WeeklyPlan> planList=(ArrayList<WeeklyPlan>)sqlMapClientTemplate.queryForList("weeklyPlan.selectWeeklyPlanListWeek", map);
		return planList;
	}

	public int selectWeeklyListCount(String deptId) throws Exception{
		return (int) sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklyListCount", deptId);
	}

	public int selectWeeklyListEmpCount(String empId) throws Exception{
		return (int) sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklyListEmpCount", empId);
	}

	public int selectWeeklyListWeekCount(WeeklyPlan weeklyPlan) throws Exception{
		return (int) sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklyListWeekCount", weeklyPlan);
	}

	public WeeklyPlan selectWeeklyETC(String weeklyPlanId) throws Exception{
		WeeklyPlan wPlan=(WeeklyPlan)sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklyETC", weeklyPlanId);
		return wPlan;
	}

	public WeeklyPlan selectWeeklyPlan(String weeklyPlanId) throws Exception{
		WeeklyPlan wPlan=(WeeklyPlan)sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklyPlan", weeklyPlanId);
		return wPlan;
	}

	public String selectWeeklyPlanByEmpMonday(WeeklyPlan weeklyPlan) throws Exception{
		return (String)sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklyPlanByEmpMonday", weeklyPlan);
	}

	public void updateWeeklyChecked1(WeeklyPlan weeklyPlan) throws Exception{
		sqlMapClientTemplate.update("weeklyPlan.updateWeeklyChecked1", weeklyPlan);
	}

	public String insertWeeklyPlan(WeeklyPlan weeklyPlan) throws Exception{
		return (String)sqlMapClientTemplate.insert("weeklyPlan.insertWeeklyPlan", weeklyPlan);
	}

	public void updateWeeklyChecked0(WeeklyPlan weeklyPlan) throws Exception{
		sqlMapClientTemplate.update("weeklyPlan.updateWeeklyChecked0", weeklyPlan);
	}

	public String selectWeeklyPlanByPlan(String planId) throws Exception{
		return (String)sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklyPlanByPlan", planId);
	}

	public ArrayList<DailyPlan> selectCalendarManager(String deptId) throws Exception{
		return (ArrayList<DailyPlan>)sqlMapClientTemplate.queryForList("weeklyPlan.selectCalendarManager", deptId);
	}

	public ArrayList<Plan> selectCalendarPlan(String empId) throws Exception{
		return (ArrayList<Plan>) sqlMapClientTemplate.queryForList("weeklyPlan.selectCalendarPlan", empId);
	}

	public int selectWeeklySalesGoal(String empId) {
		return (int)sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklySalesGoal",empId);
	}

	public int selectWeeklySalesGoalManager(String deptId) {
		return (int)sqlMapClientTemplate.queryForObject("weeklyPlan.selectWeeklySalesGoalManager",deptId);
	}
}
