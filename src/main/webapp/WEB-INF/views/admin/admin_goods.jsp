
<%
	/**
* @ Project : 이거모약?
* @ FileName : admin_goods.jsp
* @ Date : 2020.09.21
* @ Author : 이 민 희(lmnhofficial@gmail.com)
* @ Description :
*/
%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../_inc/header.jsp"%>
<%@ include file="../_inc/adminnavi.jsp"%>

<link rel="stylesheet"
	href="assets/plugins/sweetalert/sweetalert2.min.css" />


<%-- ========== CSS 영역 ========== --%>

<style type="text/css">
.header-navi {
	display: none;
}

.table>thead>tr>th {
	border-top: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	border-right: 1px solid #e6e6e6;
	border-left: 1px solid #e6e6e6;
	background: #f6f6f6;
	text-align: center;
}

.navbar-default .button_goods a {
	text-decoration: none;
	color: #ffffff;
}

div.container div table tbody button a {
	text-decoration: none;
	color: #ffffff;
}

.btn_ov01 .ov_txt {
	float: left;
	background: #565e8c;
	color: #fff;
	border-radius: 5px 0 0 5px;
	padding: 0 5px;
}

.btn_ov01 .ov_num {
	float: left;
	background: #9eacc6;
	color: #fff;
	border-radius: 0 5px 5px 0;
	padding: 0 5px;
}

.container>div>table>tbody>.goodsline1>td.text-center.goodsnum {
	padding-top: 35px;
}

.container>div>table>tbody>.goodsline1>td.text-center.goodsimg {
	padding-top: 20px;
}

.container>div>table>tbody>.goodsline1>td.text-center.goodsbtn {
	padding-top: 25px;
}

.container>div>table>tbody>.goodsline2>td.text-center.goodsname {
	padding-top: 18px;
}

.container>div>table>tbody>.goodsline2>td.text-center.goodsprice {
	padding-top: 18px;
}
</style>


<%-- ========== 컨텐츠 영역 ========== --%>

<div class="container">

	<!-- === 제목 === -->

	<nav class="navbar navbar-default"
		style="margin-top: 10px; margin-bottom: 15px;">
		<div class="container-fluid">
			<div class="navbar-header">
				<h3 style="margin-top: 12px;">상품관리</h3>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">

				<!-- 상품명 검색 칸 -->
				<form method="get" class="navbar-form navbar-left" role="search"
					method="get"
					action="${pageContext.request.contextPath}/admin_goods.do">
					<div class="form-group">
						<div class="input-group">
							<input type="search" class="form-control" name="keyword"
								id="prod_name" placeholder="상품명을 입력하세요." value="${keyword}" />
							<span class="input-group-btn">
								<button type="submit" class="btn btn-success" id="prod_search">
									<span class="fas fa-search" aria-hidden="true"></span>
								</button>
							</span>
						</div>
					</div>
		
				<span>     등록된 상품 : <b>${totalCount}</b>건</span></form>

				<div class="buttons">
					<a href="${pageContext.request.contextPath}/admin_goodsint.do">
						<button type="button" class="btn btn-md btn-warning"
							style="margin-top: 7px; float: right">상품등록</button>
					</a>
				</div>
			</div>
		</div>
	</nav>

	<hr style="margin-bottom: 5px; margin-top: 0px;" />


	<!-- ===== 상품 테이블 ===== -->

	<div class="col-md-12">
		<table class="table">
			<thead>
				<tr>
					<th class="text-center" rowspan="2" style="padding-bottom: 25px;">상품코드</th>
					<th class="text-center" rowspan="2" style="padding-bottom: 25px;">이미지</th>
					<th class="text-center" colspan="2">분류</th>
					<th class="text-center" rowspan="2" style="padding-bottom: 25px;">판매가격</th>
				</tr>
				<tr>
					<th class="text-center">상품명</th>
				</tr>
			</thead>

			<tbody>
				<c:choose>
					<%-- 조회결과가 없는 경우 --%>
					<c:when test="${output == null || fn:length(output) == 0}">
						<tr>
							<td colspan="6" align="center">조회결과가 없습니다.</td>
						</tr>
					</c:when>
					<%-- 조회결과가 있는 경우 --%>
					<c:otherwise>
						<%-- 조회 결과에 따른 반복 처리 --%>
						<c:forEach var="item" items="${output}" varStatus="status">
							<%-- 출력을 위해 준비한 상품 이름 변수 --%>
							<c:set var="name" value="${item.name}" />

							<%-- 검색어가 있다면? --%>
							<c:if test="${keyword != ''} ">
								<c:set var="mark" value="<mark>${keyword}</mark>" />
								<c:set var="name" value="${fn:replace(name, keyword, mark)}" />
							</c:if>

							<tr class="goodsline1">
								<td class="text-center goodsnum" rowspan="2">${item.id}</td>
								<td class="text-center goodsimg" rowspan="2"><img
									src="${item.img}" width="50"></td>
								<td class="text-center goodsgroup" colspan="2">${item.category}</td>
								<td class="text-center goodsbtn" rowspan="2"><strong class="text">
										<span class="order-price"> ${item.price}</span>원
								</strong>
								</td>
							</tr>
							<tr class="goodsline2">
								<td class="text-center goodsname">${item.name}</td>
								
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>



		<!-- ===== 페이지 번호 구현 ===== -->
		<nav style="margin-left: 300px;">
			<ul class="pagination">
				<%-- 이전 그룹에 대한 링크 --%>
				<c:choose>
					<%-- 이전 그룹으로 이동 가능하다면? --%>
					<c:when test="${pageData.prevPage > 0}">
						<%-- 이동할 URL 생성 --%>
						<c:url value="/admin_goods.do" var="prevPageUrl">
							<c:param name="page" value="${pageData.prevPage}" />
							<c:param name="keyword" value="${keyword}" />
							<c:param name="category" value="${category}" />
						</c:url>
						<li><a href="${prevPageUrl}"><span>&laquo;</span></a></li>
					</c:when>
					<c:otherwise>
						<li class="disabled"><span>&laquo;</span></li>
					</c:otherwise>
				</c:choose>


				<%-- 페이지 번호 (시작 페이지부터 끝 페이지까지 반복) --%>
				<c:forEach var="i" begin="${pageData.startPage}"
					end="${pageData.endPage}" varStatus="status">
					<%-- 이동할 URL 생성 --%>
					<c:url value="/admin_goods.do" var="pageUrl">
						<c:param name="page" value="${i}" />
						<c:param name="keyword" value="${keyword}" />
						<c:param name="category" value="${category}" />
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
						<c:url value="/admin_goods.do" var="nextPageUrl">
							<c:param name="page" value="${pageData.nextPage}" />
							<c:param name="keyword" value="${keyword}" />
							<c:param name="category" value="${category}" />
						</c:url>
						<li><a href="${nextPageUrl}"><span>&raquo;</span></a></li>
					</c:when>
					<c:otherwise>
						<li class="disabled"><span>&raquo;</span></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>
	</div>
</div>

<!--// ========== 컨텐츠 영역 끝 ========== -->

<%@ include file="../_inc/footer.jsp"%>

<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
<script type="text/javascript">
	$(function() {

		/** 상품 삭제 버튼**/
		$(".deletebtn").click(function() {

			var deleteok = $(this);
			var goodsbtn = deleteok.parent();
			var goodsline1 = goodsbtn.parent();
			var goodsline2 = goodsline1.next();

			swal({
				title : '확인',
				text : '삭제하시겠습니까?',
				type : 'warning',
				confirmButtonText : '확인',
				showCancelButton : true,
				cancelButtonText : '취소',
			}).then(function(result) {
				if (result.value) {
					deleteok.remove();
					goodsbtn.remove();
					goodsline1.remove();
					goodsline2.remove();
				} else if (result.dismiss === 'cancel') {
					swal("취소", "삭제가 취소되었습니다.", "error");
				}
			});
		});

		/**판매상태 확인 버튼**/
		$(".sell_state_btn").click(function() {
			swal("판매 상태를 변경합니다.");
		});
	});
</script>
