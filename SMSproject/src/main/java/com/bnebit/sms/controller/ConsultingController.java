package com.bnebit.sms.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.ConsultingService;
import com.bnebit.sms.vo.Consulting;
import com.bnebit.sms.vo.ConsultingImg;

@Controller
public class ConsultingController {

	@Autowired
	private ConsultingService consultingService;

	// 상담일지 조회
	@RequestMapping(value = "/consulting/selectConsultingView", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> selectConsultingView(Consulting consulting) throws SQLException {
		Map<String, Object> consultingMap = new HashMap<>();
		return consultingMap;
	}

	// 상담일지 작성, 파일추가
	@RequestMapping(value = "/consulting/insertConsulting", method = RequestMethod.POST)
	public @ResponseBody void insertConsulting(Consulting consulting, @RequestParam(value="file", required=false) MultipartFile file) throws SQLException {
		consultingService.insertConsulting(consulting, file);
	}

	// 상담일지 수정, 파일수정
	@RequestMapping(value = "/consulting/updateConsulting", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateConsulting(Consulting consulting, @RequestParam(value="file", required=false) MultipartFile file) throws SQLException {
		Map<String, Object> fileMap = new HashMap<>();
		fileMap = consultingService.updateConsulting(consulting, file);
		return fileMap;
	}

	// 상담일지 삭제, 파일삭제
	@RequestMapping(value = "/consulting/deleteConsulting", method = RequestMethod.POST)
	public @ResponseBody void deleteConsultingWorker(Consulting consulting) throws SQLException {
		consultingService.deleteConsultingWorker(consulting);
	}

	// 파일 다운로드
	@RequestMapping(value = "/consulting/downloadConsultingFile", method = RequestMethod.GET)
	public ModelAndView downloadConsultingFile(String originalFileName, String fileName){
		ModelAndView mav = new ModelAndView();
		mav.addObject("ORIGINAL_FILE_NAME", originalFileName);
		mav.addObject("FILE_NAME", fileName);
		mav.addObject("FOLDER", "//192.168.1.20/Upload/");
		mav.setViewName("downloadView");
		return mav;
	}

}
