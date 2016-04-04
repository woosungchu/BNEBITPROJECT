package com.bnebit.sms.websocket;

import org.apache.log4j.Logger;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptorAdapter;
import org.springframework.stereotype.Component;

@Component("presenceChannelInterceptor")
public class PresenceChannelInterceptor extends ChannelInterceptorAdapter {

	private Logger logger = Logger.getLogger(getClass());

	/*TODO-이만섭: 웹소켓 연결 확인 하기 위한 인터셉터
	 * 자세한 것은 http://springsource.tistory.com/48, http://springsource.tistory.com/50
	 * 설정의 경우 @Component를 통해 servlet에서 bean으로 읽을 수 있도록 하고,
	 * dispatcher-servlet에서 websocket:message-broker에 등록하면 됨
	 * */
	@Override
	public void postSend(Message<?> message, MessageChannel channel, boolean sent) {

		StompHeaderAccessor sha = StompHeaderAccessor.wrap(message);

		if (sha.getCommand() == null) {
			return;
		}

		String sessionId = sha.getSessionId();

		switch (sha.getCommand()) {
		case CONNECT:
//			logger.info("STOMP Connect [sessionId: " + sessionId + "]");
			break;
		case CONNECTED:
//			logger.info("STOMP Connected [sessionId: " + sessionId + "]");
			break;
		case DISCONNECT:
//			logger.info("STOMP Disconnect [sessionId: " + sessionId + "]");
			break;
		default:
			break;

		}
	}
}
