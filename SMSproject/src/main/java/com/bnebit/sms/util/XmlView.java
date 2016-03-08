package com.bnebit.sms.util;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

public class XmlView  extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request
			, HttpServletResponse response)	throws Exception {
		   response.setContentType("text/xml;charset=UTF-8");
		      PrintWriter out=response.getWriter();
		      String xml=(String)model.get("XML");
		      out.print(xml);
		      out.flush();
		      out.close();
	}
}