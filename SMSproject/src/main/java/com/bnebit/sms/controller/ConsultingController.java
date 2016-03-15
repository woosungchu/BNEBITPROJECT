package com.bnebit.sms.controller;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.service.ConsultingService;
import com.bnebit.sms.vo.Consulting;
import com.bnebit.sms.vo.ConsultingImg;

@Controller
@Component
public class ConsultingController {

	@Autowired
	private ConsultingService consultingService;

	/*
	 * //상담일지 목록조회
	 *
	 * @RequestMapping(value="/consulting/selectConsultingList") public
	 * ModelAndView selectConsultingList(HttpServletRequest request) throws
	 * SQLException { ModelAndView mav =
	 * consultingService.selectConsultingList(request); return mav; }
	 */

	// 상담일지 조회
	@RequestMapping(value = "/consulting/selectConsultingView")
	public ModelAndView selectConsultingView(@RequestParam("consulting") Consulting consulting) throws SQLException {
		ModelAndView mav = consultingService.selectConsultingView(consulting);
		return mav;
	}

	// 상담일지 작성, 파일추가
	@RequestMapping(value = "/consulting/insertConsulting")
	public void insertConsulting(@RequestParam("consulting") Consulting consulting,
			@RequestParam("consultingImg") MultipartFile consultingImg) throws SQLException {
		consultingService.insertConsulting(consulting);
		ConsultingImg img = new ConsultingImg();
		consultingService.insertConsultingImg(img);
	}

	/*
	 * //상담일지 파일추가
	 *
	 * @RequestMapping(value="/consulting/insertConsultingImg") public void
	 * insertConsultingImg(ConsultingImg consultingImg) throws SQLException {
	 * consultingService.insertConsultingImg(consultingImg); }
	 */

	// 상담일지 수정, 파일수정
	@RequestMapping(value = "/consulting/updateConsulting")
	public void updateConsulting(@RequestParam("consulting") Consulting consulting,
			@RequestParam("consultingImg") ConsultingImg consultingImg) throws SQLException {
		consultingService.updateConsulting(consulting);
		consultingService.updateConsultingImg(consultingImg);
	}

	/*
	 * //상담일지 파일수정
	 *
	 * @RequestMapping(value="/consulting/updateConsultingImg") public void
	 * updateConsultingImg(ConsultingImg consultingImg) throws SQLException {
	 * consultingService.updateConsultingImg(consultingImg); }
	 */

	// 상담일지 삭제
	@RequestMapping(value = "/consulting/deleteConsulting")
	public void deleteConsultingWorker(@RequestParam("consulting") Consulting consulting) throws SQLException {
		consultingService.deleteConsultingWorker(consulting);
	}

	// 상담일지 파일삭제
	@RequestMapping(value = "/consulting/deleteConsultingImg")
	public void deleteConsultingImg(@RequestParam("consulting") ConsultingImg consultingImg) throws SQLException {
		consultingService.deleteConsultingImg(consultingImg);
	}
}
