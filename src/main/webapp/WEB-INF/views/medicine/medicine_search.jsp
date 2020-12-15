
<%
	/**
* @filename : medicine_search.jsp
* @description : --- 약검색페이지 ---
* @author : 박수인(sooin5959@gmail.com)
*/
%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- header/css 적용 -->
<%@ include file="../_inc/header.jsp"%>



<!-- ========== css 설정 ============= -->
<!-- slick 플러그인 css -->
<link rel="stylesheet" type="text/css"
	href="assets/plugins/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="assets/plugins/slick/slick-theme.css" />
<link rel="stylesheet" type="text/css"
	href="assets/plugins/slick/prism.css">
<link rel="stylesheet" type="text/css"
	href="assets/plugins/slick/style.css">

<style type="text/css">
/** '약정보로 검색' */
.infosearch {
	font-weight: bold;
	font-size: 25px;
	float: left;
	padding-right: 54px;
	margin-bottom: 0px;
}

/** 약정보 검색바 전체 */
.search1 {
	margin-top: 35px;
}

.shapesearch {
	font-weight: bold;
	font-size: 25px;
	float: left;
	padding-right: 30px;
}

.form-control {
	width: 450px;
}

/** 검색버튼 style*/
.btn-search {
	background-color: #2E9AFE;
	width: 110px;
	height: 40px;
	text-align: middle;
	font-weight: bold;
	font-size: 15px;
	margin-left: 350px;
}

/** 약 검색 리스트 style */

/** 
* .content:약모양검색 전체단위
* .medlist_wrap : 약리스트 전체단위
* .content_li: 약정보리스트 하나 단위
* .med_img : 약 이미지 
* .img_area:  약이미지 div
* .info_area:약 정보 div
* . subject: 약이름 제목
* .truncated_info: 약정보내용요약
*/

.content{
margin-top:35px;
}

.content_li {
width:900px;
	height: 160px;
	list-style: none;
	margin-bottom:40px;
}

.med_img {
	width: 160px;
	height: 100px;
	margin-top: 30px;
}

.img_area {
	width: 160px;
	height: 160px;
	border: solid 1px #bababa;
	margin-right: 20px;
	float: left;
}

.info_area {
width:720px;
	height: 160px;
}

.subject {
	height: 40px;
	margin-bottom: 5px;
	font-size: 20px;
	font-weight: bold;
	color: #2E9AFE;
}

.truncated_info {
	font-size: 14px;
	font-weight: normal;
	color: black;
	text-align: justify;

	/* 약정보내용 줄여서 표현 말줄임표*/
	display: -webkit-box;
	-webkit-line-clamp: 5;		 /* 5줄까지만 보여주기*/
	-webkit-box-orient: vertical;
	overflow: hidden
}

/** ---------- slick slide css 설정 --------------*/
/** 배경화면 색상 */
#features {
	background: #ffffff;
}

/** 슬라이드 화살표 이미지 (다음) */
.slick-next:before {
	content: url("assets/img/arrow_next.png");
	width: 40px;
	height: 40px;
}

/** 슬라이드 화살표 이미지 (이전) */
.slick-prev:before {
	content: url("assets/img/arrow_back.png");
}

.slick-track {
	padding-left: 0px;
	margin-right: 0px;
}

.content {
	margin-left: 30px;
	margin-right: 30px;
	width: 750px;
}

/** 약색상 슬라이드 */
.slider responsive {
	width: 600px;
}

/** 슬라이드 첫번째 '색상전체' */
.all_select {
	font-size: 14px;
	color: black;
	margin-bottom: 0px;
	margin-top: 15px;
	margin-bottom: 15px;
}

/** 색상 이름 */
.colorname {
	font-size: 12px;
	color: black;
	padding-bottom: 0px;
	margin-bottom: 0px;
}

.slick-slide slick-active {
	margin-right: 0px;
	padding-right: 10px;
	padding-left: 10px;
}

/**  제형 슬라이드/분할선슬라이드 css  */
.slick-track {
	margin-left: 0px;
}
</style>


<!-- ========== css 설정 끝 ============= -->

<!-- ========== 컨텐츠 영역 시작 ========== -->

<div class="medsearch container">

	<form name="med_search" method="get" action="${pageContext.request.contextPath}/medicine">

		<div class="form-group">

			<div class="search1">
				<p class="infosearch">약 정보로 검색</p>
				<input type="text" class="form-control" name="itemName" id="itemName" value="${itemName}"
					placeholder="약 이름으로 검색해 보세요."> <br />
			</div>

			<div class="search2">
				<p class="shapesearch">약 모양으로 검색</p>
			</div>

		</div>


		<section id="features" class="blue">

			<div class="content">
				<!-- 색상 선택 슬라이드 -->
				<div class="slider responsive">
					<div>
						<p class="all_select">
							색상 <br /> 전체
						</p>
					</div>

					<div>
						<img src="assets/img/med_white.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>흰색</p>
					</div>

					<div>
						<img src="assets/img/med_yellow.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>노랑</p>


					</div>

					<div>
						<img src="assets/img/med_orange.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>주황</p>
					</div>
					<div>
						<img src="assets/img/med_pink.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>분홍</p>
					</div>
					<div>
						<img src="assets/img/med_red.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>빨강</p>
					</div>
					<div>
						<img src="assets/img/med_brown.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>갈색</p>
					</div>
					<div>
						<img src="assets/img/med_lightgreen.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>연두</p>
					</div>
					<div>
						<img src="assets/img/med_green.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>초록</p>
					</div>
					<div>
						<img src="assets/img/med_bluegreen.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>청록</p>
					</div>
					<div>
						<img src="assets/img/med_blue.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>파랑</p>
					</div>
					<div>
						<img src="assets/img/med_navy.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>남색</p>
					</div>
					<div>
						<img src="assets/img/med_purple.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>자주</p>
					</div>
					<div>
						<img src="assets/img/med_violet.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>보라</p>
					</div>
					<div>
						<img src="assets/img/med_grey.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>회색</p>
					</div>
					<div>
						<img src="assets/img/med_black.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>검정</p>
					</div>
					<div>
						<img src="assets/img/med_clear.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>투명</p>
					</div>
				</div>


				<!-- 모양선택 슬라이드 -->
				<div class="slider responsive">
					<div>
						<p class="all_select">
							모양 <br /> 전체
						</p>
					</div>
					<div>
						<img src="assets/img/shape_circle.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>원형</p>

					</div>
					<div>
						<img src="assets/img/shape_oval.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>타원형</p>

					</div>
					<div>
						<img src="assets/img/shape_halfcircle.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>반원형</p>

					</div>
					<div>
						<img src="assets/img/shape_triangle.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>삼각형</p>

					</div>
					<div>
						<img src="assets/img/shape_square.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>사각형</p>

					</div>
					<div>
						<img src="assets/img/shape_rhombus.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>마름모형</p>

					</div>
					<div>
						<img src="assets/img/shape_minus.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>장방형</p>

					</div>
					<div>
						<img src="assets/img/shape_pentagon.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>오각형</p>

					</div>
					<div>
						<img src="assets/img/shape_hexagon.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>육각형</p>

					</div>
					<div>
						<img src="assets/img/shape_octagon.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>팔각형</p>

					</div>
					<div>
						<img src="assets/img/shape_infinite.png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>기타</p>

					</div>
				</div>

				<!-- 약 제형선택 -->
				<div class="slider responsive">
					<div class="fomulation">
						<p class="all_select">
							제형 <br /> 전체
						</p>
					</div>
					<div>
						<img src="assets/img/pill(1).png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>정제류</p>

					</div>
					<div>
						<img src="assets/img/pill(2).png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>경질캡슐</p>

					</div>
					<div>
						<img src="assets/img/pill(3).png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>연질캡슐</p>

					</div>
				</div>

				<!-- 분할선 선택 -->
				<div class="slider responsive">
					<div class="devide">
						<p class="all_select">
							분할선 <br /> 전체
						</p>
					</div>
					<div>
						<img src="assets/img/med_shape(1).png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>없음</p>

					</div>
					<div>
						<img src="assets/img/med_shape(2).png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>(-)형</p>

					</div>
					<div>
						<img src="assets/img/med_shape(3).png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>(+)형</p>

					</div>

					<div>
						<img src="assets/img/med_shape(4).png"
							style="width: 50px; height: 50px; margin-left: 10px;">
						<p class=colorname>기타</p>

					</div>
				</div>
			</div>

			<!-- 검색버튼 -->
			<input class='btn-search' type='submit' value='검색'>
			<hr />
			<!-- 약 리스트(초기설정은 전체목록/ 검색시 결과만 노출) -->
			<div class="medlist_wrap">

			<c:choose>
			<%--조회결과가 없는 경우 --%>
			<c:when test="${output == null || fn:length(output) == 0}">
			<div class="none_result" >
    					<p>선택한 조건에 맞는 의약품 검색결과가 없습니다.</p>>
    		</div>
			</c:when>
			<%-- 조회결과가 있는 경우 --%>
                <c:otherwise>
                <%-- 조회결과에 따른 반복 처리 --%>
                	<c:forEach var="item" items="${output}" varStatus="status">
                	
                	<%-- 상세페이지로 이동하기 위한 URL --%>
                        <c:url value="/medicine/medicine_detail.do" var="viewUrl">
                            <c:param name="itemSeq" value="${item.itemSeq}" />
                        </c:url>
				<ul>
					<li class="content_li">
					<a href="${viewUrl}">
						<div class="img_area">
							<img class="med_img" src="${item.drugImg}">
						</div>
						</a>
						<div class="info_area">
							<div class="subject"><a href="${viewUrl}">${item.itemName}</a></div>
							<p class="truncated_info">[외형정보]· 성상 :   ${item.chart}· 모양 :  ${item.drugShape} · 색상 : ${item.color1} · 색상 : ${item.color2}
							 · 분할선 : ${item.line1} · 분할선 : ${item.line2} · 저장방법 : ${item.storageMethod} · 효능효과 : ${item.effectData} ·  용법용량 : ${item.usageData}</p>
						</div>
					</li>
				</ul>
				</c:forEach>
				</c:otherwise>
			</c:choose>
			</div>
		</section>
		
    <!-- 페이지 번호 구현 -->
    <nav style="margin-left: 320px;">
	    <ul class="pagination">
		    <%-- 이전 그룹에 대한 링크 --%>
		    <c:choose>
		        <%-- 이전 그룹으로 이동 가능하다면? --%>
		        <c:when test="${pageData.prevPage > 0}">
		            <%-- 이동할 URL 생성 --%>
		            <c:url value="/medicine" var="prevPageUrl">
		                <c:param name="page" value="${pageData.prevPage}" />
		                <c:param name="itemName" value="${itemName}" />
		            </c:url>
		            <li><a href="${prevPageUrl}"><span>&laquo;</span></a></li>
		        </c:when>
		        <c:otherwise>
		            <li class="disabled"><span>&laquo;</span></li>
		        </c:otherwise>
		    </c:choose>
		    
		    <%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
		    <c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
		        <%-- 이동할 URL 생성 --%>
		        <c:url value="/medicine" var="pageUrl">
		            <c:param name="page" value="${i}" />
		            <c:param name="itemName" value="${itemName}" />
		        </c:url>
		        
		        <%-- 페이지 번호 출력 --%>
		        <c:choose>
		            <%-- 현재 머물고 있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
		            <c:when test="${pageData.nowPage == i}">
		                <li class="active"><a href="${pageUrl}">${i}</a></li>
		            </c:when>
		            <%-- 나머지 페이지의 경우 링크 적용함 --%>
		            <c:otherwise>
		                <li><a href="${pageUrl}">${i}</a></li>
		            </c:otherwise>
		        </c:choose>
		    </c:forEach>
		    
		    <%-- 다음 그룹에 대한 링크 --%>
		    <c:choose>
		        <%-- 다음 그룹으로 이동 가능하다면? --%>
		        <c:when test="${pageData.nextPage > 0}">
		            <%-- 이동할 URL 생성 --%>
		            <c:url value="/medicine" var="nextPageUrl">
		                <c:param name="page" value="${pageData.nextPage}" />
		                <c:param name="itemName" value="${itemName}" />
		            </c:url>
		            <li><a href="${nextPageUrl}"><span>&raquo;</span></a></li>
		        </c:when>
		        <c:otherwise>
		            <li class="disabled"><span>&raquo;</span></li>
		        </c:otherwise>
		    </c:choose>
	    </ul>
    </nav>
	</form>
</div>

<!-- ========== 컨텐츠 영역 끝 ========== -->

<!-- ========== Javascript 시작 ========== -->
<!-- slick plugin 참조 / 약모양,약색상 등 슬라이드에 이용 -->
<script type="text/javascript" src="assets/plugins/slick/slick.min.js"></script>

<script type="text/javascript">
<!-- =============== slick JS 시작 ================= -->
	$('.responsive').slick({
		dots : false,
		infinite : false,
		speed : 300,
		slidesToShow : 10,
		slidesToScroll : 7,
		responsive : [ {
			breakpoint : 1024,
			settings : {
				slidesToShow : 3,
				slidesToScroll : 3,
				infinite : false,
				dots : false
			}
		}, {
			breakpoint : 600,
			settings : {
				slidesToShow : 6,
				slidesToScroll : 6
			}
		}, {
			breakpoint : 480,
			settings : {
				slidesToShow : 6,
				slidesToScroll : 6
			}
		}
		// You can unslick at a given breakpoint now by adding:
		// settings: "unslick"
		// instead of a settings object
		]
	});
	<!--================= slick JS 끝 =======================-->
</script>
<!-- ========== Javascript 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>
