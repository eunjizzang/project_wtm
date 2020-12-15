<%
/**
* @filename : order.jsp
* @description : --- 전체 주문내역 페이지 ---
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/order.css">

<style type="text/css">
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container order_contents" style="min-height: 600px;">
	<div class="contents_header">
		<h2 class="order-title"><img src="<%=request.getContextPath()%>/assets/img/order.png" class="order_img" style="width:50px" ><strong>&nbsp;주문내역</strong></h2>
		<c:choose>
			<%-- 조회결과가 없는 경우 --%>
    		<c:when test="${period == null || fn:length(period) == 0}">
				<span></span>
				<form class="myform" id="myform" method="get" action="${pageContext.request.contextPath}/mypage/order.do" style="margin-left: 575px;">
					<select id="drop_period" name="period" class="dropdown period">
						<option value="">  &nbsp; 기간 설정 </option>
						<option class="week" value="일주일">&nbsp; 일주일 </option>
						<option class="three_m" value="한달">&nbsp; 한달 </option>
						<option class="six_m" value="6개월">&nbsp;  6개월 </option>
						<option class="one_y" value="1년">&nbsp;  1년  </option>		
						<option class="three_y" value="3년">&nbsp;  3년  </option>						
					</select>	<!-- drop_period -->			
				</form>
			</c:when>
			<c:otherwise>
				<span>${period}간의 주문내역입니다.</span>
				<form class="myform" id="myform" method="get" action="${pageContext.request.contextPath}/mypage/order.do" style="margin-left: 390px;">
					<select id="drop_period" name="period" class="dropdown period">
						<option value="">  &nbsp; 기간 설정 </option>
						<option class="week" value="일주일">&nbsp; 일주일 </option>
						<option class="three_m" value="한달">&nbsp; 한달 </option>
						<option class="six_m" value="6개월">&nbsp;  6개월 </option>
						<option class="one_y" value="1년">&nbsp;  1년  </option>		
						<option class="three_y" value="3년">&nbsp;  3년  </option>						
					</select>	<!-- drop_period -->			
				</form>
			</c:otherwise>
		</c:choose>
	</div>
	
	<c:choose>
	
		<%-- 조회결과가 없는 경우 --%>
		<c:when test="${output == null || fn:length(output) == 0}">
		    <div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px;">
		        <h2 align="center" style="width: 940px; display: inline-block">조회 결과가 없습니다.</h2>
		    </div>
		</c:when>
		
		<%-- 조회결과가 있는 경우 --%>
		<c:otherwise>
		    <%-- 조회결과에 따른 반복 처리 --%>
		    <c:forEach var="item" items="${output}" varStatus="status">
		        <%-- 상세페이지로 이동하기 위한 URL --%>
		        <c:url value="/mypage/order-detail.do" var="viewUrl">
		            <c:param name="id" value="${item.id}" />
		        </c:url>
		        <!-- 주문내역 -->
		        <h3 class="order_num"><strong>주문번호: <span>${item.id}</span></strong></h3>
		        <ul class="order-item order-item-${item.id}" style="padding-left: 0px;">
		            <li>
		            	<div class="order_name">
							<a href="${viewUrl}">
								<h4 class="order_name_text">
						            <c:forEach begin="0" end="0" var="info" items="${item.prodInfo}" varStatus="status">
						            	<strong>${info.name}</strong>
						            </c:forEach>
						            &nbsp; 외&nbsp; ${item.count-1}건
								</h4>
		                        <span class="fas fa-chevron-right fa-lg"></span>
							</a>
		                </div>
		                <div class="order_info">
		                        <div class="thumb">
		                        	<c:forEach begin="0" end="0" var="info" items="${item.prodInfo}" varStatus="status">
		                            	<img src="${info.img}" width="90px;" height="100px;" />
		                            </c:forEach>
		                        </div>
		                    <div class="order_desc">
		                        <dl class="order_price">
		                            <dt>결제금액</dt>
		                            <dd>
		                                <fmt:formatNumber value="${item.totalPrice}" pattern="#,###" />원</dd>
		                        </dl>
		                        <dl class="order_date">
		                            <dt>주문날짜</dt>
		                            <dd>${item.orderDate}</dd>
		                        </dl>
		                        <dl class="order_status">
		                            <dt>주문상태</dt>
		                            <dd>${item.status}</dd>
		                        </dl>
		                    </div> <!-- oder_desc -->
		                </div> <!-- order_info -->
		            </li>
		        </ul> <!--  order-item order-item-{id} -->
		        
		        <br />
		        <br />
				
			</c:forEach>
		</c:otherwise>
		
	</c:choose>

	<br/>
	<br />
	
	<c:choose>
	
		<%-- 조회결과가 없는 경우 --%>
		<c:when test="${output == null || fn:length(output) == 0}">
		    <div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px;">

		    </div>
		</c:when>
		
		<c:otherwise>
			<!-- 페이지 번호 구현 -->
			<nav>
			    <ul class="pagination">
			        <%-- 이전 그룹에 대한 링크 --%>
			        <c:choose>
			            <%-- 이전 그룹으로 이동 가능하다면? --%>
			            <c:when test="${pageData.prevPage > 0}">
			                <%-- 이동할 URL 생성 --%>
			                <c:url value="/mypage/order.do" var="prevPageUrl">
			                    <c:param name="page" value="${pageData.prevPage}" />
			                    <c:param name="period" value="${period}" />
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
			            <c:url value="/mypage/order.do" var="pageUrl">
			                <c:param name="page" value="${i}" />
			                <c:param name="period" value="${period}" />
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
			                <c:url value="/mypage/order.do" var="nextPageUrl">
			                    <c:param name="page" value="${pageData.nextPage}" />
			                    <c:param name="period" value="${period}" />
			                </c:url>
			                <li><a href="${nextPageUrl}"><span>&raquo;</span></a></li>
			            </c:when>
			            <c:otherwise>
			                <li class="disabled"><span>&raquo;</span></li>
			            </c:otherwise>
			        </c:choose>
				</ul>
			</nav>
		</c:otherwise>		
					    
	</c:choose>
	
</div> <!--  container order_contents -->
<!--// ========== 컨텐츠 영역 끝 ========== -->

<script type="text/javascript">

	/** 드롭다운 변경될때마다, 드롭다운 값 가져와서 controller에 전송 */
	$("#drop_period").change(function() {
	    var select = $("#drop_period option:selected").val();
	    //console.log(select);
	    
	    $("#myform").submit();
	});

</script>

<%@ include file="../_inc/footer.jsp"%>
