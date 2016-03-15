package com.bnebit.sms.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.bnebit.sms.dao.EmployeeDAO;
import com.bnebit.sms.util.PageOption;
import com.bnebit.sms.vo.Employee;
import com.google.gson.Gson;

@Service
public class AdminEmployeeService {

	@Autowired
	private EmployeeDAO employeeDAO;
	@Autowired
	private ModelAndView mav;


	// ********************************************** Employee ********************************************************** //
	public ModelAndView configHistoryPageEmployeeList(HttpSession session)
	{
		mav.setViewName("admin/adminEmployeeList");
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
	public PageOption<Employee> getPageOptionEmployeeList(PageOption<Employee> pageOption, String search, HttpSession session) throws SQLException
	{
		String historyFlag = (String) session.getAttribute("HISTORY_FLAG");
		if(historyFlag!=null && historyFlag.equals("1"))
		{
			pageOption = null;
			pageOption = (PageOption<Employee>) session.getAttribute("HISTORY_PAGE");
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

		pageOption.setRecords(employeeDAO.selectEmpListCount(pageOption));
		int total;
		if ( pageOption.getRecords()%pageOption.getRows() == 0 )
			total = pageOption.getRecords()/pageOption.getRows();
		else
			total = pageOption.getRecords()/pageOption.getRows() + 1;
		pageOption.setTotal(total);

		List<Employee> dataList = employeeDAO.selectEmpList(pageOption);
		pageOption.setDataList(dataList);

		session.setAttribute("HISTORY_PAGE", pageOption);

		return pageOption;
	}

	public void removeEmployeeList(String[] ids) throws SQLException
	{
		employeeDAO.updateEmpListState(ids);
	}

	public ModelAndView removeEmployee(String id, HttpSession session) throws SQLException
	{
		session.setAttribute("HISTORY_FLAG", "0");
		employeeDAO.updateEmpState(id);
		mav.setViewName("redirect:/admin/employee/employeeList");
		return mav;
	}

	public ModelAndView getEmployee(String id, HttpSession session) throws SQLException
	{
		session.setAttribute("HISTORY_FLAG", "1");
		Employee employee =  employeeDAO.selectEmp(id);
		mav.addObject("EMPLOYEE", employee);
		mav.setViewName("admin/adminEmployeeView");
		return mav;
	}
	// ****************************************************************************************************************** //

}
