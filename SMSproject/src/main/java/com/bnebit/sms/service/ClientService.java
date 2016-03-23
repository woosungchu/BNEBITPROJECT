package com.bnebit.sms.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bnebit.sms.dao.ClientDAO;
import com.bnebit.sms.util.page.PageSet;
import com.bnebit.sms.util.page.ResultPageInfo;
import com.bnebit.sms.vo.Client;
import com.google.common.base.Preconditions;

/**
 * 거래처 Service
 */
@Service
public class ClientService {

	@Autowired
	private ClientDAO clientDAO;

	/*@Autowired
	private ModelAndView mav;*/

	/**
	 * 거래처 전체 목록 조회
	 *
	 * @param pageParam
	 */
	public ResultPageInfo<Client> selectClientList(PageSet pageSet, HttpServletRequest request) {
		pageSet.isMobile(request);
		pageSet.setSortOrder();
		ResultPageInfo<Client> pageInfo = new ResultPageInfo<>();
		pageSet.setPageParamMap();
		pageSet.setTotalPost(clientDAO.selectClientCount(pageSet));
		pageSet.setPageInfo();
		pageInfo.setDataList(clientDAO.selectClientList(pageSet));
		pageInfo.setPageSet(pageSet);
		return pageInfo;
	}

	public Client selectClient(PageSet pageSet, String clientId) {
		Client client = clientDAO.selectClient(clientId);
		client.setPhoneSplit();
		return client;
	}
	/**
	 * 거래처 추가
	 *
	 * @param client
	 */
	public void insertClient(Client client) {
		String clientCode = client.getClientCode();
		String selectClientCode = clientDAO.selectClientCode(clientCode);
		Preconditions.checkArgument(!clientCode.equals(selectClientCode), "등록된 고객코드입니다. 다시 입력해주세요");
		client.setPhone();
		clientDAO.insertClient(client);
	}

	public void updateClient(Client client) {
		client.setPhone();
		clientDAO.updateClient(client);
	}

/*	*//**
	 * 거래처 추가
	 *
	 * @param client
	 *//*
	public void insertClient(Client client) {
		 default generated stub ;
		return null;
	}

	*//**
	 * 거래처 수정
	 *
	 * @param client
	 *//*
	public void updateClient(Client client) {
		 default generated stub ;
		return null;
	}

	*//**
	 * 관리자 : 거래처 삭제(IsDelete 1로 수정)
	 *
	 * @param clientIdList
	 *//*
	public void updateIsDelete(List clientIdList) {
		 default generated stub ;
		return null;
	}*/
}
