package com.bnebit.sms.dao;


import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.Employee;


@Repository
public class EmployeeDAO {

	@Autowired
	SqlMapClientTemplate sqlMapClientTemplate;

	public Employee selectOneById(String emp_id){
		Employee employee = (Employee)
				sqlMapClientTemplate.queryForObject("employee.selectOneById", emp_id);
		return employee;
	}

	public Employee selectOneByEmailPw(Employee vo){
		Employee employee = (Employee)
				sqlMapClientTemplate.queryForObject("employee.selectOneByEmailPw", vo);
		return employee;
	}

	public Employee selectEmployeeByEmailName(Employee vo) {
		Employee employee = (Employee)
				sqlMapClientTemplate.queryForObject("employee.selectEmployeeByEmailName",vo);
		return employee;
	}

	public void updatePassword(Employee vo) {
		sqlMapClientTemplate.update("employee.updatePassword",vo);
	}

	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★  Admin 용 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */
	@SuppressWarnings("unchecked")
	public ArrayList<Employee> selectEmpList(PageOption<Employee> pageOption) throws SQLException {
		List<Employee> employeeList = sqlMapClientTemplate.queryForList("employee.selectEmpList", pageOption);
		return (ArrayList<Employee>)employeeList;
	}

	public int selectEmpListCount(PageOption<Employee> pageOption) throws SQLException{
		int records =  (Integer) sqlMapClientTemplate.queryForObject("employee.selectEmpListCount", pageOption);
		return records;
	}

	public void updateEmpListState(String[] ids) throws SQLException{
		sqlMapClientTemplate.update("employee.updateEmpListState", ids);
	}

	public Employee selectEmp(String id) throws SQLException{
		Employee employee = (Employee) sqlMapClientTemplate.queryForObject("employee.selectEmp", id);
		return employee;
	}

	public void updateEmpState(String id) throws SQLException{
		sqlMapClientTemplate.update("employee.updateEmpState", id);
	}

	public void updateEmp(Employee employee) throws SQLException{
		sqlMapClientTemplate.update("employee.updateEmp", employee);
	}

	public void insertEmp(Employee employee) throws SQLException{
		sqlMapClientTemplate.insert("employee.insertEmp", employee);
	}
	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */

}
