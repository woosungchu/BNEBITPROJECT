
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

import com.bnebit.sms.util.exception.SessionCheckException;
import com.bnebit.sms.vo.Employee;

@Aspect
@Component
public class LoginAdvice {

	@Autowired
	ModelAndView mav;

	private Logger log = Logger.getLogger(getClass());

	/*@Around(value="execution(* com.bnebit.sms.controller.*.*(..)) "
			+ "&& !execution(* com.bnebit.sms.controller.MainController.*(..))")
//	@Around(value="execution(* com.bnebit.sms.controller.HomeController.*(..))") //개발용
	public Object loginCheck(ProceedingJoinPoint joinPoint)throws Throwable{
		System.out.println("joinPoint.getStaticPart() = "+joinPoint.getStaticPart());

		if((joinPoint.proceed() instanceof ModelAndView || joinPoint.getStaticPart().toString().startsWith("execution(void "))){
			log.info("LoginAdvice.@Around 진입");
			for(Object arg : joinPoint.getArgs()){
				if(arg instanceof HttpSession || arg instanceof HttpServletRequest){
					HttpSession session;
					if(arg instanceof HttpServletRequest){
						session = ((HttpServletRequest)arg).getSession();
					}else{
						session = (HttpSession) arg;
					}
					Employee employee = (Employee) session.getAttribute("LOGIN_USER");

					if(employee == null){
						log.info("도둑을 잡았습니다!! 도둑을 잡았습니다!! 도둑을 잡았습니다!! 도둑을 잡았습니다!! ");
						mav.addObject("MESSAGE", "Login은 하고 가셔야지요!");
						mav.setViewName("forward:/"); // cookie check //없으면 알아서 loginForm으로 감
						return mav;
					}
				}
			}
		}
//		if((joinPoint.proceed() instanceof PageOption<?>)){
//			return (PageOption<?>) joinPoint.proceed();
//		}
		return joinPoint.proceed();
	}*/

	@Before(value="execution(* com.bnebit.sms.controller.*.*(..)) "
			+ "&& !execution(* com.bnebit.sms.controller.MainController.*(..))")
//	@Around(value="execution(* com.bnebit.sms.controller.HomeController.*(..))") //개발용
	public void loginCheck(JoinPoint joinPoint)throws Throwable{
		ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = servletRequestAttributes.getRequest();
		HttpSession session = request.getSession();
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		if (employee == null){
			throw new SessionCheckException("세션정보가 없습니다. 다시 로그인해주세요");
		}
	}




}
