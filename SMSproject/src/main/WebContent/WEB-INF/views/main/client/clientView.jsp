<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="page" uri="/WEB-INF/tlds/PageingTag.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="pageSet" value="${pageInfo.pageSet}" />
<div class="row">
	<h1 class="text-center">거래처 상세</h1>
	<c:choose>
			<c:when test="${client == null}">
				거래처가 존재하지 않습니다.
			</c:when>
			<c:otherwise>
				<div class="row">
					<div class="form-horizontal">
							<div class="form-group">
								<label for="clientCode" class="col-xs-3 col-xs-offset-1 control-label">고객코드</label>
								<div class="col-xs-6">
									<input type="text" class="form-control" id="clientCode" name="clientCode" value="${client.clientCode}" readonly/>
								</div>
							</div>
							<div class="form-group">
								<label for="clientName" class="col-xs-3 col-xs-offset-1 control-label">고객명</label>
								<div class="col-xs-6">
									<input type="text" class="form-control" id="clientName" name="clientName" value="${client.clientName}" readonly/>
								</div>
							</div>
							<div class="form-group">
								<label for="ceo" class="col-xs-3 col-xs-offset-1 control-label">대표자</label>
								<div class="col-xs-6">
									<input type="text" class="form-control" id="ceo" name="ceo" value="${client.ceo}" readonly/>
								</div>
							</div>
							<div class="form-group">
								<label for="secondName" class="col-xs-3 col-xs-offset-1 control-label">2차거래선</label>
								<div class="col-xs-6">
									<input type="text" class="form-control" id="secondName" name="secondName" value="${client.secondName}" readonly/>
								</div>
							</div>
							<div class="form-group">
								<label for="phone1" class="col-xs-3 col-xs-offset-1 control-label">연락처</label>
								<div class="col-xs-2">
									<input type="text" class="form-control input-sm" id="phone1" name="phone1" value="${client.phone1}"/>
								</div>
								<div class="col-xs-2">
									<input type="text" class="form-control input-sm" id="phone2" name="phone2" value="${client.phone2}"/>
								</div>
								<div class="col-xs-2">
									<input type="text" class="form-control input-sm" id="phone3" name="phone3" value="${client.phone3}"/>
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-3 col-xs-offset-2"></div>
								<div class="col-xs-5">
									<input type="text" class="form-control" id="address" name="address" value="${client.address}" readonly/>
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-5 col-xs-offset-1"></div>
								<div class="col-xs-2">
									<input id="addFormBtn" type="button" class="btn btn-default form-control btn-xs" value="등록" />
								</div>
								<div class="col-xs-2">
									<input id="updateFormBtn" type="button" class="btn btn-default form-control btn-xs" data-id="${client.clientId }" value="수정" />
								</div>
							</div>
					</div>
				</div>
				<div class="row">
						<div id="mapDiv" class="col-xs-12">
						</div>
				</div>
			</c:otherwise>
	</c:choose>
</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//apis.daum.net/maps/maps3.js?apikey=fb345b9773526502503fab49b6aa7fd9&libraries=services"></script>
<script type="text/javascript" src="${contextPath }/assets/js/utils.js"></script>
<script type="text/javascript" src="${contextPath }/assets/js/client.js"></script>
<script type="text/javascript">
$(function() {
	ClientModule.initView();
});
</script>
