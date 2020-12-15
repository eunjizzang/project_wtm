
<%
	/**
* @filename    : index.jsp
* @description : --- 메인 페이지 ---

		기능 설명
		1) 광고 페이징
		2) 약검색 & 병원 검색엔진
		3) 보건의료 통계자료 그래프 (include)

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="./_inc/header.jsp"%>

<!-- 메인 페이지에 적용될 CSS 속성 -->
<style>
/** 광고영역, 그래프영역 조절 */
.index-contents1-ad, index-contents3-chart {
	width: 1100px;
	padding-top: 30px;
	padding-bottom: 30px;
}

/** 광고 이미지 스타일 */
#carousel-id .item {
	height: 600px;
	background-repeat: no-repeat;
	background-position: center center;
	background-size: cover;
}

/** 검색 엔진 제목 */
.index-contents2-search>h1 {
	margin-top: 100px;
}

/** 검색엔진 - 검색창 */
.index-contents2-search .form-control {
	width: auto;
	float: left;
	display: inline-block;
}

/** 검색 엔진 서치 영역 */
.index-contents2-search>.content-find {
	display: inline-block;
	margin: 10px 0 10px 0;
}

/** 구분선 */
.hr-tag-search-chart {
	border: solid 1px #eee;
	/** 검색엔진과 그래프 사이의 빈 공간 */
	margin-top: 100px;
}

/** 차트영역 */
.index-contents3-chart {
	margin-bottom: 100px;
	/* 텍스트 윗부분 마진 */
	margin-top: 20px;
}

/** 검색 텍스트창 넓이 **/
.input-group {
	width: 200px;
}

/***/
.index-contents4-photo {
	width: 1100px;
}

/** 예방수칙 이미지에 마우스 올릴 시 애니메이션 적용 */
.index-contents4-photo img:hover{
    cursor: pointer;
    transform: scale(2.5); 
    -o-transform: scale(2.5); 
    -moz-transform: scale(2.5);
    -webkit-transform: scale(2.5);
    transition: transform .2s;  
    -o-transition: transform .2s;
    -moz-transition: transform .2s;
    -webkit-transition: transform .2s;
    z-index: 10000;
}
</style>
<!--// 메인 페이지에 적용될 CSS 속성 -->

<!-- ========== 컨텐츠 영역 시작 ========== -->
<!-- 컨텐츠 1) 광고 페이징 영역 -->
<div class="container index-contents1-ad">
	<div id="carousel-id" class="carousel slide" data-ride="carousel">
		<!-- 중앙 하단부 동그라미들 -->
		<ol class="carousel-indicators">
			<li data-target="#carousel-id" data-slide-to="0" class="active"></li>
			<li data-target="#carousel-id" data-slide-to="1" class=""></li>
			<li data-target="#carousel-id" data-slide-to="2" class=""></li>
		</ol>
		<!-- 이미지 슬라이드 -->
		<div class="carousel-inner">
			<div class="item active"
				style="background-image: url(<%=request.getContextPath()%>/assets/img/ad3.jpg)">
				<div class="container">
					<div class="carousel-caption">
						<p><a class="btn btn-lg btn-warning alert-warning" href="<%=request.getContextPath()%>/shop/shop-detail.do?id=32" role="button">보러가기</a></p>
					</div>
				</div>
			</div>
			<div class="item"
				style="background-image: url(<%=request.getContextPath()%>/assets/img/ad2.jpg)">
				<div class="container">
					<div class="carousel-caption">
						<p><a class="btn btn-lg btn-warning alert-warning" href="<%=request.getContextPath()%>/shop/shop-detail.do?id=24" role="button">보러가기</a></p>
					</div>
				</div>
			</div>
			<div class="item"
				style="background-image:url(<%=request.getContextPath()%>/assets/img/ad1.jpg)">
				<div class="container">
					<div class="carousel-caption">
						<p><a class="btn btn-lg btn-warning alert-warning" href="<%=request.getContextPath()%>/shop/shop-detail.do?id=63" role="button">보러가기</a></p>
					</div>
				</div>
			</div>
		</div>
		<!-- 이전,다음 버튼 -->
		<a class="left carousel-control" href="#carousel-id" data-slide="prev">
			<span class="glyphicon glyphicon-chevron-left"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#carousel-id"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
</div>

<!-- 컨텐츠 2) 검색엔진 영역 -->
<br> <br>
<div class="container text-center index-contents2-search">
	<h2>어떤 약인지 찾아보세요</h2>
	<br>
	<div class="content-find">
		<!-- 모양으로찾기 검색버튼: 클릭하면 약검색 페이지로 이동! -->
		<button type="button" class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/medicine.do'"
			style="float: left; margin-bottom: -1px;">모양으로 검색</button>
		<div style="clear: both; float: none;"></div>
		<form class="medi_find" id="medi_find" name="medi_find" method="get">
			<div class="input" style="z-index: 10;">
				<input type="text" class="form-control" id="medicine"
					placeholder="약 이름을 입력하세요" style="border-radius: 4px 0 0 4px;">
				<!-- 약찾기 검색버튼 -->
				<button type="submit" class="btn btn-warning"
					style="border-radius: 0 4px 4px 0; margin-left: -1px">
					<span class="fas fa-search"></span>
				</button>
			</div>
		</form>
	</div>
	<br> <br> <br> <br>
	<h2>동네 병원을 찾아보세요</h2>
	<br>
 	<form class="myform" id="myform" method="get" action="${pageContext.request.contextPath}/hospital">
 	 	<button type="submit" class="btn btn-lg btn-info alert-primary">병원 찾고 예약하기</button>
	</form>
	<br> <br> <br> <br>
	<h2>24시간 운영중인 약국이 있을까?</h2>
	<br>
 	<form class="myform" method="get" action="${pageContext.request.contextPath}/drug">
 	 	<button type="submit" class="btn btn-lg btn-info alert-primary">동네 약국 찾아보기</button>
	</form>
	<!-- 구분선 -->
	<hr class="hr-tag-search-chart">
</div>

<!-- 컨텐츠 3) 보건의료 차트 영역 -->
<div class="container index-contents3-chart">
	<h2>
		<img id="covid19" src="<%=request.getContextPath()%>/assets/img/chart.png"
			style="height: 41px"> 코로나바이러스감염증-19(COVID-19) 국내 동향
	</h2>
	<br> <br>
	<!-- 선그래프 -->
	<div class="chart-line">
		<%@ include file="assets/chart/chart-line.jsp"%>
	</div>
	<br> <br>
	<div class="chart-bar">
		<%@ include file="assets/chart/chart-bar.jsp"%>
	</div>
</div>

<!-- 컨텐츠 4) 예방행동수칙 및 긴급연락처 -->
<div class="container index-contents4-photo">
	<div class="title">
		<h3>예방 행동 수칙</h3>
	</div>
	<img src="https://i.imgur.com/BJdE2g6.jpg" alt="코로나19 예방 행동 수칙"
		class="col-md-3 col-lg-3 col-xs-3 col-sm-3">
	<img
		src="https://i.imgur.com/B74dDcu.jpg" alt="코로나19 자가격리대상자 생활수칙"
		class="col-md-3 col-lg-3 col-xs-3 col-sm-3">
	<img
		src="https://i.imgur.com/uMVqz9Z.jpg"
		alt="코로나19 자가격리 대상자 가족, 동거인 생활수칙"
		class="col-md-3 col-lg-3 col-xs-3 col-sm-3">
	<img
		src="https://i.imgur.com/FLjFIDN.jpg" alt="코로나19 의료기관수칙"
		class="col-md-3 col-lg-3 col-xs-3 col-sm-3">
	<p class="text-center table-legend">출처: 
		<a class="text-reset text-decoration-none"
			href="http://www.cdc.go.kr/gallery.es?mid=a20503020000&bid=0003"
			target="_blank">질병관리본부 웹사이트</a>
	</p>
</div>

<hr style="border: 0"/>

<div class="container index-contents4-emergency">
	<div class="title">
		<h3>긴급연락처</h3>
	</div>
	<ul>
		<li>📍 <a
			href="https://search.naver.com/search.naver?where=m&sm=mtb_etc&query=%EC%8B%A0%EC%A2%85%EC%BD%94%EB%A1%9C%EB%82%98%EB%B0%94%EC%9D%B4%EB%9F%AC%EC%8A%A4%20%EC%84%A0%EB%B3%84%EC%A7%84%EB%A3%8C%EC%86%8C"
			target="_blank"> 선별 진료소 찾기</a></li>
		<li>📍 <a
			href="https://search.naver.com/search.naver?where=m&sm=mtb_etc&query=%EB%B3%B4%EA%B1%B4%EC%86%8C"
			target="_blank"> 관할 보건소 찾기</a></li>
		<li>📞 <a href="tel:120">지역콜센터 120 전화걸기</a></li>
		<li>📞 <a href="tel:1339">콜센터 1339 전화걸기</a></li>
	</ul>
</div>

<hr style="border: 0"/>

<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- 팝업창 띄우기 -->
<script type="text/javascript">
	console.log(document.cookie);

	// ==== 쿠키 확인하기
	var currentCookie = document.cookie;
	var cookieCheck = document.cookie.indexOf('wtmVisitor');
	
	console.log(cookieCheck);
	
	if(cookieCheck == -1 ){
		window.open('/wtm/popup.do', "","width=230,height=610, left=200,top=110,scrollbars=no");
	}
	
	// ==== 쿠키 생성하기
	var today = new Date();
	
	today.setDate(today.getDate() + 1);
	
	var setCookie = '';
	setCookie += 'CookieName = wtmVisitor/ ';
	setCookie += 'expires =' + today.toUTCString();
	
	document.cookie = setCookie;
</script>

<!-- 개발자가 구현하는 스크립트 블록 -->
<script type="text/javascript">
	// 약검색 페이지로 이동
	function medicineSearch() {
		var url = '<%=request.getContextPath()%>/medicine.do';
		var form = document.createElement('form');
		form.setAttribute('method', 'get');
		form.setAttribute('action', url);
		document.charset = 'utf-8';

		var Field = document.createElement('input');
		Field.setAttribute('type', 'hidden');
		Field.setAttribute('name', 'itemName');
		Field.setAttribute('value', $('#medicine').val());
		 
		form.appendChild(Field);

		document.body.appendChild(form);
		form.submit();
	}
	
	$(function() {
		/** 약 검색 엔진 입력값 검사, 포커스 이동 */
		$("#medi_find").submit(function(e) {
			e.preventDefault();

			var medi = $("#medicine").val();
			if (!medi) {
				swal({
					title : "약 이름을 입력해주세요.",
					type : "error"
				}).then(function(result) {
					setTimeout(function() {
						$("#medicine").focus();
					}, 100);
				});
				return false;
			}
			
			medicineSearch();
		});
	});
</script>


<%@ include file="./_inc/footer.jsp"%>