package com.bnebit.sms.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ChartDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	// 매출 달성율 차트
	@SuppressWarnings("unchecked")
	public ArrayList<Double> profitRateChart(Map<String, Object> paramMap) throws SQLException {
		ArrayList<Double> percentList = (ArrayList<Double>) sqlMapClientTemplate.queryForList("chart.profitRateChart",
				paramMap);
		return percentList;
	}

	// 주행거리 차트
	@SuppressWarnings("unchecked")
	public ArrayList<Double> distanceChart(Map<String, Object> paramMap) throws SQLException {
		ArrayList<Double> distanceList = (ArrayList<Double>) sqlMapClientTemplate.queryForList("chart.distanceChart",
				paramMap);
		return distanceList;
	}

	// 매출액 차트
	@SuppressWarnings("unchecked")
	public ArrayList<Double> profitChart(Map<String, Object> paramMap) throws SQLException {
		ArrayList<Double> profitList = (ArrayList<Double>) sqlMapClientTemplate.queryForList("chart.profitChart", paramMap);
		return profitList;
	}
}
