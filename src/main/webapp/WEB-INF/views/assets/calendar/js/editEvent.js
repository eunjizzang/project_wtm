/* ****************
 *  일정 편집
 * ************** */
var id;
var type;
var editEvent = function(event, element, view) {
	$("#contextMenu").hide(); //메뉴 숨김
	
	// 삭제및 상세페이지 이동시 필요한 일련번호
	id = event.id;
	// 일정(0), 예약(1) 판별
	type = event.typename;
	console.log( '[' + type + '] ' + id)
	var reUrl = "my-reserve/reserve-1.do?reserve_id=" + id;

	if (type == 1) {
		swal({
			title: '안내',
			text: '예약 취소 / 삭제는 마이페이지에서 가능합니다.',
			type: 'info',
			showCancelButton: true,
			cancelButtonText: '닫기',
			confirmButtonText: '상세페이지로 이동',
		}).then(function(result) {
			if (result.value) {
				location.href = reUrl;
			}
		});
	} else {
		swal({
			title: "확인",
			text: "일정을 삭제하시겠습니까?",
			type: "question",
			confirmButtonText: "확인",
			showCancelButton: true,
			cancelButtonText: "취소",
		}).then(function(result) {
			if (result.value) {
				$('#deleteEvent').unbind();
				$("#calendar").fullCalendar('removeEvents', id);
				eventModal.modal('hide');

				//삭제시
				$.ajax({
					type: "delete",
					url: "rest/user/calendar",
					data: { id: id },
					success: function(response) {
						swal({
							title: '삭제되었습니다.',
							type: 'success'
						});
						setTimeout(function() { location.reload(); }, 700);
					}
				});
			}
		});
	}
};
