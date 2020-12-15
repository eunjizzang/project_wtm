<%/**
 *@FileName : review.jsp
 *@프로그램 설명  : 병원 리뷰들을 볼 수 있다.
 *@작성자 : 정은지 (ejzzang56@gmail.com)
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>
<!-- ========== 컨텐츠 영역 시작 ========== -->
<link rel="stylesheet" href="assets/plugins/DataTables/datatables.min.css" />
<style type="text/css">
    .content1{width:450px;float:left;text-align:center;margin-top:30px;font-size: 25px;}
    .content2{width:450px;float:left;margin-top:20px;}
    .content3{width:900px;}
    .ratio li{float:left;position:relative;width:20px;height:100px;margin-right:10px;list-style:none;}
    .ratio div{position:absolute;left:0;bottom:0;width:100%;background-color:#2E9AFE; font-size:0;}
    .ratio em{top:-20px;width:100%;font-size:12px;font-weight:bold;text-align:center;}
    .box-radio-input input[type="radio"]{display:none;}
    nav {text-align: center;}
</style>

<div class="container">

<p>리뷰번호:${output.reviewId}</p>

<p>리뷰내용:${output.content}</p>

<a href="${pageContext.request.contextPath}/reserve/review.do">[목록보기]</a>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>