package com.bnebit.sms.util;

import java.io.Serializable;

public class RestResult implements Serializable {
	private static final long serialVersionUID = 4423571512027049196L;

	private String code;
	private String message;
	private String url;
	private String field;

	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getCode() {
		return code;
	}
	public String getMessage() {
		return message;
	}
	public String getUrl() {
		return url;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public void setUrl(String url) {
		this.url = url;
	}


}
