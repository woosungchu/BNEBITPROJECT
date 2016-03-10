package com.bnebit.sms.vo;

import java.io.Serializable;

public class Message implements Serializable {
	private static final long serialVersionUID = 5100590911051534985L;

	private String msgId;
	private Employee receiver; //This is LOGIN_USER // edited by woosungchu
	private Employee sender;
	private String content;
	private int checked;
	private String msgDate;
	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	public Employee getReceiver() {
		return receiver;
	}
	public void setReceiver(Employee receiver) {
		this.receiver = receiver;
	}
	public Employee getSender() {
		return sender;
	}
	public void setSender(Employee sender) {
		this.sender = sender;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getChecked() {
		return checked;
	}
	public void setChecked(int checked) {
		this.checked = checked;
	}
	public String getMsgDate() {
		return msgDate;
	}
	public void setMsgDate(String msgDate) {
		this.msgDate = msgDate;
	}
	@Override
	public String toString() {
		return "Message [msgId=" + msgId + ", receiver=" + receiver + ", sender=" + sender + ", content=" + content
				+ ", checked=" + checked + ", msgDate=" + msgDate + "]";
	}


}
