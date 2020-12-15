<%
/**
* @filename    : error.jsp
* @description : --- ERROR 페이지 ---

					405 에러의 경우, 문구를 보여주지 않고 바로 main으로 우회
					
* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="./_inc/header.jsp"%>

<!-- ERROR 페이지에 적용될 CSS 속성 -->
<style>
/* 컨텐츠 크기 */
.error-page { margin: auto; min-height: 600px; }

/* 이미지 크기 */
.error-page > img { width: 200px; margin: 100px 0 100px 0; }
</style>
<!--// ERROR 페이지에 적용될 CSS 속성 -->

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="error-page container text-center">
	<img src="<%=request.getContextPath()%>/assets/img/error.png">
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 400}">
		<h3>[400] 잘못 된 요청입니다!</h3>    
	</c:if>	
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
		<h3>[404] 요청하신 페이지를 찾을 수 없습니다.</h3>    
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 405}">
		<h3>[405] 잘못 된 접근입니다!</h3>    
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
		<h3>[500] 서버에 오류가 발생하여 요청을 수행할 수 없습니다.</h3>
	</c:if>
	
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 503}">
		<h3>[503] 서비스를 사용할 수 없습니다.</h3>
	</c:if>
	
	<a href="<%=request.getContextPath()%>">메인페이지로 이동</a>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="./_inc/footer.jsp"%>
