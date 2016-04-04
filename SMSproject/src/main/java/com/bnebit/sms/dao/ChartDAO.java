package com.bnebit.sms.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.vo.Chart;

@Repository
public class ChartDAO {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;

	// 매출 달성율 차트
	@SuppressWarnings("unchecked")
	public ArrayList<Chart> profitRateChart(Map<String, Object> paramMap) throws SQLException {
		ArrayList<Chart> percentList = (ArrayList<Chart>) sqlMapClientTemplate.queryForList("chart.profitRateChart",
				paramMap);
		return percentList;
	}

	// 매출 목표 차트
	@SuppressWarnings("unchecked")
	public ArrayList<Chart> salesGoalChart(Map<String, Object> paramMap) throws SQLException {
		ArrayList<Chart> percentList = (ArrayList<Chart>) sqlMapClientTemplate.queryForList("chart.salesGoalChart",
				paramMap);
		return percentList;
	}

	// 주행거리 차트
	@SuppressWarnings("unchecked")
	public ArrayList<Chart> distanceChart(Map<String, Object> paramMap) throws SQLException {
		ArrayList<Chart> distanceList = (ArrayList<Chart>) sqlMapClientTemplate.queryForList("chart.distanceChart",
				paramMap);
		return distanceList;
	}

	// 매출액 차트
	@SuppressWarnings("unchecked")
	public ArrayList<Chart> profitChart(Map<String, Object> paramMap) throws SQLException {
		ArrayList<Chart> profitList = (ArrayList<Chart>) sqlMapClientTemplate.queryForList("chart.profitChart", paramMap);
		return profitList;
	}
}
