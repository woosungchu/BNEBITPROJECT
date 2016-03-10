package com.bnebit.sms.vo;

import java.io.Serializable;

public class Client implements Serializable {
	private static final long serialVersionUID = 124480644534369044L;

	private String clientId;
	private String clientCode;
	private String clientName;
	private String secondName;
	private String address;
	private String phone;
	private String ceo;
	private int isDelete;
	private String regDate;
	public String getClientId() {
		return clientId;
	}
	public void setClientId(String clientId) {
		this.clientId = clientId;
	}
	public String getClientCode() {
		return clientCode;
	}
	public void setClientCode(String clientCode) {
		this.clientCode = clientCode;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public String getSecondName() {
		return secondName;
	}
	public void setSecondName(String secondName) {
		this.secondName = secondName;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public int getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	@Override
	public String toString() {
		return "Client [clientId=" + clientId + ", clientCode=" + clientCode + ", clientName=" + clientName
				+ ", secondName=" + secondName + ", address=" + address + ", phone=" + phone + ", ceo=" + ceo
				+ ", isDelete=" + isDelete + ", regDate=" + regDate + "]";
	}


}
