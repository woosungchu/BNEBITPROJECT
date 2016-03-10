package com.bnebit.sms.vo;

import java.io.Serializable;

public class Validation implements Serializable {
	private static final long serialVersionUID = 1943989753846097873L;

	private String validId;
	private Employee employee;
	private String code;
	private String validDate;
	public String getValidId() {
		return validId;
	}
	public void setValidId(String validId) {
		this.validId = validId;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getValidDate() {
		return validDate;
	}
	public void setValidDate(String validDate) {
		this.validDate = validDate;
	}
	@Override
	public String toString() {
		return "Validation [validId=" + validId + ", employee=" + employee + ", code=" + code + ", validDate="
				+ validDate + "]";
	}


}
