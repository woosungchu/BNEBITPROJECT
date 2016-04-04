<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<script type="text/javascript">
	$(document).ready(function(){
		$('.page').click(function(){			// 다른 목록 페이지 로 이동할 때 , 쿠키에 있던 체크 값 모두 해제
			var cookies = $.cookie();
			for(var cookie in cookies)
			{
				$.removeCookie(cookie);
			}
			$.ajax({
				url:'${contextPath}/admin/report/clearHistory',
				type:'post'
    		});
		});
	});
</script>
<ul id="bloggertrix_box_menu">
    <li><a href="#">보고</a>
        <ul>
              <li><a class="page" href="/admin/report/weeklyPlanList">주간계획 목록</a></li>
              <li><a class="page" href="/admin/report/dailyReportList">일일업무 보고 목록</a></li>
              <li><a class="page" href="/admin/report/consultingList">상담일지 목록</a></li>
        </ul>
    </li>

    <li><a href="#">사용자</a>
        <ul>
              <li><a class="page" href="/admin/employee/employeeList">사용자 목록</a></li>
        </ul>
    </li>

    <li><a href="#">부서</a>
        <ul>
              <li><a class="page" href="/admin/dept/deptList">부서 목록</a></li>
        </ul>
    </li>

    <li><a href="#">거래처</a>
        <ul>
              <li><a class="page" href="${contextPath }/admin/client/clientList">거래처 목록</a></li>
        </ul>
    </li>

    <li><a href="#">메시지</a>
        <ul>
            <li><a class="page" href="${contextPath }/admin/message/messageList">보낸 메시지함</a></li>
        </ul>
    </li>
</ul>
