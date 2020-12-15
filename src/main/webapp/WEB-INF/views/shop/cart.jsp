<%
/**
* @filename : cart.jsp
* @description : --- 장바구니 페이지 ---
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/cart.css">

<style type="text/css">
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container" style="min-height: 600px;">
    <div class="row">
        <div class="col-md-12">
            <div class="page-header">
                <h2><img src="<%=request.getContextPath()%>/assets/img/supermarket.png" class="cart_img" style="width:50px"><strong>&nbsp;장바구니</strong></h2>
            </div>
            
            <c:choose>
            	<%-- 조회결과가 없는 경우 --%>
				<c:when test="${output == null || fn:length(output) == 0}">
	    			<table class="table show_table">
	    				<colgroup>
		                	<col style="width: 4%">
		                    <col style="width: 12%">
		                    <col style="width: 41%">
		                    <col style="width: 8%">
		                    <col style="width: 13%">
		                    <col style="width: 10%">
		                    <col style="width: 12%">
		                </colgroup>
						<thead>
						    <tr style="background-color: #e8f0fa;">
						        <th class="text-center"><input type="checkbox" name="all_check" id="all_check" checked /></th>
						        <th class="text-center" colspan="2">주문상품정보</th>
						        <th class="text-center">단가</th>
						        <th class="text-center">수량</th>
						        <th class="text-center">합계</th>
						        <th class="text-center">삭제</th>
						    </tr>
						</thead>
						<tbody>
						    <tr class="hide_table" style="height: 100px;">
						        <td class="text-center" colspan="7">
						            장바구니가 비었습니다.
						        </td>
						    </tr>
						    <tr class="hide_table" style="background-color: #f0f4f769;">
						        <td colspan="5">
						        </td>
						        <th class="text-center">
						            총 결제금액
						        </th>
						        <td class="text-center">
						            <strong class="text-warning">0원</strong>
						        </td>
						    </tr>
						    <!-- 안내 문구 -->
						    <tr class="info_text" style="background-color: #fcf8e370;">
						        <td colspan="7">
						            <i class="fas fa-info-circle" style="color: tomato"></i>&nbsp;장바구니에 담긴 상품은 한달간 보관됩니다. 
						        </td>
						    </tr>
						</tbody>
					</table>		     
					
					<!-- 버튼 -->
		            <div class="text-right">
		            	<button type="button" class="btn btn-hide btn-all-delete btn-warning">
		                   	장바구니 비우기
		                </button>
		                <button type="submit" class="btn btn-hide btn-order">
		                        선택항목 주문하기
		                </button>
		        	</div>
				</c:when>
				
    			
    			<%-- 조회결과가 있는 경우 --%>
	            <c:otherwise>
		                <table class="table hide_table">
		                    <colgroup>
		                        <col style="width: 4%">
		                        <col style="width: 12%">
		                        <col style="width: 41%">
		                        <col style="width: 8%">
		                        <col style="width: 13%">
		                        <col style="width: 10%">
		                        <col style="width: 12%">
		                    </colgroup>
		                    <thead>
		                        <tr style="background-color: #e8f0fa;">
		                            <th class="text-center"><input type="checkbox" name="all_check" id="all_check" checked /></th>
		                            <th class="text-center" colspan="2">주문상품정보</th>
		                            <th class="text-center">단가</th>
		                            <th class="text-center">수량</th>
		                            <th class="text-center">합계</th>
		                            <th class="text-center">삭제</th>
		                        </tr>
		                    </thead>
		                    
		                    <c:forEach var="item" items="${output}" varStatus="status">
			                    <tbody class="hide_table">
			                        <tr class="cart-item cart-item-${item.id}" data-id="${item.id}" style="height: 80px;">
			                            <td class="text-center">
			                                <input type="checkbox" name="cart_id[]" class="cart_id productId" value="${item.productId}" checked />
			                                <input type="hidden" class ="cartId" name="cartId" value="${item.id}" />
			                                <input type="hidden" id ="userId" name="userId" value="${memInfo.userId}" />
			                                <input type="hidden" class="productImg" name="productImg" value="${item.img}" />
					                    	<input type="hidden" class="productName" name="productName" value="${item.name}" />
					                    	<input type="hidden" class="productPrice" name="productPrice" value="${item.price1}" />
			                            </td>
			                            <td class="text-center">
			                                <a href="${pageContext.request.contextPath}/shop/shop-detail.do?id=${item.productId}">
			                                    <img src="${item.img}" width="50" />
			                                </a>
			                            </td>
			                            <td class="text-center name">
			                                <a href="${pageContext.request.contextPath}/shop/shop-detail.do?id=${item.productId}">
			                                	${item.name}
			                                </a>
			                            </td>
			                            <td class="text-center" style="padding-left: 0; padding-right: 0" >
			                                <span class="real-price" data-value="${item.price1}">
			                                    <fmt:formatNumber value="${item.price1}" pattern="#,###" />
                                					원
			                                </span>
			                            </td>
			                            <td class="text-center count-qty">
			                                <dd class="input-up-down">
			                                    <div class="input-group num_group">
			                                        <span class="input-group-btn">
			                                            <a href="#" class="qty-down btn btn-success"><i class="fa fa-caret-down"></i></a>
			                                        </span>
			                                        <input type="num" name="productQty" class="form-control qty productQty" value="${item.qty}" min="1" style="ime-mode: disabled; vertical-align: middle" readonly>
			                                        <span class="input-group-btn">
			                                            <a href="#" class="qty-up btn btn-success"><i class="fa fa-caret-up"></i></a>
			                                        </span>
			                                    </div> <!-- num_group -->
			                                </dd>
			                            </td>
			                            <td class="text-center">
			                                <strong class="text-warning">
			                                	<span class="total-price" data-value="${item.price2}">
			                                        <fmt:formatNumber value="${item.price2}" pattern="#,###" />
			                                    </span>
                                					원
                                			</strong>
			                            </td>
			                            <td class="text-center">
			                                <button class="btn-delete btn" data-cart-id="001" data-product-name="얼라이브 원스데일리 종합비타민 남성 ＆ 여성세트">
			                                    <i class="fas fa-times fa-2x"></i>
			                                </button>
			                            </td>
			                        </tr>
			                        </c:forEach>
			                        
			                        <!-- 최종 결제금액 -->
			                        <tr class="total" style="background-color: #f0f4f769;">
			                            <td colspan="5">
			                            </td>
			                            <th class="text-center">
			                                	총 결제금액
			                            </th>
			                            <td class="text-center">
			                                <strong class="text-warning">
			                                	<span class="order-price">
			                                    </span>원
			                            	</strong>
			                            </td>
			                        </tr>
			                        <!-- 안내 문구 -->
								    <tr class="info_text" style="background-color: #fcf8e370;">
								        <td colspan="7">
								            <i class="fas fa-info-circle" style="color: tomato"></i>&nbsp;장바구니에 담긴 상품은 한달간 보관됩니다. 
								        </td>
								    </tr>
			                    </tbody>
		                </table>
		                
		                <!-- 버튼 -->
		                <div class="text-right">
		                    <button type="button" class="btn btn-hide btn-all-delete btn-warning">
		                        장바구니 비우기
		                    </button>
		                    <button type="submit" class="btn btn-hide btn-order">
		                        선택항목 주문하기
		                    </button>
		                </div>
		        	
	            </c:otherwise>
            </c:choose>
        </div> <!-- col-md-12 -->
    </div> <!-- row -->
    
    <!-- 기본 숨김처리 => '장바구니 비우기'버튼 클릭시, 뜨는 '쇼핑하러가기 버튼' -->
    <div id="show_btn" class="text-center">
        <a href="<%=request.getContextPath()%>/shop">
            <button type="button" class="btn btn-success btn-shop">
                쇼핑하러 가기
            </button>
        </a>
    </div> <!-- text-center -->
    
</div> <!-- container -->
<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- 개발자가 구현하는 스크립트 블록 -->
<script type="text/javascript">

$(function() {

	/** 총 결제금액 계산 함수 정의 **/
	function total() {
		var ch = $(".cart_id:checked");
		var total = 0;		// 합계 초기값
		
		if (ch.length != 0) {			// 체크된 개수가 0이 아니라면
			for (var i=0; i<ch.length; i++) {			//체크된 길이만큼 반복문돌면서
				var price = Number(ch.eq(i).parents(".cart-item").find(".total-price").attr("data-value"))		// 행의 합계의 값을 찾아 숫자로 변환하고 
				total += price;			// 체크된 값 더함
			}
			$(".order-price").html(numberWithCommas(total));		// 총 결제금액에 total 값을 출력함
		}	else {
			$(".order-price").html(0);	// 개수가 0이면 총 결제금액에 0을 출력함
		}
	}			
	
	/** 장바구니 조회시, 총 결제금액 자동 계산 */ 
	$(document).ready(function(){                                                 
		total();
  	});
	
	/** 체크박스 하나라도 풀면 전체선택 체크박스 해제 **/
	$(".cart_id").click(function(){							// 체크박스 하나라도 클릭했을 떄
		$("#all_check").prop("checked", false);		// 전체선택 체크박스가 해제된다.
		total();															// 합계 계산
	});
	
	/** 전체선택 선택 및 해제 **/
    $("#all_check").change(function() {				// 전체선택 체크박스가 변화할 때
        $(".cart_id").prop("checked", $(this).prop("checked"));		// 체크박스의 체크가 선택/ 해제 변경
        total();															// 합계 계산
    });
	
	/** 체크박스 다 체크시 전체선택 체크 **/
	$(".cart_id").click(function() {						// 체크박스를 클릭했을 때
	    var len = $(".cart_id:checked").length;		// 체크박스의 체크된 개수
	    var total_len = $(".cart_id").length;				// 체크박스의 개수

	    if	(len == total_len)	{ 									// 체크박스의 체크된 개수와 체크박스의 개수가 같다면					
	       $("#all_check").prop('checked', true);		// 전체선택 체크박스가 체크된다.
	    }	else { 														// 아니면
	       $("#all_check").prop('checked', false);   // 전체선택 체크박스가 해제된다.
	    }
	});
	
	/** 금액 콤마 정규표현식 **/
	function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	/** 수량 증가 버튼 - 99이하만 가능 **/
	$(".qty-up").click(function(e) {
		var num = $(this).parents(".input-group-btn").prev().val();		// 숫자 입력창의 값을 찾음.
      	var plusNum = ++num;																// up을 클릭할 때마다 1씩 더함.
      	$(this).parents(".input-group-btn").prev().val(plusNum);			// 다시 숫자 입력창에 더해진 개수 값을 넣어줌.
      	
      	if (plusNum > 99) {																	// 99이하만 가능
      		return;												
      	}	else {     
    		/** price는 ".real-price" 상품 단가를 가리킴 **/					
	     	var price = $(this).parents(".count-qty").prev().find(".real-price").attr("data-value");      		// 상품단가의 값을 가져옴.
	      	var sum = Number(price) * plusNum;																						// 상품단가를 숫자로 변환해서 증가한 개수를 곱함.
	      	$(this).parents(".count-qty").next().find(".total-price").html(numberWithCommas(sum));		// 합계에 sum을 출력.
	      	$(this).parents(".count-qty").next().find(".total-price").attr("data-value", sum);						// 합계 data-value속성에 값 저장.
	      	total();																																		// 합계 계산
      	}
	});
      
	/** 수량 감소 버튼  - 1이상만 가능**/
	$(".qty-down").click(function(e) {
		var num = $(this).parents(".input-group-btn").next().val();		// 숫자 입력창의 값을 찾음.
	    var minusNum = --num;																// down을 클릭할 때마다 1씩 감소.
	       
	    if (minusNum < 1) {																	// 1이상만 가능
	        return;
		}	else {																									
			$(this).parents(".input-group-btn").next().val(minusNum);														// 다시 숫자 입력창에 감소한 개수 값을 넣어줌.
		    var price = $(this).parents(".count-qty").prev().find(".real-price").attr("data-value"); 			// 상품단가의 값을 가져옴.
		    var sum = Number(price) * minusNum;																						// 상품단가를 숫자로 변환해서 감소한 개수를 곱함.
		    $(this).parents(".count-qty").next().find(".total-price").html(numberWithCommas(sum));		// 합계에  sum을 출력.
		    $(this).parents(".count-qty").next().find(".total-price").attr("data-value", sum);						// 합계 data-value속성에 값 저장.
		    total();																																		// 합계 계산
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
	
	/** 개별 삭제 버튼(X 아이콘) **/
	$(".btn-delete").click(function(e) {
		e.preventDefault();
		
		var id = $(this).parents(".cart-item");
		id.remove();
		total();
		
		// cart.id(장바구니 일련번호)를 기준으로 삭제행
		$.delete("${pageContext.request.contextPath}/shop/rest/cart.do", {
				"id": id.attr("data-id")
		});
	});  
	 	
	/** 전체 삭제 버튼 -> 테이블과 버튼 삭제 -> 쇼핑하러가기 버튼 show **/
	$(".btn-all-delete").click(function(e) {
		e.preventDefault();
		var order_check = $(".cart_id:checked");
		if (order_check.length == 0) {
			swal({
				title: "삭제할 상품이 없습니다.",
			    text: "",
			    type: "error",
			    confirmButtonText: "확인",
			    confirmButton : true, 			
				confirmButtonText : "확인"	
			});
			return;
		} else {
		swal({
			title: "확인",
		    text: "장바구니를 비우시겠습니까?",
		    type: "question",
		    confirmButtonText: "확인",
		    showCancelButton: true,
		    cancelButtonText: "취소",
		}).then(function(result) {
			if (result.value) {
				
				// member.id(회원 일련번호)를 기준으로 장바구니 삭제행
				$.delete("${pageContext.request.contextPath}/shop/rest/cart.do");
				
				swal({
					title : "성공", 		
					html : "장바구니가 성공적으로 비워졌습니다.", 										
					type : "success", 						
					confirmButton : true, 			
					confirmButtonText : "확인"	
				});				
				$(".hide_table").remove(); 
				$(".btn-hide").remove();
				$(".show_table").show();
				$("#show_btn").show();
				}
			});
		}
	});
	
	/** 주문하기 버튼 **/
	$(".btn-order").click(function(e) {
		e.preventDefault();
		var order_check = $(".cart_id:checked");
		if (order_check.length == 0) {
			swal ("상품을 선택해주세요.", "", "error");
			return;
		} else {
			
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
					
					// 1) 체크 안된 값 --> 삭제행
					var nc = $(".cart_id:not(:checked)");
					
					if (nc.length >0 ) {								// 체크 안된 값이 존재한다면
						for (var i=0; i<nc.length; i++) {          //체크 안된 길이만큼 반복문돌면서
							
							// 체크안된 cart.id값 기준으로 delete!
							var id =  nc.eq(i).parents(".cart-item").find(".cartId").val();		
						
							$.delete("${pageContext.request.contextPath}/shop/rest/cart.do", {"id": id});
						}
					}
					
					// 2) 체크된 값 --> 수정행
					var ch = $(".cart_id:checked");
					
					for (var i=0; i<ch.length; i++) {				//체크된 길이만큼 반복문돌면서
						
						// 체크된 cart.id값 기준으로 수량, 가격 update!
						var id =  ch.eq(i).parents(".cart-item").find(".cartId").val();
						var qty = ch.eq(i).parents(".cart-item").find(".productQty").val();
						var c_price = ch.eq(i).parents(".cart-item").find(".total-price").attr("data-value");
							
						$.post("${pageContext.request.contextPath}/shop/rest/order-ok.do", {"id": id, "qty": qty, "c_price": c_price}, function(json) {
							swal({
								title : "주문페이지로 이동합니다.", 			
								html : "", 										
								type : "success", 								
								confirmButton : true, 				
								confirmButtonText : "확인", 	
								}).then(function() {
									$("#cart-form").submit();
				        			window.location.href = "${pageContext.request.contextPath}/shop/order-form.do";			
								});
							});
					 	}
					}
		        });
			}
		}
	});	
});	

</script>
<%@ include file="../_inc/footer.jsp"%>
