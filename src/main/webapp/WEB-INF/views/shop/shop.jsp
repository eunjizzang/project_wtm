<%
/**
* @filename : shop.jsp
* @description : --- 쇼핑몰 메인 페이지 ---
* @author : 이 상 희(46wendy@naver.com)
*/
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../_inc/header.jsp"%>

<!-- CSS 참조 -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/shop.css">

<style type="text/css">
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container contents">

	<div class="button">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/shop">전체상품</a>
        <a class="btn btn-primary" type="submit" href="${pageContext.request.contextPath}/shop?category=vimi">비타민/미네랄</a>
        <a class="btn btn-primary" type="submit" href="${pageContext.request.contextPath}/shop?category=lacto">유산균</a>
        <a class="btn btn-primary" type="submit" href="${pageContext.request.contextPath}/shop?category=oil">오메가3</a>
        <a class="btn btn-primary" type="submit" href="${pageContext.request.contextPath}/shop?category=health">헬스보충식품</a>
    </div>
    
    <form id="myform" method="get" action="${pageContext.request.contextPath}/shop">
        <div class="search">
            <div class="input-group">
                <input type="search" class="form-control" name="keyword" id="prod_name" placeholder="Search" value="${keyword}" />
                <span class="input-group-btn">
                    <button type="submit" class="btn btn-success" id="prod_search">
                        <span class="fas fa-search"></span>
                    </button>
                </span>
            </div>
        </div>
    </form>
    
    <!-- 컨텐츠 상품 목록 영역 -->
    <div class="row product-list">
    	
    	<c:choose>
    			<%-- 조회결과가 없는 경우 --%>
    			<c:when test="${output == null || fn:length(output) == 0}">
    				<div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px;">
    					<h2 align="center" style="width: 940px;">조회 결과가 없습니다.</h2>
    				</div>
    			</c:when>
                <%-- 조회결과가 있는 경우 --%>
                <c:otherwise>
                <%-- 조회결과에 따른 반복 처리 --%>
                	<c:forEach var="item" items="${output}" varStatus="status">
				        <%-- 출력을 위해 준비한 상품 이름 변수 --%>
				        <c:set var="name" value="${item.name}" />
				        <c:set var="eng" value="${item.eng}" />
				        
				        <%-- 검색어가 있다면? --%>
                        <c:if test="${keyword != ''}">
                            <%-- 검색어에 <mark> 태그를 적용하여 형광팬 효과 준비 --%>
                            <c:set var="mark" value="<mark>${keyword}</mark>" />
                            <%-- 출력을 위해 준비한 상품 이름에서 검색어와 일치하는 단어를 형광팬 효과로 변경 --%>
                            <c:set var="name" value="${fn:replace(name, keyword, mark)}" />
                            <c:set var="eng" value="${fn:replace(eng, keyword, mark)}" />
                        </c:if>
                        
                        <%-- 상세페이지로 이동하기 위한 URL --%>
                        <c:url value="/shop/shop-detail.do" var="viewUrl">
                            <c:param name="id" value="${item.id}" />
                        </c:url>
                        
				        <div class="product-item col-md-3 col-sm-6 col-xs-12">
				            <a href="${viewUrl}">
				                <!-- img-responsive = 브라우저 작아지면 사진도 작아짐 -->
				                <img src="${item.img}" class="img-responsive" style="width: 212px; height: 212px;" />
				                <span class="sr-only">영양제 이미지</span>
				                <h4 style="margin-bottom: 0;">
				                    <p class="text-center" style="height: 42px; margin: 0" style="height: 30px; margin: 0;">${name}</p>
				                </h4>
				                <h6 style="margin-top: 0px; margin-bottom: 0px; height: 36px;">
				                	<p class="text-center" style="height: 52px; margin: 0" style="height: 52px; margin: 0">${eng}</p>
				                </h6>
				                <hr style="margin: 0"/>
				                <p class="price text-center" style="margin:0; padding-top: 5px;">
				                    <fmt:formatNumber value="${item.price}" pattern="#,###" />
				                    <span>원</span>
				                </p>
				            </a>
				        </div>
					</c:forEach>
				</c:otherwise>				     
        </c:choose>
    </div> <!-- row product-list -->
    
    <!-- 페이지 번호 구현 -->
    <nav>
	    <ul class="pagination">
		    <%-- 이전 그룹에 대한 링크 --%>
		    <c:choose>
		        <%-- 이전 그룹으로 이동 가능하다면? --%>
		        <c:when test="${pageData.prevPage > 0}">
		            <%-- 이동할 URL 생성 --%>
		            <c:url value="/shop" var="prevPageUrl">
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
		    
		    <%-- 페이지 번호 (시작 페이지 부터 끝 페이지까지 반복) --%>
		    <c:forEach var="i" begin="${pageData.startPage}" end="${pageData.endPage}" varStatus="status">
		        <%-- 이동할 URL 생성 --%>
		        <c:url value="/shop" var="pageUrl">
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
		            <c:url value="/shop" var="nextPageUrl">
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
<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- 개발자가 구현하는 스크립트 블록 -->
<script type="text/javascript">
 	$(function() {
		/** 검색창 데이터 입력 검사 **/
 		$("#prod_search").click(function(e) {
 			e.preventDefault(); // 데이터 전송 강제 중단

 			var prod_name = $("#prod_name").val(); // 입력값 가져오기
 			var prod_name2 = $.trim(prod_name); // 앞 뒤 공백제거(스페이스바 - 공백 인식)
 			// 검색창 입력값이 존재하지않는다면
 			if (!prod_name2) {								
 			    swal({
 			        title: "검색어를 입력해주세요.", 			// 제목
 			        html: "", 										// 내용
 			        type: "error", 								// 종류
 			        confirmButton: true, 					// 확인버튼 표시여부
 			        confirmButtonText: "확인", 			// 확인버튼표시문구     
 			    })
 			    return flase; 									// 함수 처리 중단
 			// 검색창 입력값이 존재한다면
 			}	else {
 				$("#myform").submit();
 			}
 		});
 	});
</script>

<%@ include file="../_inc/footer.jsp"%>
