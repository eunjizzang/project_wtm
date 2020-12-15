<%
/**
* @filename : order-detail.jsp
* @description : --- 주문 상세 페이지 ---
				전체 주문내역 페이지에서 주문내역 하나 클릭했을때, 
				나오는 주문 상세 페이지입니다.
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/order-detail.css">

<style type="text/css">
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container order_contents" style="min-height: 600px;">
	<div class="contents_header">
		<h2 class="order-title"><img src="<%=request.getContextPath()%>/assets/img/order.png" class="order_img" style="width:50px" ><strong>&nbsp;주문내역</strong></h2>
	</div>
	
	<c:choose>
		<%-- 조회결과가 없는 경우 --%>
	   	<c:when test="${output1 == null || output2 == null}">
	   		<div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px;">
	  			<h2 align="center" style="width: 940px;">조회 결과가 없습니다.</h2>
	    	</div>
	    </c:when>
    	
    	<%-- 조회결과가 있는 경우 --%>
       	<c:otherwise>
	       	<div class="remove">
		      	<%-- 조회결과에 따른 반복 처리 --%>
				<!--  클릭한 nth 주문내역 -->
				<h3 class="order_num" style="width: 760px;"><strong>주문번호: <span>${output1.id}</span></strong></h3>
				<input type="hidden" class="order_id" value="${output1.id}" />
				<h4 class="order_date" style="width: 110px;">${output1.orderDate}</h4>
					
				<ul class="order-item order-item-${output1.id}" style="padding-left: 0px;">
				    <li>
						<div class="order_name">
					    	<h4 class="order_name_text">
					            <c:forEach begin="0" end="0" var="info" items="${output1.prodInfo}" varStatus="status">
					            	<strong>${info.name}</strong>
					            </c:forEach>
					            &nbsp; 외&nbsp; ${output1.count-1}건
							</h4>
						</div>
				        
				        <c:forEach var="info" items="${output1.prodInfo}" varStatus="status">
				        
				            <%-- 상세페이지로 이동하기 위한 URL --%>
				            <c:url value="/shop/shop-detail.do" var="viewUrl">
				                <c:param name="id" value="${info.productId}" />
				            </c:url>
				            
				            <!--  클릭한 3rd 주문내역의 1st 제품 -->
				            <div class="order_name_detail">
				                <h5 class="order_name_text_detail"><strong>${info.name}</strong></h5>
				            </div>
				            <div class="order_info">
				                <div class="thumb">
				                    <a href="${viewUrl}">
				                        <img src="${info.img}" width="90px;" height="100px;" />
				                    </a>
				                </div>
				                <div class="order_desc">
				                    <dl class="prod_price">
				                        <dt>상품단가</dt>
				                        <dd class="prod_price" data-value="${info.price}">
				                            <fmt:formatNumber value="${info.price}" pattern="#,###" />원
				                        </dd>
				                    </dl>
				                    <dl class="order_qty">
				                        <dt>주문수량</dt>
				                        <dd>${info.qty}</dd>
				                    </dl>
				                    <dl class="order_price">
				                        <dt>결제금액</dt>
				                        <dd class="order_price" data-value="${info.c_price}">
				                            <fmt:formatNumber value="${info.c_price}" pattern="#,###" />원
				                        </dd>
				                    </dl>
				                </div> <!-- oder_desc -->
				            </div> <!-- order_info -->
				            
				        </c:forEach>
				        
				    </li>
				</ul> <!--  order-item order-item-{id} -->
			</div> <!-- remove -->	
	
			<div class="cancel_box text-center">
				<button type="button" class="btn btn-warning" id="order_delete">
	    			전체 상품 주문 취소
	    		</button>
			</div>
		
			<!-- 주문 정보 -->
			<h3 class="orderer_info"><strong>주문 정보</strong></h3>
			<table class="order_table">
				<tbody>
					<colgroup>
						<col style="width: 15%">
						<col style="width: 85%">
					</colgroup>
					<tr>
						<th>주문번호</th>
						<td>${output2.orderId}</td>
					</tr>
					<tr>
						<th>주문자명</th>
						<td>${output2.userName}</td>				
					</tr>
					<tr>
						<th>받는 분&nbsp;&nbsp;</th>
						<td>${output2.receiver}</td>				
					</tr>
					<tr>
						<th>주문일시</th>
						<td>${output2.regDate}</td>				
					</tr>
					<tr>
						<th>배송정보</th>
						<td>${output2.address}&nbsp;${output2.detailAddress}&nbsp;${output2.extraAddress}</td>				
					</tr>
					<tr>
						<th>배송메모</th>
						<td>${output2.memo}</td>				
					</tr>
					<tr>
						<th>주문상태</th>
						<td>${output2.status}</td>				
					</tr>
				</tbody>
			</table>
				
			<!-- 결제 정보 -->
			<h3 class="pay_info"><strong>결제 정보</strong></h3>
			<table class="pay_table">
				<tbody>
					<colgroup>
						<col style="width: 15%">
						<col style="width: 85%">
					</colgroup>
					<tr>
						<th>결제금액</th>
						<td><fmt:formatNumber value="${output2.totalPrice}" pattern="#,###" />원</td>
					</tr>
					<tr>
						<th>결제방법</th>
						<td>${output2.orderPay}</td>				
					</tr>
					<tr>
						<th>결제일시</th>
						<td>${output2.regDate}</td>				
					</tr>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>		
	
	<br />
	<br />
	
	<c:choose>
	<%-- 조회결과가 없는 경우 --%>
	   	<c:when test="${output1 == null || output2 == null}">
	   		<div class="product-item col-md-3 col-sm-6 col-xs-12" style="min-height: 600px;">

	   		</div>
	   	</c:when>
	   	<c:otherwise>
			<!-- 전체 상품 주문 취소 버튼  -->
			<div id="hide_btn" class="text-center">
				<a href="${pageContext.request.contextPath}/mypage/order.do">
				    <button type="button" class="btn btn-order">
			        	전체 주문내역
			        </button>
		        </a>
		    </div>
		    <br />
		    <br />
    	</c:otherwise>
    </c:choose>
    
</div> <!--  container order_contents -->
<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- 개발자가 구현하는 스크립트 블록 -->
<script type="text/javascript">

$(function() {
	
	//jQuery Ajax가 restful을 처리할 수 있도록 기능 확장.
	// ajax-helerp.js에 추가했지만 인식이 안돼서 여기에 넣음.
	jQuery.each([ "put", "delete" ], function(i, method) {
	    jQuery[method] = function(url, data, callback, type) {
	        if (jQuery.isFunction(data)) {
	            type = type || callback;
	            callback = data;
	            data = undefined;
	        }

	        return jQuery.ajax({
	            url : url,
	            type : method,
	            dataType : type,
	            data : data,
	            success : callback
	        });
	    };
	});
	
	$("#order_delete").click( function(e) {
		e.preventDefault();
	    swal({
	        title: "확인",
	        text: "주문을 취소하시겠습니까?",
	        type: "question",
	        confirmButtonText: "확인",
	        showCancelButton: true,
	        cancelButtonText: "취소",
	     }).then(function(result) {
	        if (result.value) {
	        	
	        	var id = $(".order_id").val();
	        	console.log(id);
	        	
	        	// delete 메서드로 Ajax 요청 --> <form> 전송이 아니므로 직접 구현한다.
	        	$.delete("${pageContext.request.contextPath}/mypage/order-detail.do", {
	        		"id": id
	        	});
	        	
	        	swal({
					title : "주문취소가 완료되었습니다.", 				// 제목
					html : "", 												// 내용
					type : "success", 									// 종류
					confirmButton : true, 							// 확인버튼 표시여부
					confirmButtonText : "확인", 					// 확인버튼표시문구		
				}).then(function(){
					window.location.href = "${pageContext.request.contextPath}/mypage/order.do";})		// DB에서 삭제하고 완료되면 이동시키기.
	        	} 
	     });
	});
});

</script>			


<%@ include file="../_inc/footer.jsp"%>
