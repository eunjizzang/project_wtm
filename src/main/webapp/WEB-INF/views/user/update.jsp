<%
/**
* @filename    : update.jsp
* @description : --- 회원정보 수정 페이지 ---

<!-- 기본 border-radius: 4px; --> 

* @author      : 오 혜 진
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/member_info.css">

<style type="text/css">
/* 에러가 발생한 input 태그 */
input.error {
	background-color: #fdf7f796;
	border: 1px solid #ff000045;
}
        
/* 에러메시지가 표시중인 label 태그 */
label.error {
	color: #ff0000bf;
	font-size: 8px;
	display: inline-block;
	padding: 0 10px;
	margin: 0;
}

/* 양식에 맞게 작성한 input 태그(주소창을 제외한 유효검사 완료 input) */
.validate-input.valid {
	background-color: #eefdf11f !important;
	border: 1px solid #1892188f;
}
        
/* 우편번호 에러문구 보이지 않게 */
#postcode-error {
	display: none; margin: 0; padding: 0; width: 0; height: 0;
}

/** 별 안보이게 */
.identify {	display: none; }

/** 입력폼 크기 */
.form-control { height: 40px; }
</style>

<!-- ========== 컨텐츠 영역 시작 ========== -->
<div class="container" style="margin: auto; width: 400px;">
	<br />
	<br />
	<br />
	<!-- 
		========== #update_form (수정 폼) ==========
		아이디 비밀번호 비밀번호확인 이름 이메일 휴대폰번호 주소
		#user_id, #user_pw, #user_pw_re, #name, #email, #tel
		#postcode, #address, #detailAddress, #extraAddress
	 -->
	<form class="form-horizontal" name="update_form" id="update_form" method="post" action="${pageContext.request.contextPath}/mypage/update_ok.do">
		<div class="form-group">
			<label for="user_id" class="">아이디 <span	class="identify">*</span></label>
			<div class="">
				<input type="text" name="user_id" id="user_id" class="form-control validate-input" value="${memInfo.userId}" placeholder="회원 아이디값 들어올 자리" readonly>
			</div>
		</div>
		<br>
		<div class="form-group">
			<label for="user_pw" class="">비밀번호 <span class="identify">*</span></label>
			<div class="">
				<input type="password" name="user_pw" id="user_pw" class="form-control validate-input" value="${originPw}">
			</div>
		</div>
		<br>
		<div class="form-group">
			<label for="user_pw" class="">비밀번호 확인 <span class="identify">*</span></label>
			<div class="">
				<input type="password" name="user_pw_re" id="user_pw_re" class="form-control validate-input" value="${originPw}">
			</div>
		</div> 
		<br>
		<div class="form-group">
			<label for="user_name" class="">이름 <span class="identify">*</span></label>
			<div class="">
				<input type="text" name="user_name" id="user_name" class="form-control validate-input" value="${memInfo.userName}" autocomplete="off">
			</div>
		</div>
		<br>
		<div class="form-group">
			<label for="email" class="">이메일 <span class="identify">*</span></label>
			<div class="">
				<input type="email" name="email" id="email" class="form-control validate-input" value="${memInfo.email}" placeholder="회원 이메일값 들어올 자리" readonly>
			</div>
		</div>
		<br>
		<div class="form-group">
			<label for="tel" class="">핸드폰번호 <span class="identify">*</span></label>
			<div class="">
				<!-- 세션값으로 조회된 회원 휴대폰 번호를 자바스크립트에서 (-)하이픈 문자 추가 후 value에 삽입. -->
				<input type="tel" name="tel" id="tel" class="form-control validate-input" placeholder="문자 `-`를 제외하고 숫자만 입력해 주세요" onkeyup="inputHyphen(this);">
			</div>
		</div>
		<br>
		
		<div class="form-group"> <!-- (필수!) 우편번호입력창+검색버튼 -->
			<label for="address" class="">주소 <span class="identify">*</span></label>
			<div class="input-group">
				<input type="text" name="postcode" class="form-control validate-input" id="postcode" placeholder="㉾" maxlength="5" style="width: 82px;" value="${memInfo.postcode}" readonly>
				<button type="button" id="postcode-btn" class="btn btn-info postcode-finder" onclick="execDaumPostcode()"
					data-postcode="#postcode" data-addr1="#addr1" data-addr2="#addr2" data-frame="#postcode-frame">우편번호검색</button>
			</div>
		</div>
		<div class="form-group"> <!-- (필수!) 주소입력창 -->
			<input type="text"	id="address" name="address" class="form-control findAdd2 validate-input" placeholder="주소" value="${memInfo.address}" readonly>
		</div>
		<div class="form-group"> <!-- (필수!) 상세주소입력창(사용자 입력부분) -->
			<input type="text"	id="detailAddress" name="detailAddress"	class="form-control findAdd3 validate-input" placeholder="상세주소" value="${memInfo.detailAddress}">			
		</div>
		<div class="form-group"> <!-- 참고항목+주의사항 -->
			<input type="text" id="extraAddress" name="extraAddress" class="form-control findAdd4" placeholder="참고항목 (입력은 선택사항 입니다)" value="${memInfo.extraAddress}">
<!-- 			<p style="font-style: italic; font-size: 13px;">'병원찾기'	및 '약국찾기' 이용 시 기본 주소로 사용됩니다.</p> -->
		</div>

		<div class="form-group">
			<div class="text-center">
				<button type="submit" id="updatebutton" class="btn btn-info">수정</button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="submit" id="delbutton" class="btn btn-default">탈퇴</button>
			</div>
		</div>
	</form>
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>

<!-- 다음 주소 검색 api 사용 -->
<!-- 여기서 vaildate를 어떻게 판별할지....... -->
<script src="<%=request.getContextPath()%>/assets/js/postcode.js"></script>

<!-- validate 플러그인 참조 -->
<script src="<%=request.getContextPath()%>/assets/plugins/validate/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/assets/plugins/validate/additional-methods.min.js"></script>

<script type="text/javascript">
	// 탈퇴 완료 페이지로 이동
	function moveBye() {
		var form = document.createElement('form');
		form.setAttribute('method', 'post');
		form.setAttribute('action', "<%=request.getContextPath()%>/thanks");
		document.charset = "utf-8";
		document.body.appendChild(form);
		form.submit();
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
	
	// 세션값을 통해 조회된 결과
	var t = '${memInfo.tel}';
	// 하이픈 문자 추가하여 페이지 로딩시 #tel value속성 값에 넣어준다.
	window.onload = $("#tel").val(hyphen(t));

	$(function() {
		/** 유효성 검사 플러그인이 ajaxForm보다 먼저 명시되어야 한다. */
	    // 지원하지 않는 양식에 대한 검사 규칙 추가하기
	    /* 유효성 검사 추가 함수 (커스텀) */
	    $.validator.addMethod('kor', function(value, element) {
	        return this.optional(element) || /^[가-힣]*$/i.test(value);
	    });
	    $.validator.addMethod('phone', function(value, element) {
	        return this.optional(element) ||
	        /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/i.test(value)
	        || /^\d{2, 3}-\d{3, 4}-\d{4}$/i.test(value) ;
	    });	

	    /** 가입폼의 유효성 검사 함수 호출, submit이벤트를 가로챈다 */
	    $("#update_form").validate({
	        /* 입력 검사 규칙 */
	        rules: {
	            // [비밀번호] 글자수 길이 제한
	            user_pw: { rangelength: [4, 20] },
	            // [비밀번호 확인] 비밀번호 항목과 일치 (id값으로 연결)
	            user_pw_re: { equalTo: "#user_pw" },
	             // [이름] 한글만 허용 (커스텀)
	            user_name: { required: true, kor: true, rangelength: [2, 5] },
	            // [연락처] 형식 검사 (커스텀)
	            tel: { required: true, phone: true
 	            	,
	                // DB 조회 후 중복여부 체크
	            	remote: {
		                url: '/wtm/login/tel_unique',
		                type: 'post',
		                data: { tel : function() { return $("#tel").val(); } }
	            	} 
	             },
	             // [우편번호] 필수 입력
	            postcode: 'required',
	            // [주소] 우편번호가 입력된 경우만 필수
	            address: 'required',
	            // [상세주소] 사용자 입력란, 필수
	            detailAddress: 'required'
	        },
	        /* 규칙이 맞지 않을 경우 메시지 */
	        messages: {
	            user_pw: {
	                rangelength: "비밀번호는 {0}~{1}자 입력 가능합니다."
	            },
	            user_pw_re: {
	                equalTo: "비밀번호가 일치하지 않습니다."
	            },
	             user_name: {
	                required: "이름을 입력하세요.",
	                kor: "이름은 한글만 입력 가능합니다.",
	                rangelength: "이름은 {0}~{1}자리의 한글만 입력 가능합니다."
	            },
	            tel: {
	                required: "핸드폰번호를 입력하세요.",
	                phone: "핸드폰번호 형식이 잘못되었습니다.",
	                // DB 조회 후 중복여부 체크 --> 본인 핸드폰번호는 검색에서 제외한다.
	                // TODO --> 비밀번호가 공백일시에 원래 비밀번호를 유지한다.
	                remote : "{0}은(는) 사용중인 핸드폰번호 입니다. "
	            }, 
	            postcode: '',
	            address: '우편번호 찾기를 통해 주소를 입력하세요.',
	            detailAddress: '상세주소를 입력하세요.'
	        }
	    }); // end validate()    

		// 탈퇴버튼 클릭시
		$("#delbutton").click(function(e) {
			e.preventDefault();
			swal({
				title: "탈퇴",
				text:"정말 탈퇴하시겠습니까? 탈퇴 후에도 작성 글 및 예약 내역은 자동으로 삭제되지 않습니다.",
				type: "warning",
				confirmButton: true,
				confirmButtonText: "탈퇴",
				confirmButtonColor: "#f60",
				showCancelButton: true,
				cancelButtonText: "취소",
			}).then(function(result) {
				if (result.value) {
					moveBye();
				}
			});
		});
	});
</script>

