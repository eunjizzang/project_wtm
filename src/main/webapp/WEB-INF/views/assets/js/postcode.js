/**
 * 
 */
function execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가진다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			//***이거모약에서는 지도 검색시 지번주소만 사용하므로 지번주소만 가져온다.
			if (data.userSelectedType) {
				addr = data.jibunAddress;
				console.log("주소값 : " + addr);
			}

			// 사용자가 도로명 주소를 선택했을 경우(R),  사용자가 지번 주소를 선택했을 경우(J)
			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') { 
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraAddr !== '') {
					extraAddr = ' (' + extraAddr + ')';
				}
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("extraAddress").value = extraAddr;
			} else {
				// 기타항목이 없을 경우에는 빈칸으로 둔다.
				document.getElementById("extraAddress").value = '';
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById("postcode").value = data.zonecode;
			document.getElementById("address").value = addr;
			// 우편번호와 주소에 값이 들어가면, 유효성 검사에 통과하므로
			if (data.zonecode) {
				if ($("#postcode").hasClass("error")) {
					// class가 error를 포함하는 경우 valid로 상태 변경
					$("#postcode").toggleClass("error valid");
				} else {
					// class가 error를 포함하지 않는 경우 valid class추가
					$("#postcode").addClass("valid");
				}
			}
			if (addr) {
				if ($("#address").hasClass("error")) {
					// class가 error를 포함하는 경우 valid로 상태 변경
					$("#address").toggleClass("error valid");
					$("#address-error").css("display", "none");
				} else {
					// class가 error를 포함하지 않는 경우 valid class추가
					$("#address").addClass("valid");
				}
			}
			// 주소필드에 값이 들어가지 않은 경우(지번주소가 많은 도로명주소를 선택한 경우)
			if (!addr) {
				// 1 도로명주소에 n 지번주소가 존재하는 경우
				// 도로명주소를 선택하면 지번주소를 가져오지 못하는 경우가 생기므로 사용자에게 알림을 준다.
				swal({
					html: "<span class='postcode-info-text'>하나의 도로명주소에 지번주소가 여러개인 경우<br>정확한 지번주소를 선택해 주세요.</span>",
					type: "info",
					confirmButtonText: "확인",
					confirmButtonColor: '#2E9AFE'
				});
				// 커서를 주소찾기버튼으로 이동시킨다.
				$("#postcode-btn").focus();
				return false;
			}
			// 커서를 상세주소 필드로 이동한다.
			$("#detailAddress").focus();
		}
	}).open();
}
