package com.bnebit.sms.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.DailyPlan;
import com.bnebit.sms.vo.Plan;
@Repository
public class DailyPlanDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	public DailyPlan selectDailyPlan(DailyPlan dailyPlan) throws Exception{
		return (DailyPlan)sqlMapClientTemplate.queryForObject("dailyPlan.selectDailyPlan", dailyPlan);
	}

	public String insertDailyPlan(DailyPlan dailyPlan) throws Exception{
		return (String)sqlMapClientTemplate.insert("dailyPlan.insertDailyPlan", dailyPlan);
	}

	public String selectDailyPlanId(DailyPlan dailyPlan) throws Exception{
		return (String)sqlMapClientTemplate.queryForObject("dailyPlan.selectDailyPlanId", dailyPlan);
	}

	public void updateDailyPlanSales(DailyPlan dailyPlan) throws Exception{
		sqlMapClientTemplate.update("dailyPlan.updateDailyPlanSales", dailyPlan);
	}
}
