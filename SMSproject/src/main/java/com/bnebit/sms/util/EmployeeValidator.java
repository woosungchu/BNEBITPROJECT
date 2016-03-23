package com.bnebit.sms.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.bnebit.sms.dao.EmployeeDAO;
import com.bnebit.sms.vo.Employee;

public class EmployeeValidator implements Validator{

	private EmployeeDAO employeeDAO;

	public EmployeeValidator(){}

	public EmployeeValidator(EmployeeDAO employeeDAO){
		this.employeeDAO = employeeDAO;
	}

	@Override
	public boolean supports(Class<?> clazz) {
		return Employee.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		try{
			Employee employee = (Employee)target;

			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "required", " Server Error : 이메일을 반드시 입력해 주세요!"); // email 값이 존재 하는가?
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "required", " Server Error : 비밀번호를 반드시 입력해 주세요!"); // password 값이 존재 하는가?
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "dept.deptId", "required", " Server Error : 부서를 반드시 선택해 주세요!"); // deptName 값이 존재 하는가?

			if(!isEmail(employee.getEmail())){
				errors.rejectValue("email", "noEmailType", " Server Error : 이메일 형식을 맞추어 주세요!");
			}

			if(employeeDAO != null)
			{
				if(!duplicateEmail(employee.getEmail())) {
					errors.rejectValue("email", "duplicateEmail", " Server Error : 이미 사용하고 있는 이메일 입니다!");
				}
			}
		}catch(Exception e){e.printStackTrace();}
	}

	public boolean isEmail(String email) {
        return Pattern.matches("[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+",email.trim());
    }

	public boolean duplicateEmail(String email) throws SQLException {
		ArrayList<String> emailList = employeeDAO.selectEmpEmailList();
		for(int i=0; i<emailList.size(); i++) {
			if(email.equals(emailList.get(i))) {
				return false;
			}
		}
		return true;
	}
}
