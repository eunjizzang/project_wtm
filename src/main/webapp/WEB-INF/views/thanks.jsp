<%
/**
* @filename    : thanks.jsp
* @description : --- 탈퇴 완료 페이지 ---

				2초후 로그아웃된 메인 페이지로 이동한다

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="./_inc/header.jsp"%>
<!-- 2초후 메인페이지로 자동으로 이동 -->
<meta http-equiv="refresh" content="2;url=<%=request.getContextPath()%>/">

<!-- 탈퇴 페이지에 적용될 CSS 속성 -->
<style>
/* 컨텐츠 크기 */
.bye-page {	margin: auto; min-height: 600px; }

/* 이미지 크기 */
.bye-page > img { width: 500px; margin-top: 70px; }

/* 텍스트 컬러 */
.bye-page > .thanks-text { color: #2E9AFE; }
</style>
<!--// 탈퇴 페이지에 적용될 CSS 속성 -->

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="bye-page container text-center">
	<img src="<%=request.getContextPath()%>/assets/img/thanks.png">
	<h3>탈퇴가 완료되었습니다</h3>
	<strong class="thanks-text">이거모약 사이트를 이용해 주셔서 감사합니다. <br />
	보다 더 나은 서비스로 찾아뵙겠습니다.</strong>
	<br /><br />
	<p><small>잠시후 메인페이지로 이동합니다</small> <i class="fas fa-spinner fa-spin" style="color: black;"></i></p>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="./_inc/footer.jsp"%>
