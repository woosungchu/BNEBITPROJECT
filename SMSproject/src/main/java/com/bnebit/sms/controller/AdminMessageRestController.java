package com.bnebit.sms.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.bnebit.sms.service.MessageService;
import com.bnebit.sms.util.RestResult;
import com.bnebit.sms.util.page.GridPageSet;
import com.bnebit.sms.util.page.ResultPageInfo;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Message;

@RestController
@RequestMapping("/rest/admin/message")
public class AdminMessageRestController {

	@Autowired
	private MessageService messageService;

	@RequestMapping(value = "/insertMessage", method = RequestMethod.POST)
	public RestResult insertMessage(Message message, HttpSession session,
			@RequestParam("receiverIdList[]") List<String> receiverIdList, @RequestParam("receiverEmailList[]") List<String> receiverEmailList) {
		RestResult result = new RestResult();
		String code = "success";
		String resultMessage = "전송되었습니다.";
		try {
			message.setSender((Employee) session.getAttribute("LOGIN_USER"));
			messageService.insertMessage(message, receiverIdList, receiverEmailList);
		} catch(Exception e) {
			code = "fail";
			resultMessage = "server error!!! 관리자에게 문의바랍니다";
		}
		result.setCode(code);
		result.setMessage(resultMessage);
		return result;
	}

	/**
	 * 보낸 메시지 목록 조회 및 페이지로 이동
	 *
	 * @param pageSet
	 * @param session
	 */
	@RequestMapping(value = "/sendMessageList", method = RequestMethod.POST)
	public ResultPageInfo<Message> sendMessageList(GridPageSet gridPageSet, HttpSession session) {
		gridPageSet.setGridPageInfo();
		Employee employee = (Employee) session.getAttribute("LOGIN_USER");
		ResultPageInfo<Message> pageInfo = null;
		try {
			pageInfo = messageService.sendMessageList(gridPageSet, employee);
		} catch(Exception e) {
			e.printStackTrace();
		}

		return pageInfo;
	}

	@RequestMapping(value = "/deleteMessageList", method = RequestMethod.POST)
	public RestResult deleteMessageList(@RequestParam("messageIdList[]") List<String> messageIdList) {
		RestResult result = new RestResult();
		String code = "success";
		String message = "메시지를 삭제하였습니다";
		try {
			messageService.deleteMessageList(messageIdList);
		} catch(Exception e) {
			code = "fail";
			message = "server error!!! 관리자에게 문의바랍니다";
		}
		result.setMessage(message);
		result.setCode(code);
		return result;
	}

}

