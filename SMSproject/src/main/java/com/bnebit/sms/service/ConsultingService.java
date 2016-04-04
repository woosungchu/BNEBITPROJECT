package com.bnebit.sms.service;

import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.ConsultingDAO;
import com.bnebit.sms.util.FileRenamePolicy;
import com.bnebit.sms.util.UploadUtil;
import com.bnebit.sms.vo.Consulting;
import com.bnebit.sms.vo.ConsultingImg;

@Service("consultingService")
public class ConsultingService {

	@Autowired
	private ConsultingDAO consultingDAO;

	// 상담일지 목록조회
	public ModelAndView selectConsultingListWorker(HttpServletRequest request) throws SQLException {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dailyReportId", request.getParameter("dailyReportId"));
		Iterator<String> iterator = paramMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = iterator.next();
			System.out.println("key : " + key + ", value : " + paramMap.get(key));
		}
		ArrayList<Consulting> consultingList = (ArrayList<Consulting>) consultingDAO.selectConsultingListWorker(paramMap);

		for(int i=0; i<consultingList.size(); i++) {
			System.out.println(consultingList.get(i));
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("consultingList", consultingList);
		return mav;
	}

	// 상담일지 작성, 파일추가
	public void insertConsulting(Consulting consulting, MultipartFile file) throws SQLException {
		String index = consultingDAO.insertConsulting(consulting);

		ConsultingImg consultingImg = new ConsultingImg();
		if(file != null && !file.isEmpty()) {
			File defaultFile = new File("//192.168.1.20/Upload/", file.getOriginalFilename());
			System.out.println("기존 fileName : " + file.getOriginalFilename());
			defaultFile = FileRenamePolicy.rename(defaultFile);
			String fileName = defaultFile.getName();
			System.out.println("Rename fileName : " + fileName);
			UploadUtil.uploadHelper(file, fileName);

			consultingImg.setImgName(fileName);
			consultingImg.setOriginName(file.getOriginalFilename());
			consultingImg.setConsultingId(index);
			consultingDAO.insertConsultingImg(consultingImg);
		}
	}

	// 상담일지 수정, 파일수정
	public Map<String, Object> updateConsulting(Consulting consulting, MultipartFile file) throws SQLException {
		Map<String, Object> fileMap = new HashMap<>();

		consultingDAO.updateConsulting(consulting);
		ConsultingImg consultingImg = new ConsultingImg();
		System.out.println(consulting);
		// 수정 전 file 유무
		String name = consulting.getConsultingImg().getImgName();
		System.out.println(file);
		System.out.println(name);

		if(file != null && !file.isEmpty()) {
			File defaultFile = new File("//192.168.1.20/Upload/", file.getOriginalFilename());
			System.out.println("기존 fileName : " + file.getOriginalFilename());
			defaultFile = FileRenamePolicy.rename(defaultFile);
			String fileName = defaultFile.getName();
			System.out.println("Rename fileName : " + fileName);
			UploadUtil.uploadHelper(file, fileName);

			consultingImg.setImgName(fileName);
			consultingImg.setOriginName(file.getOriginalFilename());
			consultingImg.setConsultingId(consulting.getConsultingId());

			if(name.equals("")) {
				consultingDAO.insertConsultingImg(consultingImg);
			} else {
				consultingDAO.updateConsultingImg(consultingImg);
			}
			fileMap.put("originalFileName", file.getOriginalFilename());
			fileMap.put("fileName", fileName);
			return fileMap;
		}
		return null;
	}

	// 상담일지 삭제, 파일삭제
	public void deleteConsultingWorker(Consulting consulting) throws SQLException {
		ConsultingImg consultingImg = new ConsultingImg();
		consultingImg.setConsultingId(consulting.getConsultingId());
		consultingDAO.deleteConsultingWorker(consulting);
		consultingDAO.deleteConsultingImg(consultingImg);
	}
}
