package com.bnebit.sms.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.ConsultingDAO;
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
		ArrayList<Consulting> consultingList = (ArrayList<Consulting>) consultingDAO.selectConsultingListWorker(paramMap);

		ModelAndView mav = new ModelAndView();
		mav.addObject(consultingList);
		return mav;
	}

	// 상담일지 조회
	public ModelAndView selectConsultingView(Consulting consulting) throws SQLException {
		Map<String, Object> consultingMap = (Map<String, Object>) consultingDAO.selectConsultingView(consulting);

		ModelAndView mav = new ModelAndView();
		mav.addObject(consultingMap);
		return mav;
	}

	// 상담일지 작성
	public void insertConsulting(Consulting consulting) throws SQLException {
		consultingDAO.insertConsulting(consulting);
	}

	// 상담일지 파일추가
	public void insertConsultingImg(ConsultingImg consultingImg) throws SQLException {
		consultingDAO.insertConsultingImg(consultingImg);
	}

	// 상담일지 수정
	public void updateConsulting(Consulting consulting) throws SQLException {
		consultingDAO.updateConsulting(consulting);
	}

	// 상담일지 파일수정
	public void updateConsultingImg(ConsultingImg consultingImg) throws SQLException {
		consultingDAO.updateConsultingImg(consultingImg);
	}

	// 상담일지 삭제
	public void deleteConsultingWorker(Consulting consulting) throws SQLException {
		consultingDAO.deleteConsultingWorker(consulting);
	}

	// 상담일지 파일삭제
	public void deleteConsultingImg(ConsultingImg consultingImg) throws SQLException {
		consultingDAO.deleteConsultingImg(consultingImg);
	}
}
