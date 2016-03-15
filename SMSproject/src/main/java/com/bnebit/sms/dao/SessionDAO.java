package com.bnebit.sms.dao;

import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.SessionKey;


@Repository
public class SessionDAO {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;

	public SessionKey selectOne(SessionKey vo){
		SessionKey sessionKeyVo = (SessionKey)
				sqlMapClientTemplate.queryForObject("sessionKey.selectOne", vo);
		return sessionKeyVo;
	}

	public void insert(SessionKey vo) {
		sqlMapClientTemplate.insert("sessionKey.insert", vo);
	}

	public void delete(String session_id){
		sqlMapClientTemplate.delete("sessionKey.delete",session_id);
	}

}
