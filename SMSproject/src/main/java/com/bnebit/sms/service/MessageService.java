package com.bnebit.sms.service;

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

	public void insertMessage(Message message) {
		String receiverEmpIds = message.getReceiver().getEmpId();
		String[] receiverEmpIdArr = receiverEmpIds.split(",");
		for (String empId : receiverEmpIdArr) {
			Employee receiver = new Employee();
			receiver.setEmpId(empId);
			message.setReceiver(receiver);
			messageDAO.insertMessage(message);
		}

		notificationReceiver(receiverEmpIdArr);
	}

	private void notificationReceiver(String[] receiverEmpIdArr) {
		List<String> receiverEmailList = messageDAO.selectReceiverEmailList(receiverEmpIdArr);
		for (int i = 0; i < receiverEmpIdArr.length; i++) {
			int count = messageDAO.selectUncheckedMessageConut(receiverEmpIdArr[i]);
			template.convertAndSend("/newMessage/notice/" + receiverEmailList.get(i), count);
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

}
