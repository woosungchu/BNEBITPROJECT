package com.bnebit.sms.vo;

import java.io.Serializable;

public class DailyPlan implements Serializable {
	private static final long serialVersionUID = -4143445609716338569L;

	private String dailyPlanId;
	private WeeklyPlan weeklyPlan;
	private String planDate;
	private long salesGoal;
	public String getDailyPlanId() {
		return dailyPlanId;
	}
	public void setDailyPlanId(String dailyPlanId) {
		this.dailyPlanId = dailyPlanId;
	}
	public WeeklyPlan getWeeklyPlan() {
		return weeklyPlan;
	}
	public void setWeeklyPlan(WeeklyPlan weeklyPlan) {
		this.weeklyPlan = weeklyPlan;
	}
	public String getPlanDate() {
		return planDate;
	}
	public void setPlanDate(String planDate) {
		this.planDate = planDate;
	}
	public long getSalesGoal() {
		return salesGoal;
	}
	public void setSalesGoal(long salesGoal) {
		this.salesGoal = salesGoal;
	}
	@Override
	public String toString() {
		return "DailyPlan [dailyPlanId=" + dailyPlanId + ", weeklyPlan=" + weeklyPlan + ", planDate=" + planDate
				+ ", salesGoal=" + salesGoal + "]";
	}


}
