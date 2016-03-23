<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="page" uri="/WEB-INF/tlds/PageingTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<div class="row">
	<h1 class="text-center">거래처 등록</h1>
	<div class="row">
			<form id="clientForm" class="form-horizontal" method="post">
			<%-- <input type="hidden" id="sortName" name="sortName" value="${pageSet.sortName}"/>
			<input type="hidden" id="sortBy" name="sortBy" value="${pageSet.sortBy}"/> --%>
					<div class="form-group">
						<label for="clientCode" class="col-xs-3 col-xs-offset-1 control-label">고객코드</label>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="clientCode" name="clientCode"/>
						</div>
					</div>
					<div class="form-group">
						<label for="clientName" class="col-xs-3 col-xs-offset-1 control-label">고객명</label>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="clientName" name="clientName"/>
						</div>
					</div>
					<div class="form-group">
						<label for="ceo" class="col-xs-3 col-xs-offset-1 control-label">대표자</label>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="ceo" name="ceo"/>
						</div>
					</div>
					<div class="form-group">
						<label for="secondName" class="col-xs-3 col-xs-offset-1 control-label">2차거래선</label>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="secondName" name="secondName"/>
						</div>
					</div>
					<div class="form-group">
						<label for="phone1" class="col-xs-3 col-xs-offset-1 control-label">연락처</label>
						<div class="col-xs-2">
							<input type="text" class="form-control input-sm" id="phone1" name="phone1" />
						</div>
						<div class="col-xs-2">
							<input type="text" class="form-control input-sm" id="phone2" name="phone2"/>
						</div>
						<div class="col-xs-2">
							<input type="text" class="form-control input-sm" id="phone3" name="phone3" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-3 col-xs-offset-2">
							<input type="button" id="searchAddrBtn" class="btn btn-default form-control btn-xs" value="주소 검색" />
						</div>
						<div class="col-xs-5">
							<input type="text" class="form-control" id="address" name="address"/>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-2 col-xs-offset-8">
							<input type="submit" class="btn btn-default form-control btn-xs" value="등록" />
						</div>
					</div>
			</form>
		</div>
		<div class="row">
				<div id="mapDiv" class="col-xs-12">
				</div>
				<!-- <div id="mapDiv" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div> -->
		</div>
	</div>
<div id="searchAddrDiv" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" alt="닫기 버튼">
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//apis.daum.net/maps/maps3.js?apikey=fb345b9773526502503fab49b6aa7fd9&libraries=services"></script>
<script type="text/javascript" src="${contextPath }/assets/js/utils.js"></script>
<script type="text/javascript" src="${contextPath }/assets/js/client.js"></script>
<script type="text/javascript">
  $(function() {
    ClientModule.initInsert();
    /*   if( /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent) ) {
     $('#searchKey').selectpicker('mobile');
     } */
  });
</script>