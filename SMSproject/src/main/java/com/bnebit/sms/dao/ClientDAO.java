package com.bnebit.sms.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.util.page.PageSet;
import com.bnebit.sms.vo.Client;

@Repository
public class ClientDAO {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	private String nameSpace = "client.";



	/**
	 * 거래처 전체 개수 조회
	 *
	 * @param pageSet
	 */
	public long selectClientCount(PageSet pageSet) {
		return (Long) sqlMapClientTemplate.queryForObject(nameSpace + "selectClientCount", pageSet);
	}

	/**
	 * 거래처 전체 목록 조회
	 *
	 * @param pageSet
	 */
	public List<Client> selectClientList(PageSet pageSet) {
		return (List<Client>) sqlMapClientTemplate.queryForList(nameSpace + "selectClientList", pageSet);
	}

	/**
	 * 거래처 조회
	 *
	 * @param pageSet
	 */
	public Client selectClient(String clientId) {
		return (Client) sqlMapClientTemplate.queryForObject(nameSpace + "selectClient", clientId);
	}

	public String selectClientCode(String clientCode) {
		return (String) sqlMapClientTemplate.queryForObject(nameSpace +  "selectClientCode", clientCode);
	}

	public void insertClient(Client client) {
		sqlMapClientTemplate.insert(nameSpace + "insertClient", client);
	}

	public void updateClient(Client client) {
		sqlMapClientTemplate.update(nameSpace + "updateClient", client);
	}

}
