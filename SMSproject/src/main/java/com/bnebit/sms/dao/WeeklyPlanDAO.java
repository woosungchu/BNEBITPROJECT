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

	public void deleteWeeklyPlanList(String[] ids) throws SQLException {
		sqlMapClientTemplate.delete("weeklyPlan.deleteWeeklyPlanList",ids);
	}

	public void deleteWeeklyPlan(String id) throws SQLException {
		sqlMapClientTemplate.delete("weeklyPlan.deleteWeeklyPlan",id);
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

	public ArrayList<WeeklyPlan> selectWeeklyPlanListWeek (WeeklyPlan weeklyPlan, int rownum) throws Exception{
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("deptId", weeklyPlan.getEmployee().getDept().getDeptId());
		map.put("monday", weeklyPlan.getMonday());
		map.put("rownum", rownum);
		ArrayList<WeeklyPlan> planList=(ArrayList<WeeklyPlan>)sqlMapClientTemplate.queryForList("weeklyPlan.selectWeeklyPlanListWeek", map);
		return planList;
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

	public ArrayList<DailyPlan> selectCalendarManager(DailyPlan dailyPlan) throws Exception{
		return (ArrayList<DailyPlan>)sqlMapClientTemplate.queryForList("weeklyPlan.selectCalendarManager", dailyPlan);
	}

	public ArrayList<Plan> selectCalendarPlan(DailyPlan dailyPlan) throws Exception{
		return (ArrayList<Plan>) sqlMapClientTemplate.queryForList("weeklyPlan.selectCalendarPlan", dailyPlan);
	}
}
