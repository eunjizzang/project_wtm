var eventModal = $('#eventModal');

var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');

/* ****************
 *  새로운 일정 생성
 * ************** */
var newEvent = function(start, end, eventType) {
	$("#contextMenu").hide(); //메뉴 숨김

	modalTitle.html('새로운 일정');
	editType.val(eventType).prop('selected', true);
	editTitle.val('');
	editStart.val(start);
	editEnd.val(end);
	editDesc.val('');

	addBtnContainer.show();
	modifyBtnContainer.hide();
	eventModal.modal('show');

	//새로운 일정 저장버튼 클릭
	$('#save-event').unbind();
	$('#save-event').on('click', function() {

		var eventData = {
			title: editTitle.val(),
			start: editStart.val(),
			end: editEnd.val(),
			description: editDesc.val(),
			type: editType.val(),
			typename: '0',
			backgroundColor: editColor.val(),
			textColor: '#ffffff'
		};

		console.log(editAllDay.val());

		if (eventData.start > eventData.end) {
			swal({
				title: '끝나는 날짜가 앞설 수 없습니다.',
				type: 'warning'
			});
			return false;
		}

		if (eventData.title === '') {
			swal({
				title: '일정명은 필수입니다.',
				type: 'warning'
			});
			return false;
		}

		var realEndDay;

		if (editAllDay.is(':checked')) {
			eventData.start = moment(eventData.start).format('YYYY-MM-DD');
			//render시 날짜표기수정
			eventData.end = moment(eventData.end).add(1, 'days').format('YYYY-MM-DD');
			//DB에 넣을때(선택)
			realEndDay = moment(eventData.end).format('YYYY-MM-DD');

			eventData.allDay = true;
		}

		$("#calendar").fullCalendar('renderEvent', eventData, true);
		eventModal.find('input, textarea').val('');
		editAllDay.prop('checked', false);
		eventModal.modal('hide');

		//새로운 일정 저장
		$.ajax({
			type: "post",
			url: "rest/user/calendar",
			data: {
				title: eventData['title'],
				start: eventData['start'],
				end: eventData['end'],
				description: eventData['description'],
				type: eventData['type'],
				typename: eventData['typename'],
				backgroundcolor: eventData['backgroundColor'],
				textColor: eventData['textColor']
			},
			success: function(response) {
				swal({
					title: '저장되었습니다.',
					type: 'success'
				});
				setTimeout(function() { location.reload(); }, 700);
				//DB연동시 중복이벤트 방지를 위한
				//$('#calendar').fullCalendar('removeEvents');
				//$('#calendar').fullCalendar('refetchEvents');
			}
		});
	});
};