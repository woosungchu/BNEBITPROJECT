package com.bnebit.sms.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.bnebit.sms.service.ClientService;
import com.bnebit.sms.util.RestResult;
import com.bnebit.sms.util.ValidationUtil;
import com.bnebit.sms.vo.Client;

@RestController
@SessionAttributes("clientUpdateInfo")
@RequestMapping("/rest/client")
public class ClientRestController {

	@Autowired
	private ClientService clientService;

	@RequestMapping(value = "/insertClient", method = RequestMethod.POST)
	public RestResult insertClient(@Validated(Client.ClientInsert.class) Client client, BindingResult bindingResult) {
		RestResult result = null;
		String code = "success";
		String message = "거래처를 등록하였습니다";
		try {
			result = ValidationUtil.formValidationResult(bindingResult);
			if ("fail".equals(result.getCode())) {
				return result;
			}
			clientService.insertClient(client);
		} catch(IllegalArgumentException e) {
			code = "fail";
			message = e.getMessage();
		}
		result.setMessage(message);
		result.setCode(code);
		result.setUrl("/client/clientAddForm");
		return result;
	}

	@RequestMapping(value = "/updateClient", method = RequestMethod.POST)
	public RestResult updateClient(@Validated(Client.ClientUpdate.class) @ModelAttribute("clientUpdateInfo") Client client, BindingResult bindingResult, SessionStatus sessionStatus) {
		RestResult result = null;
		String code = "success";
		String message = "거래처를 수정하였습니다";
		try {
			result = ValidationUtil.formValidationResult(bindingResult);
			if ("fail".equals(result.getCode())) {
				return result;
			}
			clientService.updateClient(client);
		} catch(IllegalArgumentException e) {
			code = "fail";
			message = e.getMessage();
		}
		sessionStatus.setComplete();
		result.setMessage(message);
		result.setCode(code);
		result.setUrl("/client/clientView?clientId=" + client.getClientId());
		return result;
	}

	@RequestMapping(value = "/searchClient", method = RequestMethod.POST)
	public Client selectClientByClientCode(HttpServletRequest request) {
		Client client = clientService.selectClientByClientCode(request);
		return client;
	}
}
