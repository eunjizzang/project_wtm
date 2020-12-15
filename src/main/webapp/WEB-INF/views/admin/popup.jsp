
<%
	/**
* @ Project : 이거모약?
* @ FileName : admin_adint.jsp
* @ Date : 2020.10.03
* @ Author : 이 민 희(lmnhofficial@gmail.com)
* @ Description : 사이트 메인에 뜨는 팝업
*/
%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style type="text/css">
.imgstar {
	width: 100px;
	height: 100px;
}

ul {
	list-style: none;
}

#gallery {
	width: 200px;
}

#gallery li a span {
	display: block;
	width: auto;
}

#gallery .text {
	width: 100%;
	font-size: 8;
	margin: auto;
	text-align: center;
}
</style>


	<div class="popupad">
		<div id="header">
			<img class="imgstar" src="assets/img/abest.png" />

		</div>
		<c:choose>
			<%-- 조회결과가 없는 경우 --%>
			<c:when test="${output == null || fn:length(output) == 0}">
				<div class="product-item col-md-3 col-sm-6 col-xs-12"
					style="min-height: 600px;">
					<h2 align="center" style="width: 940px;">조회 결과가 없습니다.</h2>
				</div>
			</c:when>
			<%-- 조회결과가 있는 경우 --%>
			<c:otherwise>
				<%-- 조회결과에 따른 반복 처리 --%>
				<c:forEach var="item" items="${output}" varStatus="status">
					<ul id="gallery"
						style="margin-top: 0px; padding-left: -; padding-left: -; padding-left: -; padding-left: 0px;">
						<li><span class="thumb"><img
									style="width: 200px; height: 200px;" src="/wtm/upload/${item.adimg}" /></span> <span
								class="text">${item.adname}</span>
						</li>
					</ul>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<div>
			<p>
				<input type="button" value="하루동안 열지 않기" onClick="window.close()">
			</p>
		</div>
	</div>
