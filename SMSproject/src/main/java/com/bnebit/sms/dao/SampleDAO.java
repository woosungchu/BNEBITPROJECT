package com.bnebit.sms.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SampleDAO {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	public void selectSample(){
//		sqlMapClientTemplate.queryForList("test.test");
	}

}
