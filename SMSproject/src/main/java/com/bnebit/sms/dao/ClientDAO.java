package com.bnebit.sms.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	@SuppressWarnings("unchecked")
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

	public Client selectClientByClientCode(String clientCode) {
		return (Client) sqlMapClientTemplate.queryForObject(nameSpace +  "selectClientByClientCode", clientCode);
	}

	public void insertClient(Client client) {
		sqlMapClientTemplate.insert(nameSpace + "insertClient", client);
	}

	public void updateClient(Client client) {
		sqlMapClientTemplate.update(nameSpace + "updateClient", client);
	}

	public ArrayList<Client> searchClient(String[] keywordList, int rownum, int page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keywordList", keywordList);
		map.put("rownum", rownum); //늘어날 list 수
		map.put("page", page);//지금 마지막 list
		return (ArrayList<Client>) sqlMapClientTemplate.queryForList(nameSpace + "searchClientMain", map);
	}

	public void deleteClientList(List<String> clientIdList) {
		sqlMapClientTemplate.update(nameSpace + "deleteClientList", clientIdList);
	}

	public void deleteClient(String clientId) {
		sqlMapClientTemplate.update(nameSpace + "deleteClient", clientId);
	}


}
