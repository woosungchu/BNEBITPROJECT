package com.bnebit.sms.vo;

import java.io.Serializable;

public class WeeklyPlan implements Serializable {
	private static final long serialVersionUID = 6344810826336767203L;

	private String weeklyPlanId;
	private Employee employee;
	private String regDate;
	private String title;
	private String monday;
	private int checked;
	private long salesGoalSum;
	private long profitSum;
	private String achievement;
	public String getWeeklyPlanId() {
		return weeklyPlanId;
	}
	public void setWeeklyPlanId(String weeklyPlanId) {
		this.weeklyPlanId = weeklyPlanId;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMonday() {
		return monday;
	}
	public void setMonday(String monday) {
		this.monday = monday;
	}
	public int getChecked() {
		return checked;
	}
	public void setChecked(int checked) {
		this.checked = checked;
	}
	public long getSalesGoalSum() {
		return salesGoalSum;
	}
	public void setSalesGoalSum(long salesGoalSum) {
		this.salesGoalSum = salesGoalSum;
	}
	public long getProfitSum() {
		return profitSum;
	}
	public void setProfitSum(long profitSum) {
		this.profitSum = profitSum;
	}
	public String getAchievement() {
		return achievement;
	}
	public void setAchievement(String achievement) {
		this.achievement = achievement;
	}
	@Override
	public String toString() {
		return "WeeklyPlan [weeklyPlanId=" + weeklyPlanId + ", employee=" + employee + ", regDate=" + regDate
				+ ", title=" + title + ", monday=" + monday + ", checked=" + checked + ", salesGoalSum=" + salesGoalSum
				+ ", profitSum=" + profitSum + ", achievement=" + achievement + "]";
	}
}
