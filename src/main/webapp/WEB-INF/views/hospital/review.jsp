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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
#review{margin-left:100px;}
.content1{margin-left:200px;}
</style>
<div class="container">
	<div class="content1">
    <h1>리뷰</h1>
    <hr />

    <!-- 조회 결과 목록 -->
    <table border="1" id="review">
        <thead>
            <tr>
                <th width="30" align="left">번호</th>
                <th width="300" align="center">내용</th>
                <th width="100" align="center">작성자</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <%-- 조회결과가 없는 경우 --%>
                <c:when test="${output == null || fn:length(output) == 0}">
                    <tr>
                        <td colspan="2" align="center">리뷰가 없습니다.</td>
                    </tr>
                </c:when>
                <%-- 조회결과가 있는  경우 --%>
                <c:otherwise>
                    <%-- 조회 결과에 따른 반복 처리 --%>
                    <c:forEach var="item" items="${output}" varStatus="status">
                        <%-- 출력을 위해 준비한 학과이름과 위치 --%>
                        <c:set var="content" value="${item.content}" />
                        <tr>
                            <td height="30" align="center">${item.reviewId}</td>
                            <td height="30" align="center">${content}</td>
                            <td height="30" align="center">.</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>