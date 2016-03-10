package com.bnebit.sms.vo;

import java.io.Serializable;

public class DailyReport implements Serializable {
	private static final long serialVersionUID = 6900863645073101982L;

	private String dailyReportId;
	private String title;
	private Employee employee;
	private int departure;
	private int arrival;
	private long profit;
	private String regDate;
	private String content;
	private String feedback;
	public String getDailyReportId() {
		return dailyReportId;
	}
	public void setDailyReportId(String dailyReportId) {
		this.dailyReportId = dailyReportId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public int getDeparture() {
		return departure;
	}
	public void setDeparture(int departure) {
		this.departure = departure;
	}
	public int getArrival() {
		return arrival;
	}
	public void setArrival(int arrival) {
		this.arrival = arrival;
	}
	public long getProfit() {
		return profit;
	}
	public void setProfit(long profit) {
		this.profit = profit;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFeedback() {
		return feedback;
	}
	public void setFeedback(String feedback) {
		this.feedback = feedback;
	}
	@Override
	public String toString() {
		return "DailyReport [dailyReportId=" + dailyReportId + ", title=" + title + ", employee=" + employee
				+ ", departure=" + departure + ", arrival=" + arrival + ", profit=" + profit + ", regDate=" + regDate
				+ ", content=" + content + ", feedback=" + feedback + "]";
	}


}
