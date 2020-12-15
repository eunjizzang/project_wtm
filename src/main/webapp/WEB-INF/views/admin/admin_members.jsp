
<%
	/**
* @ Project : 이거모약?
* @ FileName : admin_members.jsp
* @ Date : 2020.09.22
* @ Description : 
* @ Author : 이 민 희(lmnhofficial@gmail.com)
*/
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../_inc/header.jsp"%>
<%@ include file="../_inc/adminnavi.jsp"%>


<%-- ========== CSS 영역 ========== --%>

<style type="text/css">
.table>thead>tr>th {
	border-top: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	border-right: 1px solid #e6e6e6;
	border-left: 1px solid #e6e6e6;
	background: #f6f6f6;
	text-align: center;
}

.table>tbody>tr>td {
	border-top: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	border-right: 1px solid #e6e6e6;
	border-left: 1px solid #e6e6e6;
}
</style>


<%-- ========== 컨텐츠 영역 ========== --%>

<div class="container">

	<!-- === 제목 === -->
	<div class="page-header">
		<h2 style="display: inline;">전체 회원</h2>
	</div>

	<!-- === 회원 목록 테이블 === -->
	<div class="col-md-12">
		<table class="table">
			<thead>
				<tr>
					<th class="text-center" colspan="2">회원정보</th>
					<th class="text-center">회원상태</th>
					<th class="text-center">연락처</th>
					<th class="text-center">주소</th>
				</tr>
			</thead>

			<tbody>
				<c:choose>
					<%-- 초회결과가 없는 경우 --%>
					<c:when test="${output == null || fn:length(output) == 0}">
						<tr>
							<td colspan="4" align="center">조회결과가 없습니다.</td>
						</tr>
					</c:when>
					
					<%-- 초회결과가 있는 경우 --%>
					<c:otherwise>
						<c:forEach var="item" items="${output}" varStatus="status">
							<%-- 결과 보여주기 --%>
							<tr>
								<td align="center">${item.userId}</td>
								<td align="center">${item.userName}</td>
								<td align="center" rowspan="2" style="padding-top: 25px;">일반회원</td>
								<td align="center" rowspan="2" style="padding-top: 25px;">${item.tel}</td>
								<td align="center" rowspan="2" style="padding-top: 25px;">
									${item.address}<br /> ${item.detailAddress}<br />
									${item.extraAddress}<b>${item.postcode}</b>
								</td>
							</tr>
							<tr>
								<td align="center" colspan="2">${item.email}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>

	<!-- ===== 페이지 번호 구현 ===== -->
	<nav style="margin-left: 400px;">
		<ul class="pagination">
		
			<%-- 이전 그룹에 대한 링크 --%>
			<c:choose>
				<%-- 이전 그룹으로 이동 가능하다면? --%>
				<c:when test="${pageData.prevPage > 0}">
					<%-- 이동할 URL 생성 --%>
					<c:url value="/admin_members.do" var="prevPageUrl">
						<c:param name="page" value="${pageData.prevPage}" />
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
				<c:url value="/admin_members.do" var="pageUrl">
					<c:param name="page" value="${i}" />
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
					<c:url value="/admin_members.do" var="nextPageUrl">
						<c:param name="page" value="${pageData.nextPage}" />
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


<!--// ========== 컨텐츠 영역 끝 ========== -->

<%@ include file="../_inc/footer.jsp"%>