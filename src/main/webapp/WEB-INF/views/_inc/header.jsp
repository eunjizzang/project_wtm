<%
/**
* @filename    : header.jsp
* @description : --- include 파일 ---

				.header-top
				페이지 최상단 파란색 부분 / 장바구니, 로그인, 회원가입, (마이페이지, 관리자페이지, 로그아웃) 네비게이션
				
				.header-navi
				페이지 상단 배경 흰색 부분 / 각 페이지로 네비게이션 

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.net.URLDecoder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
 
<head>
    <meta charset="UTF-8" />
    <!-- 파비콘과 타이틀(사이트로고 및 이름) -->
    <link rel="shortcut icon" type="image/x-icon" href="<%=request.getContextPath()%>/assets/img/title-logo.svg">
    <title>이거모약 - 약 검색과 병원 예약</title>
    
    <!-- 공통 CSS -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/header-footer.css">	<!-- header-footer  -->
    <link rel="stylesheet" href="//stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">	<!-- 부트스트랩 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/non-responsive.css">	<!-- 반응형웹 차단 -->
    <link rel="stylesheet" href="//fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap">	<!-- 나눔고딕폰트 -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/plugins/sweetalert/sweetalert2.min.css" />	<!-- sweet alert -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/plugins/ajax/ajax_helper.css"/>	<!-- AjaxHelper -->
	<!-- 코로나현황 바로가기 버튼 floating button custom -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/covid_btn.css">
	
	<!-- 공통 script -->
    <script src="//kit.fontawesome.com/738f21dc78.js" crossorigin="anonymous"></script>	<!-- 무료 아이콘 -->
	<script src="//code.jquery.com/jquery-3.5.1.min.js"></script>	<!-- 제이쿼리 -->
	<script src="<%=request.getContextPath()%>/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>	<!-- sweet alert -->
	<script src="<%=request.getContextPath()%>/assets/plugins/ajax/ajax_helper.js"></script>	<!-- AjaxHelper -->
	<script src="<%=request.getContextPath()%>/assets/plugins/handlebars/handlebars-v4.0.11.js"></script>	<!-- Handlebars plugin -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>	<!-- 다음 주소 검색 api 사용 -->
	
</head>

<body>
    <!-- header -->
    <!-- top(상단 하늘색) -->
    <div class="header-top container-fluid">
        <div class="container">
            <div class="text-right">
            	<%-- interceptor에서 넘어온 값 출력 --%>
            	<c:choose>
            		<%-- 비로그인시 --%>
            		<c:when test="${memInfo == null}">
                		<a href="<%=request.getContextPath()%>/shop/cart.do">장바구니</a> | 
                		<a href="<%=request.getContextPath()%>/login">로그인</a> | 
                		<a href="<%=request.getContextPath()%>/login/join-agree.do">회원가입</a>
                	</c:when>
					<c:otherwise>
						<c:choose>      
		                	<%-- 회원 타입이 0인 경우(관리자) --%>
		                	<c:when test="${memInfo.type == 0}">
				                안녕하세요 관리자님! 
				                <a href="<%=request.getContextPath()%>/admin_main.do">관리자페이지</a> | 
				                <a href="<%=request.getContextPath()%>/login/logout.do">로그아웃</a>                                
				            </c:when>     	
		                	<%-- 회원 타입이 1, 2인 경우(일반) --%>
		                	<c:otherwise>
		                		안녕하세요 ${memInfo.userName}님! 
		                		<a href="<%=request.getContextPath()%>/shop/cart.do">장바구니</a> | 
		                		<a href="<%=request.getContextPath()%>/mypage">마이페이지</a> | 
		                		<a href="<%=request.getContextPath()%>/login/logout.do">로그아웃</a>                
		                	</c:otherwise>
			            </c:choose>
			        </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <!-- navi(상단 로고+사이트 네비) -->
    <div class="header-navi container-fluid">
        <div class="container text-center">
            <a href="<%=request.getContextPath()%>"><img src="<%=request.getContextPath()%>/assets/img/logo.png"></a>
            <ul>
                <li><a href="<%=request.getContextPath()%>/medicine">약검색</a></li>
                <li><a href="<%=request.getContextPath()%>/hospital">병원예약</a></li>
                <li><a href="<%=request.getContextPath()%>/drug">약국찾기</a></li>
                <li><a href="<%=request.getContextPath()%>/calendar">달력</a></li>
                <li><a href="<%=request.getContextPath()%>/shop">쇼핑</a></li>
            </ul>
        </div>
    </div>
    <!-- header 끝 -->