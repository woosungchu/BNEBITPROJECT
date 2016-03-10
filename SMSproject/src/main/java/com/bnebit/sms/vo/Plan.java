package com.bnebit.sms.vo;

import java.io.Serializable;

public class Plan implements Serializable {
	private static final long serialVersionUID = 3922280121739523948L;

	private String planId;
	private DailyPlan dailyPlan;
	private String content;
	private String type;
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public DailyPlan getDailyPlan() {
		return dailyPlan;
	}
	public void setDailyPlan(DailyPlan dailyPlan) {
		this.dailyPlan = dailyPlan;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "Plan [planId=" + planId + ", dailyPlan=" + dailyPlan + ", content=" + content + ", type=" + type + "]";
	}


}
