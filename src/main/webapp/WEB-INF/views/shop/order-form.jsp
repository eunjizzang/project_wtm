<%
/**
* @filename : order-form.jsp
* @description : --- 주문서 작성 페이지 ---
*							장바구니(cart.jsp) -> 주문(order-form.jsp) -> 주문완료(order-complete.jsp)
*							1) page-header - 제목
*							2) form						
*								1) table - 장바구니에서 가져온 상품목록								
*								2) left_right
*									1) fieldset <left>					
*										1) orderer - 주문자 정보 입력 박스
*										2)	receiver - 받는사람 정보 입력 박스
*										3) payment 
*									2) right
*								3) payment_info
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/order-form.css">

<style type="text/css">
</style>
    
<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container order_contents" style="min-height: 600px;">
	<div class="page-header">
		<h2><img src="<%=request.getContextPath()%>/assets/img/pen.png" class="pen_img" style="width:50px" ><strong>&nbsp;주문서 작성</strong></h2>
	</div> <!-- page-header -->
		
	<form id="order-form" class="form-horizontal" method="post" action="${pageContext.request.contextPath}/shop/rest/order-complete.do">
	
		<!-- 반복문 -> order테이블의 prod_info컬럼에 JSON으로 담을 것임! -->
		<div style="display: none">
			<table>
				<c:forEach var="item" items="${output}" varStatus="status">
					    <tbody class="hide_table">
					        <tr class="cart-item1" style="height: 80px;">
					            <td class="text-center">
					                <input type="checkbox" class="cart_id productId" value="${item.productId}" checked />
					                <input type="hidden" class="productImg" value="${item.img}" />
					                <input type="hidden" class="productName" value="${item.name}" />
					                <input type="hidden" class="productPrice" value="${item.price1}" />
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
					            <td class="text-center" style="padding-left: 0; padding-right: 0">
					                <span class="total-price1" data-value="${item.price2}"></span>
					            </td>
					            <td class="text-center count-qty">
					                <dd class="input-up-down">
					                    <div class="input-group num_group">
					                        <span class="input-group-btn">
					                            <a href="#" class="qty-down btn btn-success"><i class="fa fa-caret-down"></i></a>
					                        </span>
					                        <input type="num" name="productQty" class="form-control qty productQty1" value="${item.qty}" min="1" style="ime-mode: disabled; vertical-align: middle" readonly>
					                        <span class="input-group-btn">
					                            <a href="#" class="qty-up btn btn-success"><i class="fa fa-caret-up"></i></a>
					                        </span>
					                    </div> <!-- num_group -->
					                </dd>
					            </td>
					        </tr>
						</tbody>
					</c:forEach>
			</table>
		</div>

		<h3 style="margin-bottom: 25px;">01. 상품 주문내역</h3>
		<table class='table'>
		    <colgroup>
		        <col style="width: 10%">
		        <col style="width: 48%">
		        <col style="width: 15%">
		        <col style="width: 12%">
		        <col style="width: 15%">
		    </colgroup>
		    
		    <thead>
		        <tr style="background-color: #e8f0fa;">
		            <th class='text-center' colspan="2">주문상품정보</th>
		            <th class='text-center'>단가</th>
		            <th class='text-center'>수량</th>
		            <th class='text-center'>합계</th>
		        </tr>
		    </thead>
		    
		    <!-- 카트  -->
		    <c:forEach var="item" items="${output}" varStatus="status">
				    <tr class="cart-item" data-id="${item.productId}" style="height: 80px;">
				        <td class="text-center">
				            <a href="${pageContext.request.contextPath}/shop/shop-detail.do?id=${item.productId}">
				                <img src="${item.img}" width="50" />
				            </a>
				        </td>
				        <td class="text-center item_name shop-comment">
				            <a href="${pageContext.request.contextPath}/shop/shop-detail.do?id=${item.productId}">
				                ${item.name}
				            </a>
				        </td>
				        <td class="text-center shop-comment" style="padding-left: 0; padding-right: 0">
				            <span class="real-price">
				                <fmt:formatNumber value="${item.price1}" pattern="#,###" />
				                원
				            </span>
				        </td>
				        <td class="text-center shop-comment">
				        	${item.qty}
				        </td>
				        <td class="text-center shop-comment">
				            <strong class="text-warning">
				                <span class="total-price" data-value="${item.price2}">
				                    <fmt:formatNumber value="${item.price2}" pattern="#,###" />
				                </span>
				                원
				            </strong>
				        </td>
				    </tr>
		    </c:forEach>
		    
			    <!-- 최종 결제금액 -->
			    <tr class="total" style="background-color: #f0f4f769;">
			        <td></td>
			        <td></td>
			        <td></td>
			        <th class="text-center">
			            총 결제금액
			        </th>
			        <td class="text-center">
			            <strong class="text-warning"><span class="total-price2" data-value="">
			            <fmt:formatNumber value="" pattern="#,###" />
			                    </span>원</strong>
			        </td>
			    </tr>
		    
		    <!-- 안내 문구 -->
		    <tr class="info_text" style="background-color: #fcf8e370;">
		        <td colspan="5">
		            <i class="fas fa-info-circle" style="color: tomato"></i>&nbsp;상품의 옵션 및 수량 변경은 장바구니에서 가능합니다.
		        </td>
		    </tr>
		</table>
		
		<div class="left_right">
			<fieldset class="left">
				<div class="orderer">
					<h3>02. 주문자 정보</h3>
					<hr />
					<c:forEach begin="0" end="0" var="item2" items="${output2}" varStatus="status">
					<div class="form-group">
						<label for="user_name" class="">이름</label>
						<input type="text" value="${item2.name2}" id="user_name" class="form-control validate-input" autocomplete="off" style="margin-left: 50px;" readonly>
					</div>
					<br />
					<div class="form-group">
						<label for="tel" class="">핸드폰번호</label>
						<input type="tel" value="${item2.tel}" id="tel" class="form-control validate-input" onkeyup="inputHyphen(this);" style="margin-left:7px;" readonly>
					</div>		
					<br />
					<div class="form-group">
						<label for="email" class="">이메일</label>
						<input type="email" value="${item2.email}" id="email" class="form-control validate-input" style="margin-left:34px;" readonly>
					</div>		
						<input type="hidden" value="${item2.postcode}" id="postcode1">
						<input type="hidden" value="${item2.address}" id="address1">
						<input type="hidden" value="${item2.detail_address}" id="detail_address1">
					<br />					
					</c:forEach>
				</div>	<!--  orderer -->
				<br />
				
				<div class="receiver">
					<h3 class="h3_check">03. 배송 정보</h3>&nbsp;&nbsp; 
					<input type="checkbox" name="same" id="orderer_same" value="same" style="margin-left: 340px;"  />
                	<label for="orderer_same">주문자 정보와 동일</label>
					<hr />
					<div class="form-group">
						<label for="user_name" class="">이름</label>
						<input type="text" name="user_name" id="user_name2" class="form-control validate-input" autocomplete="off" style="margin-left: 50px;" >
					</div>
					<br />
					<div class="form-group">
						<label for="tel" class="">핸드폰번호</label>
						<input type="tel" name="tel" id="tel2" class="form-control validate-input" onkeyup="inputHyphen(this);" style="margin-left:7px;"  onkeydown="return isNumberKeyDown(event);" style="ime-mode:disabled">
					</div>		
					<br />
					<div class="form-group"> <!-- (필수!) 우편번호입력창+검색버튼 -->
						<label for="address" class="">주소</label>
						<div class="input-group">
							<input type="text" name="postcode" class="form-control validate-input" id="postcode" placeholder="㉾" maxlength="5" style="width: 82px; margin-left:49px;" readonly>
							<button type="button" id="postcode-btn" class="btn btn-info postcode-finder" onclick="execDaumPostcode()"
								data-postcode="#postcode" data-addr1="#addr1" data-addr2="#addr2" data-frame="#postcode-frame" style="width: 118px;">우편번호검색</button>
						</div>
					</div>
					<div class="form-group naran"> <!-- (필수!) 주소입력창 -->
						<input type="text"	id="address" name="address" class="form-control findAdd2 validate-input" placeholder="주소" style="margin-left:81px;" >
					</div>
					<div class="form-group naran" style="margin-left: -4px;"> <!-- (필수!) 상세주소입력창(사용자 입력부분) -->
						<input type="text"	id="detailAddress" name="detail_address"	class="form-control findAdd3 validate-input" placeholder="&nbsp; 상세주소" style="padding-left: 0;">			
					</div>
					<div class="form-group"> <!-- 참고항목+주의사항 -->
						<input type="text" id="extraAddress" name="extra_address" class="form-control findAdd4" placeholder="참고항목 (입력은 선택사항 입니다)" style="margin-left:81px; width:400px">
					</div>
					<br />					
					<div class="form-group"> <!-- 배송메모 -->
						<label for="address" class="">배송메모</label>				
						<input type="text" id="address_memo" name="memo" class="form-control findAdd5" maxlength="30" style="margin-left:21px;"/>
					</div>				
								
				</div>	<!--  receiver -->
				<br />
				<br />
							
				<div class="payment">
					<h3>04. 결제 수단</h3>
					<hr />
		            <div class="pay_radio">
		                <!-- 라디오 버튼 -->
		                <input type="radio" name="paymethod" id="card" value="카드결제" checked />
		                <label for="card">카드 결제</label>&nbsp;&nbsp;&nbsp;
		                <input type="radio" name="paymethod" id="bankbook" value="무통장입금" />
		                <label for="bankbook">무통장입금</label>&nbsp;&nbsp;&nbsp;
		                <input type="radio" name="paymethod" id="ascro" value="실시간계좌이체" />
		                <label for="ascro">실시간 계좌이체</label>&nbsp;&nbsp;
		                <input type="radio" name="paymethod" id="cell" value="휴대폰결제" />
		                <label for="cell">휴대폰 결제</label>&nbsp;&nbsp;
		                <input type="radio" name="paymethod" id="samsung" value="삼성페이" />
		                <label for="samsung">삼성페이</label>&nbsp;	&nbsp;     
		                <br />
		                <input type="radio" name="paymethod" id="kakao" value="카카오페이" />
		                <label for="kakao">카카오페이</label>&nbsp;&nbsp;	
		                <input type="radio" name="paymethod" id="naver" value="네이버페이" />
		                <label for="naver">네이버페이</label>&nbsp;&nbsp;	        
		                <input type="radio" name="paymethod" id="toss" value="토스" />
		                <label for="toss">토스</label>&nbsp;&nbsp;&nbsp;&nbsp;
		                <input type="radio" name="paymethod" id="conpay" value="편의점결제" />
		                <label for="conpay">편의점 결제</label>&nbsp;&nbsp;&nbsp;    	
		                <input type="radio" name="paymethod" id="cultureland" value="컬쳐랜드" />
		                <label for="cultureland">컬쳐랜드</label>	                        	                                           
		            </div>	<!-- pay_radio -->						
				</div>	<!--  payment -->
	
			</fieldset> <!-- left -->

			<div class="right">
				<div class="pay_box">
					<p class="pay_box_text">결제정보</p>
					<div class="pay-price"><strong style="font-size: 25px;" class="pay-price1"></strong>원</div>
					<span class="delivery_pay" style="margin-left: 40px; font-size: 11px">+베송비 &nbsp;&nbsp; 0원</span>
					<button type="submit" class="btn btn-success btn-order">
					   주문하기
					</button>		
				</div> <!-- pay_box -->
			</div> <!--  right -->
			
		</div> <!--  left_right  -->
		
		<!-- left_right 마감처리 -->
		
		<div class="payment_info">
		    <ul class="payment_info_list">
		        <li><strong>무통장입금</strong>&nbsp;&nbsp;이거모약에 지정된 계좌로 직접 입금하는 방식입니다. (인터넷뱅킹, 텔레뱅킹, ATM, 은행방문)</li>
		        <li style="font-size: 13.5px;"><strong>실시간 계좌이체</strong>&nbsp;&nbsp;은행을 거치지않고 회원님 계좌에서 바로 이체되는 편리한 서비스입니다. (이체수수료무료 / 공인인증서필수)</li>
		        <li><strong>휴대폰 결제</strong>&nbsp;&nbsp;인증번호를 통해 간단히 휴대폰으로 결제처리가 되면 익월통신요금에 합산청구됩니다.</li>
		        <li><strong>편의점 결제</strong>&nbsp;&nbsp;CU, GS25, CSPACE, 세븐일레븐에서 바코드 결제가 가능합니다. (주문 취소시 수수료 2% 차감 후 환불됩니다.)</li>
		        <li><strong>컬쳐랜드 결제</strong>&nbsp;&nbsp;상품권결제 후 취소 요청 시엔 전체취소(컬쳐캐쉬)만 가능합니다. (부분취소와 현금환불은 불가능합니다.)</li>
		    </ul>
		</div><!-- //payment_info -->	
		
	</form>
	
</div> <!--  container order_contents -->

<br />
<br />
<br />
<br />

<!--// ========== 컨텐츠 영역 끝 ========== -->

<!-- 다음 주소 검색 api 사용 -->
<script src="<%=request.getContextPath()%>/assets/js/postcode.js"></script>

<!-- 개발자가 구현하는 스크립트 블록 -->
<script type="text/javascript">

//숫자 키입력 검사 => 숫자 이외에 입력안됨!
function isNumberKeyDown(e) {
    e = e || window.event;
    var keyCode = (e.keyCode ? e.keyCode : e.which);
 
    if (keyCode == 8 || keyCode == 9 || keyCode == 27 || keyCode == 46) return true;    //BackSpace, Tab, ESC, Delete
    if (keyCode == 35 || keyCode == 36 || keyCode == 37 || keyCode == 39) return true;  //Home, End, Left, Right Arrow
    if (e.ctrlKey || e.shiftKey || keyCode == 13) return false; //Enter
 
    return ((keyCode > 47 && keyCode < 58) || (keyCode > 95 && keyCode < 106));
}

// 연락처 입력시, 하이픈문자 `-` 자동 입력
function inputHyphen(obj) {
	var number = obj.value.replace(/[^0-9]/g, "");
	var phone = "";

	if (number.length < 4) {
		return number;
	} else if (number.length < 7) {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3);
	} else if (number.length < 11) {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3, 3);
		phone += "-";
		phone += number.substr(6);
	} else {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3, 4);
		phone += "-";
		phone += number.substr(7);
	}
	obj.value = phone;
};

// 연락처 하이픈문자 `-` 자동 입력 함수
function hyphen(number) {
	var phone = "";
	if (number.length < 11) {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3, 3);
		phone += "-";
		phone += number.substr(6);
		return phone;
	} else {
		phone += number.substr(0, 3);
		phone += "-";
		phone += number.substr(3, 4);
		phone += "-";
		phone += number.substr(7);
		return phone;
	}
	return number;
};

/** 금액 콤마 정규표현식 **/
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/** paybox에 결제정보 - 결제금액 찍어주기 */
$(document).ready(function(){                                                 
	
	var ch = $(".cart_id:checked");
	var total = 0;		// 합계 초기값
	
	for (var i=0; i<ch.length; i++) {			//체크된 길이만큼 반복문돌면서
		var price = Number(ch.eq(i).parents(".cart-item1").find(".total-price1").attr("data-value"))		// 행의 합계의 값을 찾아 숫자로 변환하고 
		total += price;								// 체크된 값 더함
	}
	
	$(".total-price2").html(numberWithCommas(total));			// 총 결제금액에 total 값을 출력함
	$(".total-price2").attr("data-value", total);						// data-value에도 total 값 저장
	
	var orderPrice = $(".total-price2").attr("data-value");  	// data-value 값 가져와서
		
	$(".pay-price1").html(numberWithCommas(orderPrice));	// paybox에 결제금액 찍어줌!
		
});

$(function() {
	
	/** 주문자 정보와 동일 체크박스 **/
	$("#orderer_same").change(function() {
		var checked = $("#orderer_same").prop("checked");
		
		var name = $("#user_name").val();
		var email = $("#tel").val();
		var tel = hyphen($("#tel").val());
		var post = $("#postcode1").val();
		var addr = $("#address1").val();		
		var detail = $("#detail_address1").val();
		
		if (checked) {
			$("#user_name2").val(name);							// 주문자 이름 가져와서 값 대입.
			$("#user_name2").attr("readonly", true);		// readonly 속성 추가
			$("#tel2").val(tel);											
			$("#tel2").attr("readonly", true);					
			$("#postcode").val(post);
			$("#postcode").attr("readonly", true);
			$("#address").val(addr);
			$("#address").attr("readonly", true);
			$("#detailAddress").val(detail); 
			$("#detailAddress").attr("readonly", true);
			$("#postcode-btn").prop("disabled", true);
		}	else {
			$("#user_name2").val("");
			$("#user_name2").attr("readonly", false);	
			$("#tel2").val("");
			$("#tel2").attr("readonly", false);		
			$("#postcode").val("");
			$("#postcode").attr("readonly", false);
			$("#address").val("");
			$("#address").attr("readonly", false);
			$("#detailAddress").val("");
			$("#detailAddress").attr("readonly", false);
			$("#postcode-btn").prop("disabled", false);
		}
	});
	
	/** 주문하기 버튼 **/
	$(".btn-order").click(function(e) {
		e.preventDefault();
		
		var name = $("#user_name2").val();
		var name2 = $.trim(name);					// 앞 뒤 공백제거(스페이스바 - 공백 인식)
		if (!name2) {
			swal({
				title : "수취인명을 입력해주세요", 			// 제목
				html : "", 										// 내용
				type : "error", 								// 종류
				confirmButton : true, 					// 확인버튼 표시여부
				confirmButtonText : "확인", 			// 확인버튼표시문구		
			});
			return false;
		}	
		
		var tel = $("#tel2").val();
		var tel2 = $.trim(tel);							// 앞 뒤 공백제거(스페이스바 - 공백 인식)
		if (!tel2) {
			swal({
				title : "핸드폰번호를 입력해주세요", 		// 제목
				html : "", 										// 내용
				type : "error", 								// 종류
				confirmButton : true, 					// 확인버튼 표시여부
				confirmButtonText : "확인", 			// 확인버튼표시문구		
			});
			return false;
		}	
		
		var add = $("#address").val();
		var add2 = $.trim(add);						// 앞 뒤 공백제거(스페이스바 - 공백 인식)
		if (!add2) {
			swal({
				title : "주소를 입력해주세요", 				// 제목
				html : "", 										// 내용
				type : "error", 								// 종류
				confirmButton : true, 					// 확인버튼 표시여부
				confirmButtonText : "확인", 			// 확인버튼표시문구		
			});
			return false;
		}	
		
		swal({
	    	title: "주문을 진행하시겠습니까?",
	    	text: "",
	    	type: "question",
	    	confirmButtonText: "확인",
		    showCancelButton: true,
		    cancelButtonText: "취소",
	    }).then(function(result) {
	    	if (result.value) {
	    		
			const optionInfo = [];
			
			var ch = $(".cart_id:checked");
			var total = 0;		
			var count = 0;		
			
			for (var i=0; i<ch.length; i++) {			
				
				console.log($(".productId").val());
				
				data = {
						'productId': ch.eq(i).parents(".cart-item1").find(".productId").val(),
						'name': ch.eq(i).parents(".cart-item1").find(".productName").val(),
						'img': ch.eq(i).parents(".cart-item1").find(".productImg").val(),
						'qty': ch.eq(i).parents(".cart-item1").find(".productQty1").val(),
						'price': ch.eq(i).parents(".cart-item1").find(".productPrice").val(),
						'c_price': ch.eq(i).parents(".cart-item1").find(".total-price1").attr("data-value")
				}
				
				optionInfo.push(data);
				console.log(data);
				count++
			}
		
			option = JSON.stringify(optionInfo);
								
			$.post("${pageContext.request.contextPath}/shop/rest/order-complete.do",
				{"user_name": $("#user_name2").val(),	
				"tel": $("#tel2").val(),
				"postcode": $("#postcode").val(),
				"address": $("#address").val(),
				"detail_address": $("#detailAddress").val(),
				"extra_address": $("#extraAddress").val(),
				"memo": $("#address_memo").val(),
				"paymethod": $("input[name='paymethod']:checked").val(),
				"prod_info": option,
				"total_price": $(".total-price2").attr("data-value"),
				"count": count}, function(json) {
					swal({
						title : "주문이 완료되었습니다.", 			// 제목
						html : "", 										// 내용
						type : "success", 							// 종류
						confirmButton : true, 					// 확인버튼 표시여부
						confirmButtonText : "확인", 			// 확인버튼표시문구		
					}).then(function(result) {
					
						$("#order-form").submit();
						window.location.href = "${pageContext.request.contextPath}/shop/order-complete.do";
				    });
				});
	    	}
		});
	});
});

</script>

<%@ include file="../_inc/footer.jsp"%>
