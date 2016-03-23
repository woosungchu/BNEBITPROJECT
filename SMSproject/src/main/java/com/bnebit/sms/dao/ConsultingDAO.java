package com.bnebit.sms.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.Consulting;
import com.bnebit.sms.vo.ConsultingImg;

@Repository
public class ConsultingDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
	public ArrayList<Consulting> selectContract(String empId){
		Map<String,String> map = new HashMap<String, String>();
		map.put("empId", empId);
		map.put("rownum", "4");
		ArrayList<Consulting> list =  
				(ArrayList<Consulting>) sqlMapClientTemplate.queryForList("consulting.selectContract", map);
		return list;
	}

	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★  Admin 용 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectConsultingList(PageOption<Map<String, Object>> pageOption) throws SQLException {
		List<Map<String,Object>> list = (List<Map<String,Object>>) sqlMapClientTemplate.queryForList("consulting.selectConsultingList",pageOption);
		return list;
	}

	public int selectConsultingListCount(PageOption<Map<String, Object>> pageOption) throws SQLException {
		int records =  (Integer) sqlMapClientTemplate.queryForObject("consulting.selectConsultingListCount", pageOption);
		return records;
	}

	public void deleteConsultingList(String[] ids) throws SQLException{
		sqlMapClientTemplate.delete("consulting.deleteConsultingList", ids);
	}

	public void deleteConsulting(String id) throws SQLException{
		sqlMapClientTemplate.delete("consulting.deleteConsulting", id);
	}
	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */

	// 상담일지 목록조회
	@SuppressWarnings("unchecked")
	public ArrayList<Consulting> selectConsultingListWorker(Map<String, Object> paramMap) throws SQLException {
		ArrayList<Consulting> consultingList = (ArrayList<Consulting>) sqlMapClientTemplate
				.queryForList("consulting.selectConsultingListWorker", paramMap);
		return consultingList;
	}

	// 상담일지 조회
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectConsultingView(Consulting consulting) throws SQLException {
		Map<String, Object> consultingMap = (Map<String, Object>) sqlMapClientTemplate
				.queryForObject("consulting.selectConsultingView", consulting);
		return consultingMap;
	}

	// 상담일지 작성
	public void insertConsulting(Consulting consulting) throws SQLException {
		sqlMapClientTemplate.insert("consulting.insertConsulting", consulting);
	}

	// 상담일지 파일추가
	public void insertConsultingImg(ConsultingImg consultingImg) throws SQLException {
		sqlMapClientTemplate.insert("consulting.insertConsultingImg", consultingImg);
	}

	// 상담일지 수정
	public void updateConsulting(Consulting consulting) throws SQLException {
		sqlMapClientTemplate.update("consulting.updateConsulting", consulting);
	}

	// 상담일지 파일수정
	public void updateConsultingImg(ConsultingImg consultingImg) throws SQLException {
		sqlMapClientTemplate.update("consulting.updateConsultingImg", consultingImg);
	}

	// 상담일지 삭제
	public void deleteConsultingWorker(Consulting consulting) throws SQLException {
		sqlMapClientTemplate.delete("consulting.deleteConsultingWorker", consulting);
	}

	// 상담일지 파일삭제
	public void deleteConsultingImg(ConsultingImg consultingImg) throws SQLException {
		sqlMapClientTemplate.delete("consulting.deleteConsultingImg", consultingImg);
	}
}
