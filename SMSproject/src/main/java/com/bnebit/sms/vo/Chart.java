package com.bnebit.sms.vo;

public class Chart {

	private String key;
	private long value;
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public long getValue() {
		return value;
	}
	public void setValue(long value) {
		this.value = value;
	}
	@Override
	public String toString() {
		return "Chart [key=" + key + ", value=" + value + "]";
	}
}
