package com.bnebit.sms.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnebit.sms.vo.TestVO;

@Controller
public class HomeController {
	
//	@Autowired // 선생님한테 왜 안되는지 여쭈어볼것
//	private Logger log;
	
	private Logger log = Logger.getLogger(getClass());
 
    @RequestMapping(value = "/page1", method = RequestMethod.GET)
    public String firstPage(Model model) {
    	log.info("################################## TEST SUCCESS #######################################");
        model.addAttribute("firstPageMessage", "This is the first page");
        System.out.println(123);
        return "firstpage";
    }
 
    @RequestMapping(value = "/page2", method = RequestMethod.GET)
    public String secondPage(Model model) {
        model.addAttribute("secondPageMessage", "This is the second page");
        return "secondpage";
    }
    
    @RequestMapping(value = "/jsonTest", method = RequestMethod.GET)
    public String jsonTest(Model model) {
    	TestVO test = new TestVO();
    	test.setN(1);
    	test.setTest("123");
        model.addAttribute("JSON", test);
        return "JsonView";
    }
}