package com.bnebit.sms.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Message;

@Repository
public class MessageDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	private String nameSpace = "message.";

	public void insertMessage(Message message) {
		sqlMapClientTemplate.insert(nameSpace + "insertMessage", message);
	}

	public List<Employee> searchEmployee(Employee searchEmployee) {
		return (List<Employee>) sqlMapClientTemplate.queryForList(nameSpace + "searchEmployee", searchEmployee);
	}

	public List<String> selectReceiverEmailList(String[] receiverEmpIdArr) {
		return (List<String>) sqlMapClientTemplate.queryForList(nameSpace + "selectReceiverEmailList", receiverEmpIdArr);
	}

	public int selectUncheckedMessageConut(String receiverEmpId) {
		return (Integer) sqlMapClientTemplate.queryForObject(nameSpace + "selectUncheckedMessageConut", receiverEmpId);
	}

	public long selectReceiveMessageCount(Map<String, Object> paramMap) {
		return (Long) sqlMapClientTemplate.queryForObject(nameSpace + "selectReceiveMessageCount", paramMap);
	}

	public List<Message> selectReceiveMessageList(Map<String, Object> paramMap) {
		return (List<Message>) sqlMapClientTemplate.queryForList(nameSpace + "selectReceiveMessageList", paramMap);
	}

	public void updateReadMessage(String msgId) {
		sqlMapClientTemplate.update(nameSpace + "updateReadMessage", msgId);
	}

	public long selectSendMessageCount(Map<String, Object> paramMap) {
		return (Long) sqlMapClientTemplate.queryForObject(nameSpace + "selectSendMessageCount", paramMap);
	}

	public List<Message> selectSendMessageList(Map<String, Object> paramMap) {
		return (List<Message>) sqlMapClientTemplate.queryForList(nameSpace + "selectSendMessageList", paramMap);
	}
}
