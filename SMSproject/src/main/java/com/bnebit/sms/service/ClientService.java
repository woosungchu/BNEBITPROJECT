package com.bnebit.sms.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.ClientDAO;
import com.bnebit.sms.util.page.PageSet;
import com.bnebit.sms.util.page.ResultPageInfo;
import com.bnebit.sms.vo.Client;

/**
 * 거래처 Service
 */
@Service
public class ClientService {

	@Autowired
	private ClientDAO clientDAO;

	@Autowired
	private ModelAndView mav;

	/**
	 * 거래처 전체 목록 조회
	 *
	 * @param pageParam
	 */
	public ModelAndView selectClientList(PageSet pageSet) {
		pageSet.setSortOrder();
		ResultPageInfo<Client> pageInfo = new ResultPageInfo<>();
		pageSet.setPageParamMap();
		pageSet.setTotalPost(clientDAO.selectClientCount(pageSet));
		pageSet.setPageInfo();
		pageInfo.setDataList(clientDAO.selectClientList(pageSet));
		pageInfo.setPageSet(pageSet);

		mav.addObject("pageInfo", pageInfo);
		mav.setViewName("client/clientList");
		return mav;
	}

	public ModelAndView selectClient(PageSet pageSet, String clientId) {
		Client client = clientDAO.selectClient(clientId);
		mav.addObject("pageSet", pageSet);
		mav.addObject("client", client);
		return mav;
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
