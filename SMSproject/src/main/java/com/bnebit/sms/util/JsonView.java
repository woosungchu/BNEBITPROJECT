package com.bnebit.sms.util;

import java.io.PrintWriter;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

import com.bnebit.sms.vo.TestVO;
import com.google.gson.Gson;

public class JsonView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request
			, HttpServletResponse response)	throws Exception {
		
		   response.setContentType("text/json;charset=UTF-8");
		      PrintWriter out=response.getWriter();
		      Object object=(Object)model.get("JSON");
		      Gson gson = new Gson();
		      out.print(gson.toJson(object));
		      out.flush();
		      out.close();
		      
		      //test 안해봄
	}

}
