package com.bnebit.sms.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Plan;
import com.bnebit.sms.vo.WeeklyPlan;

@Repository
public class PlanDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	public String insertPlan(Plan plan){
		return (String)sqlMapClientTemplate.insert("plan.insertPlan", plan);
	}

	public void deletePlan(String planId){
		sqlMapClientTemplate.delete("plan.deletePlan", planId);
	}

	public ArrayList<Plan> selectPlan(DailyPlan dailyPlan){
		return (ArrayList<Plan>) sqlMapClientTemplate.queryForList("plan.selectPlan", dailyPlan);
	}
	
	public ArrayList<Plan> selectTodayPlan(String empId){
		return (ArrayList<Plan>) sqlMapClientTemplate.queryForList("plan.selectTodayPlan", empId);
	}
	
	public ArrayList<HashMap<String, String>> selectTodayDeptPlan(String deptId){
		ArrayList<HashMap<String, String>> planList =  (ArrayList<HashMap<String, String>>)
				sqlMapClientTemplate.queryForList("plan.selectTodayDeptPlan", deptId);
		return planList;
	}

	public void updateType(String planId, String checked) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("planId", planId);
		map.put("checked", checked);
		sqlMapClientTemplate.update("plan.updateType", map);
	}

	public ArrayList<Plan> searchPlan(String empId, String[] keywordList, int rownum, int page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empId", empId);
		map.put("keywordList", keywordList);
		map.put("rownum", rownum); //늘어날 list 수
		map.put("page", page);//지금 마지막 list

		ArrayList<Plan> planList = (ArrayList<Plan>) 
				sqlMapClientTemplate.queryForList("plan.searchPlan",map);
		return planList;
	}

	public ArrayList<Plan> searchPlanByDept(String deptId, String[] keywordList, int rownum, int page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deptId", deptId);
		map.put("keywordList", keywordList);
		map.put("rownum", rownum); //늘어날 list 수
		map.put("page", page);//지금 마지막 list

		ArrayList<Plan> planList = (ArrayList<Plan>) 
				sqlMapClientTemplate.queryForList("plan.searchPlan",map);
		return planList;
	}
}
