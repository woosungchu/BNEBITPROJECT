package com.bnebit.sms.vo;

import java.io.Serializable;

public class Event implements Serializable {
	private static final long serialVersionUID = 192349731332346407L;

	private String eventId;
	private String eventDate;
	private int holiday;
	private String title;
	public String getEventId() {
		return eventId;
	}
	public void setEventId(String eventId) {
		this.eventId = eventId;
	}
	public String getEventDate() {
		return eventDate;
	}
	public void setEventDate(String eventDate) {
		this.eventDate = eventDate;
	}
	public int getHoliday() {
		return holiday;
	}
	public void setHoliday(int holiday) {
		this.holiday = holiday;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	@Override
	public String toString() {
		return "Event [eventId=" + eventId + ", eventDate=" + eventDate + ", holiday=" + holiday + ", title=" + title
				+ "]";
	}


}
