
package com.bnebit.sms.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.util.exception.LoginCheckException;
import com.bnebit.sms.vo.Employee;

@Aspect
@Component
public class LoginAdvice {

	@Autowired
	ModelAndView mav;

	private Logger log = Logger.getLogger(getClass());

	@Before(value="execution(* com.bnebit.sms.controller.*.*(..)) "
			+ "&& !execution(* com.bnebit.sms.controller.MainController.*(..))")
	public void loginCheck(JoinPoint joinPoint)throws Throwable{
		ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = servletRequestAttributes.getRequest();
		HttpSession session = request.getSession();
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		if (employee == null){
			throw new LoginCheckException("세션정보가 없습니다. 다시 로그인해주세요");
		}
	}




}
