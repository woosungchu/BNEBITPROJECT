package com.bnebit.sms.util;

import org.apache.log4j.Logger;

public class LogFactory {
	public Logger getLog(){
		return Logger.getLogger(getClass());
	}

}
