package com.bnebit.sms.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.bnebit.sms.dao.MessageDAO;
import com.bnebit.sms.util.page.PageSet;
import com.bnebit.sms.util.page.ResultPageInfo;
import com.bnebit.sms.vo.Employee;
import com.bnebit.sms.vo.Message;

@Service
public class MessageService {

	@Autowired
	private SimpMessagingTemplate template;

	@Autowired
	private MessageDAO messageDAO;

	public void insertMessage(Message message, List<String> receiverIdList, List<String> receiverEmailList) {
		List<Employee> receiverEmpList = new ArrayList<>();

		for (int i = 0; i < receiverIdList.size(); i++) {
			Employee receiver = new Employee();
			receiver.setEmpId(receiverIdList.get(i));
			receiver.setEmail(receiverEmailList.get(i));
			message.setReceiver(receiver);
			messageDAO.insertMessage(message);
			receiverEmpList.add(receiver);
		}

		notificationReceiver(receiverEmpList);
	}

	private void notificationReceiver(List<Employee> receiverEmpList) {

		for (Employee receiver : receiverEmpList) {
			int count = messageDAO.selectUncheckedMessageConut(receiver.getEmpId());
			template.convertAndSend("/newMessage/notice/" + receiver.getEmail(), count);
		}
	}

	public List<Employee> searchEmployee(String searchName, Employee loginEmployee) {
		Employee searchEmployee = new Employee();
		searchEmployee.setEmpName(searchName);
		searchEmployee.setDept(loginEmployee.getDept());
		return messageDAO.searchEmployee(searchEmployee);
	}

	public int selectUncheckedMessageConut(Employee loginEmployee) {
		return messageDAO.selectUncheckedMessageConut(loginEmployee.getEmpId());
	}

	public ResultPageInfo<Message> receiveMessageList(PageSet pageSet, Employee employee) {
		ResultPageInfo<Message> pageInfo = new ResultPageInfo<>();
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("pageSet", pageSet);
		paramMap.put("empId", employee.getEmpId());
		pageSet.setPageParamMap();
		pageSet.setTotalPost(messageDAO.selectReceiveMessageCount(paramMap));
		pageSet.setPageInfo();
		pageInfo.setDataList(messageDAO.selectReceiveMessageList(paramMap));
		pageInfo.setPageSet(pageSet);
		return pageInfo;
	}

	public ResultPageInfo<Message> sendMessageList(PageSet pageSet, Employee employee) {
		pageSet.setSortOrder();
		ResultPageInfo<Message> pageInfo = new ResultPageInfo<>();
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("pageSet", pageSet);
		paramMap.put("empId", employee.getEmpId());
		pageSet.setPageParamMap();
		pageSet.setTotalPost(messageDAO.selectSendMessageCount(paramMap));
		pageSet.setPageInfo();
		pageInfo.setDataList(messageDAO.selectSendMessageList(paramMap));
		pageInfo.setPageSet(pageSet);
		return pageInfo;
	}

	public void updateReadMessage(String msgId) {
		messageDAO.updateReadMessage(msgId);
	}

	public void deleteMessageList(List<String> messageIdList) {
		for (String msgId : messageIdList) {
			messageDAO.deleteMessageList(msgId);
		}
	}

}
