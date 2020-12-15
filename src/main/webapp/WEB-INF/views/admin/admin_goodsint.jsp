
<%
	/**
* @ Project : 이거모약?
* @ FileName : admin_goodsint.jsp
* @ Date : 2020.08.10
* @ Author : 이 민 희(lmnhofficial@gmail.com)
* @ Description 
* 		1) 쇼핑몰에 상품을 등록하기위한 페이지
*/
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../_inc/header.jsp"%>
<%@ include file="../_inc/adminnavi.jsp"%>

<style type="text/css">
.header-navi {
	display: none;
}

.table>tbody>tr>th {
	border-top: 1px solid #e6e6e6;
	border-bottom: 1px solid #e6e6e6;
	background: #f6f6f6;
	padding: 10px;
	width: 200px;
	text-align: center;
}

.star {
	font-size: 20px;
	color: #f00;
}
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->

<div class="container">
	<!-- 타이틀 -->
	<div class="col-md-12">
		<h2>상품등록</h2>
		<hr />
	</div>
	<div class="col-md-12">
		<form method="post"
			action="${pageContext.request.contextPath}/goodsint.do">
			<table class="table" style="margin: 0">
				<tbody>
					<tr>
						<th class="text-center" style="width: 30%"><label for="id"><span
								class="star">* </span>상품번호:</label></th>
						<td><input type="text" name="id" id="id" /></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label
							for="category"><span class="star">* </span>분류:</label></th>
						<td><input type="text" name="category" id="category" /></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label for="name"><span
								class="star">* </span>상품명:</label></th>
						<td><input type="text" name="name" id="name" /></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label for="eng">상품명(eng):</label></th>
						<td><input type="text" name="eng" id="eng" /></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label for="img"><span
								class="star">* </span>이미지:</label></th>
						<td><input type="file" name="img" id="img" /></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label for="price"><span
								class="star">* </span>판매가격:</label></th>
						<td><input type="text" name="price" id="price" /></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label for="qty">재고:</label></th>
						<td><input type="text" name="qty" id="qty" /></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label for="desc">상품설명:</label></th>
						<td><textarea style="width: 621px; height: 300px;"
								name="desc" id="desc"></textarea></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label for="spec">상품스펙:</label></th>
						<td><textarea style="width: 621px; height: 300px;"
								name="spec" id="spec"></textarea></td>
					</tr>
					<tr>
						<th class="text-center" style="width: 30%"><label for="spec">배달상세:</label></th>
						<td><textarea style="width: 621px; height: 300px;"
								name="delivery" id="delivery"></textarea></td>
					</tr>
				</tbody>
			</table>
			<div style="float: right;">
				<button type="submit" class="btn btn-md btn-default submitbtnback">취소</button>
				<button type="submit" class="btn btn-md btn-info submitbtnok">확인</button>
			</div>
			<div style="padding: 25px"></div>
		</form>
	</div>
</div>

<!-- ========== 컨텐츠 영역 끝 ========== -->

<%@ include file="../_inc/footer.jsp"%>

<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
<script type="text/javascript">
	$(function() {

		/** 취소버튼 **/
		$(".submitbtnback").click(function() {
			window.history.back();
		});

		/** 확인버튼 **/
		$(".submitbtnok").click(function(e) {
			e.preventDefault();

			// 입력여부 검사 
			// 빈 항목이 있을 때 
			var msg = "필수 항목을 입력하세요."

			var proid = $("#id").val();
			var procate = $("#category").val();
			var proname = $("#name").val();
			var proimg = $("#img").val();
			var proprice = $("#price").val();

			if (!proid) {
				swal(msg, "", "error");
				$("#id").focus();
				return false;
			} else if (!proname) {
				swal(msg, "", "error");
				$("#name").focus();
				return false;
			} else if (!proimg) {
				swal(msg, "", "error");
				$("#img").focus();
				return false;
			} else if (!proprice) {
				swal(msg, "", "error");
				$("#price").focus();
				return false;
			} else if (!procate) {
				swal(msg, "", "error");
				$("#category").focus();
				return false;
			}

		});
	});
</script>
