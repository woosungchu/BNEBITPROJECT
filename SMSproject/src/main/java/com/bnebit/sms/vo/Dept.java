package com.bnebit.sms.vo;

import java.io.Serializable;

public class Dept implements Serializable {
	private static final long serialVersionUID = 8508959680381628707L;

	private String deptId;
	private String deptName;
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	@Override
	public String toString() {
		return "Dept [deptId=" + deptId + ", deptName=" + deptName + "]";
	}


}
