package com.bnebit.sms.vo;

public class TestVO {
	private int n;
	private String test;
	public int getN() {
		return n;
	}
	public void setN(int n) {
		this.n = n;
	}
	public String getTest() {
		return test;
	}
	public void setTest(String test) {
		this.test = test;
	}
	@Override
	public String toString() {
		return "TestVO [n=" + n + ", test=" + test + "]";
	}
	
}
