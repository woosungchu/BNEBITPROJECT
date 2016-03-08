package com.bnebit.sms.util;

import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			   HttpServletRequest request, HttpServletResponse response)
					   throws Exception {
		  String originalFilename = (String)model.get("ORIGINAL_FILE_NAME");
		  String filename = (String) model.get("FILE_NAME");
		  String folder = (String) model.get("FOLDER");
		  
		  originalFilename = URLEncoder.encode(originalFilename,"UTF-8");
		  
		  response.setHeader("Content-Disposition", "attachment;filename="+originalFilename+";");
		  OutputStream out = response.getOutputStream();
		  FileInputStream in = new FileInputStream(folder+"/"+filename);
		  FileCopyUtils.copy(in, out);
		  
		  out.flush();
		  out.close();
	}
}