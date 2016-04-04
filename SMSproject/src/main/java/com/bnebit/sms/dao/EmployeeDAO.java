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
	
	public ArrayList<Employee> selectEmployeeByDept(String deptId) {
		 ArrayList<Employee> list = ( ArrayList<Employee>)
				sqlMapClientTemplate.queryForList("employee.selectEmployeeByDept", deptId);
		return list;
	}
	
	public ArrayList<Employee> selectSalesmanList(String deptId) {
		ArrayList<Employee> list = ( ArrayList<Employee>)
				sqlMapClientTemplate.queryForList("employee.selectSalesmanList", deptId);
		return list;
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

	@SuppressWarnings("unchecked")
	public ArrayList<String> selectEmpEmailList() throws SQLException{
		List<String> emailList = (List<String>) sqlMapClientTemplate.queryForList("employee.selectEmpEmailList");
		return (ArrayList<String>) emailList;
	}
	/* ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ */

	public Employee selectEmpById(String empId) {
		Employee employee = (Employee) sqlMapClientTemplate.queryForObject("employee.selectEmp", empId);
		return employee;
	}

	public ArrayList<Employee> searchEmployee(String deptId, String[] keywordList, int rownum, int page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("deptId", deptId);
		map.put("keywordList", keywordList);
		map.put("rownum", rownum); //늘어날 list 수
		map.put("page", page);//지금 마지막 list

		ArrayList<Employee> empList = (ArrayList<Employee>) 
				sqlMapClientTemplate.queryForList("employee.searchEmployee",map);
		return empList;
	}

}
