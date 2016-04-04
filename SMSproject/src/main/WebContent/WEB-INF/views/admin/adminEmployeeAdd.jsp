<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>

		<title>사용자 추가</title>
		<link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/form-normalize.css" />
        <link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/form-style.css" />
        <link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/form-input-file.css" />

		<h2 align="center" style="color: gray;">사용자 추가</h2>
		<hr width="700"><br>
        <div class="container" style="width: 600px; border-radius : 15px;">
		    <section class="register" style="border-radius : 15px;">
		      <h1>사용자 추가</h1>
		      <form id="employeeAddForm" action="/admin/employee/addEmployee" method="post" enctype="multipart/form-data">
			      <div class="reg_section personal_info">
				      <h3>Personal Information</h3>
				      <input type="text" id="email" name="email" placeholder="E-mail" required="required" value="${EMPLOYEE.email}" >
				      <div id="duplicateResult">${EMAIL_ERROR}</div>
				      <input type="text" name="empName" placeholder="사용자 성명" value="${EMPLOYEE.empName}">
				      <input type="text" name="phone" placeholder="연락처" value="${EMPLOYEE.phone}">
				      <div class="filebox bs3-primary preview-image">
				          <input class="upload-name" value="프로필 이미지" disabled="disabled" style="width: 200px;">
				          <label for="input_file">업로드</label>
				          <input type="file" id="input_file" name="file" class="upload-hidden">
				      </div>
			      </div>
			      <div class="reg_section password">
				      <h3>Password</h3>
				      <input type="password" id="realPassword" name="password" placeholder="비밀번호를 입력하세요" required="required" value="${EMPLOYEE.password}">
				      <input type="password" id="configPassword" placeholder="비밀번호를 한번 더 입력하세요(확인)" required="required">
				      <div id="agreementPassword">${PASSWORD_ERROR}</div>
			      </div>
			      <div class="reg_section dept_and_position">
				      <h3>Department & Position</h3>
				      <select id="dept" name="dept.deptId" required="required">
                   		 <option selected="selected" disabled="disabled" style=" display: none;" value="">부서</option>
	              		 <c:forEach items="${requestScope.DEPT_LIST}" var="department">
	              			 <option value="${department.deptId}">${department.deptName}</option>
              			 </c:forEach>
              		  </select>
              		  <div>${DEPT_ERROR}</div>
              		  <select name="position">
	                   		<option selected="selected" disabled="disabled" style=" display: none;">직급</option>
			               	<option value="Manager">Manager</option>
			               	<option value="Salesman">Salesman</option>
		               </select>
			      </div>
			      <p class="submit">
			      	 <button type="submit">등록</button>
			      	 <a href="/admin/employee/employeeList" class="aBtn">취소</a>
			      </p>
		      </form>
		    </section>
	    </div>

	    <script src="${contextPath}/assets/js/form-input-file.js" type="text/javascript"></script>
        <script src="${contextPath}/assets/js/employee-validation.js" type="text/javascript"></script>

