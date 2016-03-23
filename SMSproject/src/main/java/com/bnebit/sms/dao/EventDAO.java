package com.bnebit.sms.dao;

import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.Event;

@Repository
public class EventDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	public Event selectEvent(String eventDate) throws Exception{
		return (Event)sqlMapClientTemplate.queryForObject("event.selectEvent", eventDate);
	}

	public ArrayList<Event> selectEventList() throws Exception{
		return (ArrayList<Event>)sqlMapClientTemplate.queryForList("event.selectEventList");
	}

	// DailyReport : 오늘의 이벤트 조회
	public Event selectTodayEvent() throws SQLException {
		Event event = (Event) sqlMapClientTemplate.queryForObject("event.selectTodayEvent");
		return event;
	}
}
