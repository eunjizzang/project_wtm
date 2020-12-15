<%
/**
* @filename : shop-detail.jsp
* @description : --- 쇼핑몰 상세 페이지 ---
				- 이미지  ~ 구매하기&장바구니까지 블럭 (.row)
				- 탭 종류 (.product-content > ul & .tab-content )
							
				1) 상세정보(#content_detail)
				2) 스펙(#content_spec)
				3) 배송정보(#content_delivery)
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/shop-detail.css">
	
<style type="text/css"> 
</style>
	
<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container product-detail" data-pid="001" style="min-height: 600px;">
<form id="go" method="post" action="${pageContext.request.contextPath}/shop/rest/cart.do">
	<input type="hidden" id ="userId" name="userId" value="${memInfo.userId}" />
	<input type="hidden" id ="productId" name="productId" value="${output.id}" />
	<input type="hidden" id="productName" name="productName" value="${output.name}" />
	<input type="hidden" id="productImg" name="productImg" value="${output.img}" />
	<input type="hidden" id ="productPrice" name="productPrice" value="${output.price}" />
    <div class="row">
        <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12">
            <img src="${output.img}" width="100%" class="title-img" style="width: 520px"/>
        </div>
        <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12 product-info-container">
            <div class="visible-md visible-lg detail-title">
                <div class="page-header">
                    <h2>${output.name}</h2>
                </div>
                <p>${output.eng}</p>
            </div>
            <dl class="row product-option-info product-price">
                <dt class="col-xs-3 col-sm-4">
                    <span>판매가격</span>
                </dt>
                <dd class="col-xs-9 col-sm-8">
                    <span class="price real-price" data-value="${output.price}">
                        <fmt:formatNumber value="${output.price}" pattern="#,###" />
                                원
                    </span>
                </dd>
            </dl>
            <dl class="row product-option-info product-option-tmpl mb0">
                <dt class="col-xs-4 col-sm-4 product-option-qty" style="padding-top: 5px;">
                    <span>수량</span>
                </dt>
                <dd class="col-xs-5 input-up-down">
                    <div class="input-group input-group-sm">
                        <input type="num" class="form-control qty" value="${output.qty}" min="1" style="ime-mode: disabled; vertical-align: middle" readonly />
                        <span class="input-group-btn">
                            <a href="#" class="qty-up btn btn-success"><i class="fa fa-caret-up"></i></a>
                        </span>
                        <span class="input-group-btn">
                            <a href="#" class="qty-down btn btn-success"><i class="fa fa-caret-down"></i></a>
                        </span>
                    </div>
                </dd>
            </dl>
            <dl class="row product-option-info" style="margin-bottom: 10px;">
            	<dt class="col-xs-4 col-sm-4 product-option-qty">
            		<span>배송비</span>
            	</dt>
            	<dd class="col-xs-9 col-sm-8">
            		무료
            	</dd>
            </dl>
            <div class="panel">
                <div class="panel-body text-right">
                    총 구매금액 
                    <strong class="text-danger total-price" data-value="${output.price}">
                  		<fmt:formatNumber value="${output.price}" pattern="#,###" />
                    </strong>원
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <a href="<%=request.getContextPath()%>/shop/order-form.do">
                        <button type="submit" class="btn btn-block btn_order" id="btn_order" style="height: 34px">
                            <i class="fa fa-shopping-bag"></i>
                            주문하기
                        </button>
                    </a>
                </div>
                <div class="col-xs-12">
                    <button type="submit" class="btn btn-block btn-success btn_cart" id="btn_cart">
                        <i class="fa fa-cart-arrow-down"></i>
                        장바구니
                    </button>
                </div>
            </div> <!-- row -->
        </div> <!-- col-lg-5 col-md-5 col-sm-12 col-xs-12 product-info-container -->
    </div> <!-- row -->
    </form>
    
    <!-- 전체 탭 블록 -->
    <div class="product-content">
        <ul class="nav nav-tabs nav-justified">
            <li role="presentation" class="active">
                <a href="#content_detail" data-toggle="tab">상세정보</a>
            </li>
            <li role="presentation">
                <a href="#content_spec" data-toggle="tab">스펙</a>
            </li>
            <li role="presentation">
                <a href="#content_delivery" data-toggle="tab">배송안내</a>
            </li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
            <!-- 상세정보 -->
            <div class="tab-pane fade active in" id="content_detail">
            	
            	<br />
                <br />
                <br />
                <br />
            	
            	<img src="<%=request.getContextPath()%>/assets/img/content_detail.png" class="img_content_detail" />
            	
            	<br />
                <br />
                <br />
                <br />
                
                ${output.desc}
                
            </div> <!-- tab-pane fade in active -->
            <br />
            <br />
            
            <!-- 스펙 탭 -->
            <div class="tab-pane" id="content_spec">
            
                <br />
                <br />
                
                ${output.spec}
                
            </div>
            
            <!-- 배송안내 탭 -->
            <div class="tab-pane" id="content_delivery" class="content_delivery">
            
                <br />
                <br />
                
                <div>
                    <img src="<%=request.getContextPath()%>/assets/img/delivery-info.png" />
                    <div class='delivery_info'>
                    
                        <br />
                        <br />
                        <br />
                        
                        ${output.delivery}
                        
                    </div>
                </div>
            </div> <!-- tab-pane -->
            <br />
            <br />
                
        </div> <!-- tab-content -->
    </div><!-- product-content -->
</div><!-- container product-detail -->    
<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- 개발자가 구현하는 스크립트 블록 -->
<script type="text/javascript">

$(function() {
	/** 금액 콤마 정규표현식 **/
	function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	/** 수량 증가 버튼 - 99이하만 가능 **/
	$(".qty-up").click(function(e) {									// up을 클릭할 때마다 
      	var num = $(".qty").val();											// 개수의 값을 가져옴.
      	var plusNum = ++num;												// 개수 1씩 증가.
      	
      	if (plusNum > 99) {							
      		return;
      	}
      	else {																		// 99이하만 가능
      	$(".qty").val(plusNum);												// 개수에 증가한 값을 저장.
     	var price = $(".real-price").attr("data-value");      	// 금액 값을 가져옴.
      	var sum = Number(price) * plusNum;						// 금액 숫자로 환산해서 
      	$(".total-price").html(numberWithCommas(sum));	// 총 구매금액에 출력.
      	$(".total-price").attr("data-value", sum);					// 총 구매금액의 data-value에 값 저장.
      	}
	});
      
	/** 수량 감소 버튼 - 1이상만 가능**/
	$(".qty-down").click(function(e) {								// down을 클릭할 때마다
    var num = $(".qty").val();												// 개수의 값을 가져옴.
    var minusNum = --num;												// 개수 1씩 감소.
       
    if (minusNum < 1) {
        return;
	}
	else {																			// 1이상만 가능
		$(".qty").val(minusNum);											// 개수에 증가한 값을 저장.
        var price = $(".real-price").attr("data-value");      	// 금액 값을 가져옴.
        var sum = Number(price) * minusNum;					// 금액 숫자로 환산해서
        $(".total-price").html(numberWithCommas(sum));	// 총 구매금액에 출력.
      	$(".total-price").attr("data-value", sum);					// 총 구매금액의 data-value에 값 저장.
	}
	});     
	
	// jQuery Ajax가 restful을 처리할 수 있도록 기능 확장.
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
	    }
	});
	
	/** 주문하기 버튼 **/
	$("#btn_order").click(function(e) {
		e.preventDefault();
		
		console.log($("#userId").val());
		
		if ($("#userId").val() == null || $("#userId").val() =="") {
			swal({
	            title: "로그인후 이용하실 수 있는 <br /> 서비스입니다.",
	            text: "",
	            type: "error",
	            confirmButtonText: "확인",
	            showCancelButton: true,
	            cancelButtonText: "취소",
	         }).then(function(result) {
	            if (result.value) {
	               window.location.href = "${pageContext.request.contextPath}/login.do";
	            }
	         });	
        } else {
        	swal({
			title: "확인",
		    text: "선택하신 상품을 주문하시겠습니까?",
		    type: "question",
		    confirmButtonText: "확인",
		    showCancelButton: true,
		    cancelButtonText: "취소",
		}).then(function(result) {
			if (result.value) {

				// 기존 장바구니 비움
				$.delete("${pageContext.request.contextPath}/shop/rest/cart.do");
				
				var id = $("#productId").val();
		 		var name = $("#productName").val();
		 		var img = $("#productImg").val();
				var qty = $(".qty").val();
				var price = $("#productPrice").val();
				var total = qty * price;
				
				// 현 페이지의 상품 데이터 장바구니에 저장
				$.post("${pageContext.request.contextPath}/shop/rest/cart.do",
						{"product_id": id,
						"name": name,
						"img": img,
						"qty": qty,
						"c_price": total
						}, function(json) {
							swal({
								title : "주문페이지로 이동합니다.", 			
								html : "", 										
								type : "success", 								
								confirmButton : true, 				
								confirmButtonText : "확인", 	
							}).then(function() {
								window.location.href = "${pageContext.request.contextPath}/shop/order-form.do";			
							});
						});
					}
			});
        }
	});
	
	/** 장바구니 버튼 **/
	$("#btn_cart").click(function(e) {
		e.preventDefault();
		
 		var id = $("#productId").val();
 		var name = $("#productName").val();
 		var img = $("#productImg").val();
		var qty = $(".qty").val();
		var price = $("#productPrice").val();
		var total = qty * price;
		
		// 현 페이지의 상품 데이터 장바구니에 저장
		$.post("${pageContext.request.contextPath}/shop/rest/cart.do",
				{"product_id": id,
				"name": name,
				"img": img,
				"qty": qty,
				"c_price": total
				}, function(json) {
			        swal({
			            title: "성공",
			            text: "장바구니에 상품이 담겼습니다. 확인하시겠습니까?",
			            type: "success",
			            confirmButtonText: "확인",
			            showCancelButton: true,
			            cancelButtonText: "취소",
			         }).then(function(result) {
			            if (result.value) {
			               	window.location.href = "${pageContext.request.contextPath}/shop/cart.do";
            		}
         	  });
		  })
	});
});

</script>
<%@ include file="../_inc/footer.jsp"%>
