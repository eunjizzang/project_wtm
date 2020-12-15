<%
/**
* @filename : order-complete.jsp
* @description : --- 주문완료 페이지 ---
*						 장바구니(cart.jsp) -> 주문(order-form.jsp) -> 주문완료(order-complete.jsp)
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/order-complete.css">

<style type="text/css">
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container contents" style="min-height: 600px;">

    <div class="com_box">
        <div class="img_box">
            <img src="<%=request.getContextPath()%>/assets/img/tick.png" class="tick_img" />
        </div> <!-- img_box -->
        
        <div class="text_box">
            <strong style="font-size: 25px;">고객님의 주문이 완료되었습니다.</strong>
            <br />
            <br />
            <p>주문내역 확인은 마이페이지의 <a href="${pageContext.request.contextPath}/mypage/order.do">주문내역</a>에서 확인 가능합니다.</p>
	            <p><strong>주문번호:&nbsp;</strong>${output.id}</p>
	            <p><strong>주문일자:&nbsp;</strong>${output.orderDate}</p>
        </div> <!-- text_box -->
        
    </div> <!-- com_box -->
    
    <!-- 버튼  -->
    <div id="two_btn" class="two_btn">
        <a href="${pageContext.request.contextPath}/shop">
            <button type="button" class="btn btn-shop btn-warning">
                쇼핑계속하기
            </button>
        </a>
        <a href="${pageContext.request.contextPath}/mypage/order.do">
            <button type="button" class="btn btn-order">
                주문확인하기
            </button>
        </a>
    </div>
   
    <br />
    <br />
</div> <!-- container contents -->
<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- 개발자가 구현하는 스크립트 블록 -->
<script type="text/javascript">

</script>
<%@ include file="../_inc/footer.jsp"%>
