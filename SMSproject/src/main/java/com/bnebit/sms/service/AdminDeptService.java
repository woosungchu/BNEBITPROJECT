package com.bnebit.sms.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.DeptDAO;
import com.bnebit.sms.util.Cryptable;
import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.Dept;
import com.google.gson.Gson;

@Service
public class AdminDeptService implements Cryptable{

	@Autowired
	private DeptDAO deptDAO;
	@Autowired
	private ModelAndView mav;


	// ********************************************** Employee ********************************************************** //
	public ModelAndView configHistoryPageDeptList(HttpSession session)
	{
		mav.setViewName("admin/adminDeptList");
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			Gson gson = new Gson();
			String historyPage = gson.toJson(session.getAttribute("HISTORY_PAGE"));
			mav.addObject("historyPage", historyPage);
		}
		return mav;
	}

	@SuppressWarnings("unchecked")
	public PageOption<Dept> getPageOptionDeptList(PageOption<Dept> pageOption, String search, HttpSession session) throws SQLException
	{
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			pageOption = null;
			pageOption = (PageOption<Dept>) session.getAttribute("HISTORY_PAGE");
			session.setAttribute("HISTORY_FLAG", "0");
			return pageOption;
		}
		pageOption.setSearch(search);
		if(!pageOption.getSidx().equals(""))
		{
			pageOption.setFullSidx(pageOption.getSidx()+" "+pageOption.getSord());
		}
		pageOption.setEnd(pageOption.getPage()*pageOption.getRows());
		pageOption.setStart(pageOption.getEnd()-pageOption.getRows()+1);

		pageOption.setRecords(deptDAO.selectDeptListCount(pageOption));
		int total;
		if ( pageOption.getRecords()%pageOption.getRows() == 0 )
			total = pageOption.getRecords()/pageOption.getRows();
		else
			total = pageOption.getRecords()/pageOption.getRows() + 1;
		pageOption.setTotal(total);

		List<Dept> dataList = deptDAO.selectDeptList(pageOption);
		pageOption.setDataList(dataList);

		session.setAttribute("HISTORY_PAGE", pageOption);

		return pageOption;
	}

	public void removeDeptList(String[] ids) throws SQLException
	{
		deptDAO.deleteDeptList(ids);
	}

	public void addDept(Dept dept, HttpSession session) throws SQLException
	{
		deptDAO.insertDept(dept);
	}

	/*public ModelAndView removeEmployee(String id, HttpSession session) throws SQLException
	{
		session.setAttribute("HISTORY_FLAG", "0");
		employeeDAO.updateEmpState(id);
		mav.setViewName("redirect:/admin/employee/employeeList");
		return mav;
	}


	public ModelAndView updateEmployee(Employee employee, BindingResult bindingResult, MultipartFile file, String inputNoImage, HttpSession session) throws SQLException, IllegalStateException, IOException
	{
		new EmployeeValidator().validate(employee, bindingResult);
		if(bindingResult.hasErrors()){
			FieldError emailFieldError = bindingResult.getFieldError("email");
			FieldError passwordFieldError = bindingResult.getFieldError("password");
			FieldError deptFieldError = bindingResult.getFieldError("dept.deptId");

			if(emailFieldError!=null && "required".equals(emailFieldError.getCode())){
				mav.addObject("EMAIL_ERROR",emailFieldError.getDefaultMessage());
			}
			if(emailFieldError!=null && "noEmailType".equals(emailFieldError.getCode())){
				mav.addObject("EMAIL_ERROR",emailFieldError.getDefaultMessage());
			}
			if(passwordFieldError!=null && "required".equals(passwordFieldError.getCode())){
				mav.addObject("PASSWORD_ERROR",passwordFieldError.getDefaultMessage());
			}
			if(deptFieldError!=null && "required".equals(deptFieldError.getCode())){
				mav.addObject("DEPT_ERROR",deptFieldError.getDefaultMessage());
			}

			List<Dept> deptList = deptDAO.selectDeptListBox();
			mav.addObject("DEPT_LIST", deptList);
			mav.addObject("EMPLOYEE",employee);
			mav.setViewName("admin/adminEmployeeUpdate");
		}
		else	// 서버 검증을 통과 하였을 때.
		{
			String password = employee.getPassword();
			employee.setPassword(cryptUtil.hashing(password));		// password 암호화
			if(file!=null && !file.isEmpty())
			{
				String fileName = "(" + employee.getEmail() + ")" + "profileImage.png";
				UploadUtil.uploadHelper(file, fileName);
				employee.setImgName(fileName);
			}
			if("NONAME".equals(inputNoImage))
			{
				UploadUtil.deletePreFile(employee.getImgName());
				employee.setImgName(inputNoImage);
			}
			employeeDAO.updateEmp(employee);
			updateDataListOnHistory(session);
			mav.setViewName("redirect:/admin/employee/viewEmployee?empId="+employee.getEmpId());
		}
		return mav;
	}*/

	// ****************************************************************************************************************** //

}
