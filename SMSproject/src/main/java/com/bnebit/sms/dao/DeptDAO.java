package com.bnebit.sms.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.Dept;


@Repository
public class DeptDAO {
	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;

	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★  Admin 용 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */
	@SuppressWarnings("unchecked")
	public List<Dept> selectDeptList(PageOption<Dept> pageOption) throws SQLException {
		List<Dept> list = (List<Dept>) sqlMapClientTemplate.queryForList("dept.selectDeptList",pageOption);
		return list;
	}

	public int selectDeptListCount(PageOption<Dept> pageOption) throws SQLException {
		int records =  (Integer) sqlMapClientTemplate.queryForObject("dept.selectDeptListCount", pageOption);
		return records;
	}

	public void deleteDeptList(String[] ids) throws SQLException {
		sqlMapClientTemplate.delete("dept.deleteDailyReportList",ids);
	}

	public void updateDept(Dept dept) throws SQLException {
		sqlMapClientTemplate.update("dept.updateDept", dept);
	}

	public void insertDept(Dept dept) throws SQLException {
		sqlMapClientTemplate.insert("dept.insertDept", dept);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<Dept> selectDeptListBox() throws SQLException {
		List<Dept> deptList = sqlMapClientTemplate.queryForList("dept.selectDeptListBox");
		return (ArrayList<Dept>)deptList;
	}
	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */
}