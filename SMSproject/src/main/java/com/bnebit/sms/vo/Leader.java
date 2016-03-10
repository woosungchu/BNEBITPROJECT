package com.bnebit.sms.vo;

import java.io.Serializable;

public class Leader implements Serializable {
	private static final long serialVersionUID = 8564829564781004926L;

	private String leaderId;
	private Employee employee;
	private Dept dept;
	public String getLeaderId() {
		return leaderId;
	}
	public void setLeaderId(String leaderId) {
		this.leaderId = leaderId;
	}
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public Dept getDept() {
		return dept;
	}
	public void setDept(Dept dept) {
		this.dept = dept;
	}
	@Override
	public String toString() {
		return "Leader [leaderId=" + leaderId + ", employee=" + employee + ", dept=" + dept + "]";
	}


}
