package com.bnebit.sms.vo;

import java.io.Serializable;

//woosungchu changed property mac_addr to macAddr
public class SessionKey implements Serializable {
	private static final long serialVersionUID = 1783847408629929427L;

	private String sessionKeyId;
	private String sessionId;
	private Employee employee;
	private String ip;
	private String expiration;
	private String macAddr;
	public String getSessionKeyId() {
		return sessionKeyId;
	}
	public void setSessionKeyId(String sessionKeyId) {
		this.sessionKeyId = sessionKeyId;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getExpiration() {
		return expiration;
	}
	public void setExpiration(String expiration) {
		this.expiration = expiration;
	}
	public String getMacAddr() {
		return macAddr;
	}
	public void setMacAddr(String macAddr) {
		this.macAddr = macAddr;
	}
	@Override
	public String toString() {
		return "SessionKey [sessionKeyId=" + sessionKeyId + ", sessionId=" + sessionId + ", employee=" + employee
				+ ", ip=" + ip + ", expiration=" + expiration + ", macAddr=" + macAddr + "]";
	}


}
