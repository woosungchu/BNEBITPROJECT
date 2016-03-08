package com.bnebit.sms.util;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

import net.sf.json.JSONObject;

public class JsonView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request
			, HttpServletResponse response)	throws Exception {
		
		   response.setContentType("text/json;charset=UTF-8");
		      PrintWriter out=response.getWriter();
		      JSONObject json=(JSONObject)model.get("JSON");
		      out.print(json);
		      out.flush();
		      out.close();
		      
		      //test 안해봄
	}

}
