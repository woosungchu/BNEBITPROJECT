package com.bnebit.sms.util.exception;

//리팩토링 후 안 쓰는 Exception
@Deprecated
public class SessionCheckException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	private String message;
	private String url = "/error/errorPage";
	
	public SessionCheckException() {
		this.message = "에러가 났네요~ 에러가 났어요~";
	}
	
	public SessionCheckException(String message) {
		this.message = message;
	}
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	public String getUrl() {
		return url;
	}
}
