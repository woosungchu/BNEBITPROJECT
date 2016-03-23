<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>사용자 수정</title>
		<link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/form-normalize.css" />
        <link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/form-style.css" />
        <link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/form-input-file.css" />
        <script src="${contextPath}/assets/js/form-input-file.js" type="text/javascript"></script>
        <script src="${contextPath}/assets/js/employee-validation.js" type="text/javascript"></script>
	</head>
	<body>
		<h2 align="center" style="color: gray;">사용자 수정</h2>
		<hr width="700"><br>
        <div class="container" style="width: 600px; border-radius : 15px;">
		    <section class="register" style="border-radius : 15px;">
		      <h1>사용자 수정</h1>
		      <form id="employeeUpdateForm" action="/admin/employee/updateEmployee" method="post" enctype="multipart/form-data">
			      <div class="reg_section personal_info">
				      <h3>Personal Information</h3>
				      <span>E-mail : </span><input type="text" name="email" placeholder="E-mail" required="required" disabled="disabled" value="${EMPLOYEE.email}" >
				      <div id="duplicateResult">${EMAIL_ERROR}</div>
				      <span>&nbsp;&nbsp;&nbsp;성명 : </span><input type="text" name="empName" placeholder="사용자 성명" value="${EMPLOYEE.empName}"><br/>
				      <span>연락처 : </span><input type="text" name="phone" placeholder="연락처" value="${EMPLOYEE.phone}">
			      </div>
			      <div class="filebox bs3-primary preview-image">
				      <div class="upload-display">
				      	<div class="upload-thumb-wrap">
				      		<c:choose>
								<c:when test="${requestScope.EMPLOYEE.imgName  != 'NONAME'}">
									<img src="/Upload/${requestScope.EMPLOYEE.imgName}" class="upload-thumb">
								</c:when>
								<c:otherwise>
									<img src="<c:url  value='${contextPath}/assets/image/noname.png'/>" class="upload-thumb">
								</c:otherwise>
							</c:choose>
				      	</div>
				      </div>
			          <input class="upload-name" value="${EMPLOYEE.imgName}" disabled="disabled" style="width: 200px;">
			          <label for="input_file">사진 변경</label>
			          <button id="noImgBtn" type="button">X</button>
			          <input type="file" id="input_file" name="file" class="upload-hidden">
			      </div>
			      <div class="reg_section password">
				      <h3>Password</h3>
				      <span>비밀번호 : </span><input type="password" id="realPassword" name="password" placeholder="비밀번호를 입력하세요" required="required" value="${EMPLOYEE.password}" style="margin-right: 30px;"><br/>
				      <span>확인 : </span><input type="password" id="configPassword" placeholder="비밀번호를 한번 더 입력하세요(확인)" required="required">
				      <div id="agreementPassword">${PASSWORD_ERROR}</div>
			      </div>
			      <div class="reg_section dept_and_position">
				      <h3>Department & Position</h3>
				      <span>부서 : </span>
				      <select id="dept" name="dept.deptId" required="required">
	              		 <c:forEach items="${requestScope.DEPT_LIST}" var="department">
	              		 	 <c:choose>
								<c:when test="${department.deptId == EMPLOYEE.dept.deptId}">
									<option value="${department.deptId}" selected="selected">${department.deptName}</option>
								</c:when>
								<c:otherwise>
									<option value="${department.deptId}">${department.deptName}</option>
								</c:otherwise>
							</c:choose>
              			 </c:forEach>
              		  </select>
              		  <div>${DEPT_ERROR}</div>
              		  <span>직급 : </span>
              		  <select name="position">
              		  		<option selected="selected" style="display: none;">
								${EMPLOYEE.position}
							</option>
			               	<option value="Manager">Manager</option>
			               	<option value="Salesman">Salesman</option>
		              </select>
			      </div>
			      <div class="reg_section user_state">
				      <h3>User State</h3><br/>
				      <div style="padding-right: 80px;">
					      <span>상태 : </span>
				      	  <c:choose>
					      	  <c:when test="${EMPLOYEE.state == 'ACTIVE'}">
							      <input type="radio" name="state" value="ACTIVE" checked="checked"> ACTIVE
					      	  </c:when>
					      	  <c:otherwise>
							      <input type="radio" name="state" value="ACTIVE"> ACTIVE
					      	  </c:otherwise>
				      	  </c:choose>

						  <c:choose>
					      	  <c:when test="${EMPLOYEE.state == 'INACTIVE'}">
							      <input type="radio" name="state" value="INACTIVE" checked="checked"> INACTIVE
					      	  </c:when>
					      	  <c:otherwise>
							      <input type="radio" name="state" value="INACTIVE"> INACTIVE
					      	  </c:otherwise>
						  </c:choose>
				      </div>
			      </div>
			      <p class="submit">
			      	 <button type="submit">수정</button>
			      	 <a href="/admin/employee/viewEmployee?empId=${EMPLOYEE.empId}"><button id="cancle" type="button">취소</button></a>
			      </p>
			      <input type="hidden" name="email" value="${EMPLOYEE.email}" >
			      <input type="hidden" name="empId" value="${EMPLOYEE.empId}" >
			      <input type="hidden" name="imgName" value="${EMPLOYEE.imgName}" >
			      <input id="inputNoImage" type="hidden" name="inputNoImage">
		      </form>
		    </section>
	    </div>
	</body>
</html>