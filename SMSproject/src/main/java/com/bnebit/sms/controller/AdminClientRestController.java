package com.bnebit.sms.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.bnebit.sms.service.ClientService;
import com.bnebit.sms.util.RestResult;
import com.bnebit.sms.util.ValidationUtil;
import com.bnebit.sms.util.page.GridPageSet;
import com.bnebit.sms.util.page.ResultPageInfo;
import com.bnebit.sms.vo.Client;

@RestController
@SessionAttributes("clientUpdateInfo")
@RequestMapping("/rest/admin/client")
public class AdminClientRestController {
	@Autowired
	private ClientService clientService;
	@RequestMapping(value = "/selectClientList", method = RequestMethod.POST)
	public ResultPageInfo<Client> selectClientList(GridPageSet gridPageSet, HttpServletRequest request) {
		gridPageSet.setGridPageInfo();
		ResultPageInfo<Client> pageInfo = null;
		try {
			pageInfo = clientService.selectClientList(gridPageSet, request);
		} catch(Exception e) {
			e.printStackTrace();
		}

		return pageInfo;
	}

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
		result.setUrl("/admin/client/clientList");
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
		result.setUrl("/admin/client/clientView?clientId=" + client.getClientId());
		return result;
	}

	@RequestMapping(value = "/deleteClientList", method = RequestMethod.POST)
	public RestResult deleteClientList(@RequestParam("clientIdList[]") List<String> clientIdList) {
		RestResult result = new RestResult();
		String code = "success";
		String message = "거래처를 삭제하였습니다";
		try {
			clientService.deleteClientList(clientIdList);
		} catch(Exception e) {
			code = "fail";
			message = "server error!!! 관리자에게 문의바랍니다";
		}
		result.setMessage(message);
		result.setCode(code);
		return result;
	}

	@RequestMapping(value = "/deleteClient", method = RequestMethod.POST)
	public RestResult deleteClient(@RequestParam("clientId") String clientId) {
		RestResult result = new RestResult();
		String code = "success";
		String message = "거래처를 삭제하였습니다";
		try {
			clientService.deleteClient(clientId);
		} catch(Exception e) {
			code = "fail";
			message = "server error!!! 관리자에게 문의바랍니다";
		}
		result.setMessage(message);
		result.setCode(code);
		result.setUrl("/admin/client/clientList");
		return result;
	}
}
