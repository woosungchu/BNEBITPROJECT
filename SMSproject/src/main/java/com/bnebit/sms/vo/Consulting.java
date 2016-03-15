package com.bnebit.sms.vo;

import java.io.Serializable;

public class Consulting implements Serializable {
	private static final long serialVersionUID = 6597666705672274725L;

	private String consultingId;
	private String title;
	private String regDate;
	private String content;
	private Client client;
	private ConsultingImg consultingImg;
	private DailyReport dailyReport;
	public DailyReport getDailyReport() {
		return dailyReport;
	}
	public void setDailyReport(DailyReport dailyReport) {
		this.dailyReport = dailyReport;
	}
	public String getConsultingId() {
		return consultingId;
	}
	public void setConsultingId(String consultingId) {
		this.consultingId = consultingId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public Client getClient() {
		return client;
	}
	public void setClient(Client client) {
		this.client = client;
	}
	public ConsultingImg getConsultingImg() {
		return consultingImg;
	}
	public void setConsultingImg(ConsultingImg consultingImg) {
		this.consultingImg = consultingImg;
	}

	@Override
	public String toString() {
		return "Consulting [consultingId=" + consultingId + ", title=" + title + ", regDate=" + regDate + ", content="
				+ content + ", client=" + client + ", consultingImg=" + consultingImg + ", dailyReport=" + dailyReport
				+ "]";
	}




}
