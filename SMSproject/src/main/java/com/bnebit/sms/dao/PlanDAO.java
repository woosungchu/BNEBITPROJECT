package com.bnebit.sms.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.DailyPlan;
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

	public void updateType(String planId, String checked) {
		Map<String,String> map = new HashMap<String,String>();
		map.put("planId", planId);
		map.put("checked", checked);
		System.out.println(planId + checked);
		sqlMapClientTemplate.update("plan.updateType", map);
	}
}
