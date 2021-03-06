package com.bnebit.sms.util.advice;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.util.exception.LoginCheckException;
import com.bnebit.sms.util.exception.SessionCheckException;

@ControllerAdvice(annotations = Controller.class)
public class ControllerExceptionHandler {

	@ExceptionHandler(LoginCheckException.class)
	public Object handlerAuthorityException(HttpServletRequest request, LoginCheckException e) {
		String accept = request.getHeader("X-Requested-With");
		if ("XMLHttpRequest".equals(accept)) {
			/**
			 * message alert는 utils.js AjaxHandler error 수정
			 * (request.responseText로 출력)
			 */
			return new ResponseEntity<String>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
		} else {
			ModelAndView mav = new ModelAndView();
			mav.addObject("MESSAGE", e.getMessage());
			mav.setViewName("redirect:/"); // cookie check //없으면 알아서 loginForm으로 감
			return mav;
		}
	}
	
//	@ExceptionHandler(SessionCheckException.class)
//	public Object handlerAuthorityException(HttpServletRequest request, SessionCheckException e) {
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("MESSAGE", e.getMessage());
//		mav.setViewName(e.getUrl());
//		return mav;
//	}
}
