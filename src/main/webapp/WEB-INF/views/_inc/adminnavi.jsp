<%
	/**
* @ Project : 이거모약?
* @ FileName : adminnavi.jsp
* @ Author : 이 민 희(lmnhofficial@gmail.com)
	*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<!-- 기본형 네비게이션 안보이게 처리 -->
<style type="text/css">
.header-navi {
	display: none;
}
</style>

<!-- 관리자용 네비게이션 -->
<nav class="admin-navbar navbar-inverse">
	<div class="container">
		<a class="navbar-brand" href="<%=request.getContextPath()%>">이거모약?</a>
		<ul class="nav navbar-nav">
			<li class="active"><a href="<%=request.getContextPath()%>/admin_main.do">관리자</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_members.do">회원관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin_goods.do">상품관리</a></li>
		</ul>
	</div>
</nav>