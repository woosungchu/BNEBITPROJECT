package com.bnebit.sms.dao;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.Plan;

@Repository
public class PlanDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	public String insertPlan(Plan plan) throws Exception{
		return (String)sqlMapClientTemplate.insert("plan.insertPlan", plan);
	}

	public void deletePlan(String planId) throws Exception{
		sqlMapClientTemplate.delete("plan.deletePlan", planId);
	}

	public ArrayList<Plan> selectPlan(DailyPlan dailyPlan) throws Exception{
		return (ArrayList<Plan>) sqlMapClientTemplate.queryForList("plan.selectPlan", dailyPlan);
	}

}
