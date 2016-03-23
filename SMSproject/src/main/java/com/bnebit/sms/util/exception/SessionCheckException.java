package com.bnebit.sms.util.exception;

public class SessionCheckException extends RuntimeException {
	private static final long serialVersionUID = 4119269124325858464L;

	private String code;
	private String message;
	private String url;

	public SessionCheckException(String message) {
		this.message = message;
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
