package com.bnebit.sms.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
public class MailUtil {

	@Autowired
	private MailSender mail;
	
	public void sendMessage(String toAddr, String fromAddr, String subject, String msgBody){
		SimpleMailMessage msg = new SimpleMailMessage();
//		msg.setTo(toAddr); // 배포용
		msg.setTo("woosungchutest@gmail.com");//개발용
		msg.setFrom(fromAddr);
		msg.setSubject(subject);
		msg.setText(msgBody);
		System.out.println(msg);
		mail.send(msg);
	}
	
}
