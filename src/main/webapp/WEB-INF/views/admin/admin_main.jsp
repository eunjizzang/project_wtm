<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../_inc/header.jsp"%>
<%@ include file="../_inc/adminnavi.jsp"%>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container col-lg-12">
	<!-- layer 01 -->
	<div id="layer01" class="col-lg-3" style="background-color:#fff;">
		<div class="page-header" style="text-align: center;">
			<h2>Dashboard</h2>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">오늘의 주문건 수</div>
			<div class="panel-body"></div>
		</div>
	</div>
	<!-- layer 02 -->
	<div id="layer02" class="col-lg-9" style="background-color:#fff;">
		<div class="abcabc">
		<ul class="nav nav-tabs">
			<li role="presentation" class="active" id="mychart1"><a href="#"
				data-toggle="tab">Home</a></li>
			<li role="presentation" id="mychart2"><a href="#">Profile</a></li>
			<li role="presentation" id="mychart3"><a href="#">Messages</a></li>
		</ul>

		<div class="tab-content"></div>
	</div>
	</div>
	</div>
	<%--	<!--  -->
	<div class="panel panel-info col-md-3">
		<div class="panel-heading">오늘의 주문건 수</div>
		<div class="panel-body"></div>
	</div>
	<div class="page-header">
		<h2>
			관리자 <small>Dashboard</small>
		</h2>
	</div>

	<!--  -->
	<div class="abcabc">
		<ul class="nav nav-tabs">
			<li role="presentation" class="active" id="mychart1"><a href="#"
				data-toggle="tab">Home</a></li>
			<li role="presentation" id="mychart2"><a href="#">Profile</a></li>
			<li role="presentation" id="mychart3"><a href="#">Messages</a></li>
		</ul>

		<div class="tab-content"></div>
	</div>
	--%>

<!--// ========== 컨텐츠 영역 끝 ========== -->

<%@ include file="../_inc/footer.jsp"%>


	<script type="text/javascript">
		var date = new Date();
		
		//new date() -> 현재 날짜 반환
		//변수.날짜 지정 => 변수.setDate(새로운 날짜);
		//date.getDate() + 7
		
		date.setDate(date.getDate() + 1);

		var setCookie = '';
		setCookie += 'CookieName = ABC,';
		setCookie += 'expires =' + date.toUTCString();	

		//console.log(setCookie);
		// ---- 설정한 값들을 쿠키에 저장하기 
		document.cookie = setCookie;
	</script>



<script>
	$(function() {
		$("#mychart1").click(function(e) {
			$.ajax({
				url : 'admin_chart_rank.jsp',
				dataType : 'html',
				success : function(req) {
					console.log(">성공!<" + req);
					$(".tab-content").html(req);
				}
			})
		})
	})
</script>