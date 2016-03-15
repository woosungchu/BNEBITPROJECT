package com.bnebit.sms.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.Validation;

@Repository
public class ValidationDAO {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;
	
//	public void insert(Validation validation){
//		sqlMapClientTemplate.insert("validation.insert", validation);
//	}
	public void insert(Validation validation, double TIME_LIMIT){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("TIME_LIMIT", TIME_LIMIT);
		map.put("validation", validation);
		System.out.println(TIME_LIMIT);
		sqlMapClientTemplate.insert("validation.insert", map);
	}
	
	public Validation selectOne(Validation vo){
		Validation validation = (Validation) 
				sqlMapClientTemplate.queryForObject("validation.selectOne",vo);
		return validation;
	}
}
