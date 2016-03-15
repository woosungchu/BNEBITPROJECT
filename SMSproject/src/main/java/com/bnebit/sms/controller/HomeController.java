package com.bnebit.sms.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.TestVO;

@Controller
@RequestMapping("/home")
public class HomeController {
	
	@Autowired
	ModelAndView mav;
	
	private Logger log = Logger.getLogger(getClass());
	
    @RequestMapping(value = "/page1", method = RequestMethod.GET)
    public ModelAndView firstPage() {
    	mav.addObject("firstPageMessage", "This is the first page");
    	mav.setViewName("mainPage");
        return mav;
    }
 
    @RequestMapping(value = "/page2", method = RequestMethod.GET)
    public ModelAndView secondPage(HttpSession session) {
    	mav.addObject("secondPageMessage", "This is the second page");
    	mav.setViewName("secondPage");
    	return mav;
    }
    
    @RequestMapping(value = "/jsonTest", method = RequestMethod.GET)
    public ModelAndView jsonTest() {
    	TestVO test = new TestVO();
    	test.setN(1);
    	test.setTest("123");
    	mav.addObject("JSON", test);
    	mav.setViewName("jsonView");
        return mav;
    }
}