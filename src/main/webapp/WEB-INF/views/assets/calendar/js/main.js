var activeInactiveWeekends = true;

function getDisplayEventDate(event) {
	var displayEventDate;

	if (event.allDay == false) {
		var startTimeEventInfo = moment(event.start).format('HH:mm');
		var endTimeEventInfo = moment(event.end).format('HH:mm');
		displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;
	} else {
		displayEventDate = "하루종일";
	}
	return displayEventDate;
}

function filtering(event) {
	var show_typename = true;
	var show_type = true;

	var typename = $('input:checkbox.filter:checked').map(function() {
		return $(this).val();
	}).get();
	var types = $('#type_filter').val();

	show_typename = typename.indexOf(event.typename) >= 0;

	if (types && types.length > 0) {
		if (types[0] == "all") {
			show_type = true;
		} else {
			show_type = types.indexOf(event.type) >= 0;
		}
	}

	return show_typename && show_type;
}

function calDateWhenResize(event) {

	var newDates = {
		startDate: '',
		endDate: ''
	};

	if (event.allDay) {
		newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
		newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
	} else {
		newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
		newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
	}

	return newDates;
}

var calendar = $('#calendar').fullCalendar({
	eventRender: function(event, element, view) {
		//일정에 hover시 요약
		element.popover({
			title: $('<div />', {
				class: 'popoverTitleCalendar',
				text: event.title
			}).css({
				'background': event.backgroundColor,
				'color': event.textColor
			}),
			content: $('<div />', {
				class: 'popoverInfoCalendar'
			}).append('<p hidden><strong>ID:</strong> ' + event.Id + '</p>')
				.append('<p><strong>구분:</strong> ' + event.type + '</p>')
				.append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
				.append('<div class="popoverDescCalendar"><strong>설명:</strong> ' + event.description + '</div>'),
			delay: {
				show: "800",
				hide: "50"
			},
			trigger: 'hover',
			placement: 'top',
			html: true,
			container: 'body'
		});
		return filtering(event);
	},

	//주말 숨기기 & 보이기 버튼
	customButtons: {
		viewWeekends: {
			text: '주말',
			click: function() {
				activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
				$('#calendar').fullCalendar('option', {
					weekends: activeInactiveWeekends
				});
			}
		}
	},

	header: {
		left: 'today, prevYear, nextYear, viewWeekends',
		center: 'prev, title, next',
		right: 'month,agendaWeek,agendaDay,listWeek'
	},
	
	views: {
		month: {
			columnFormat: 'dddd'
		},
		agendaWeek: {
			columnFormat: 'M/D ddd',
			titleFormat: 'YYYY년 M월 D일',
			eventLimit: false
		},
		agendaDay: {
			columnFormat: 'dddd',
			eventLimit: false
		},
		listWeek: {
			columnFormat: ''
		}
	},

	/* ****************
	 *  일정 받아옴 
	 * ************** */
	events: function(start, end, timezone, callback) {
		$.ajax({
			type: "get",
			url: "rest/user/calendar",
			success: function(response) {
				var fixedDate = response['item'].map((item) => ({	allday: item.allday,
																	type: item.type,
																	backgroundColor:item.backgroundcolor,
																	description: item.description,
																	end: item.end,
																	id: item.id,
																	textColor: item.textcolor,
																	title: item.title,
																	mid: item.mid,
																	start: item.start,
																	typename: item.typename }));
				callback(fixedDate);
			}
		});
	},

	eventAfterAllRender: function(view) {
		if (view.name == "month") {
			$(".fc-content").css('height', 'auto');
		}
	},

	select: function(startDate, endDate, jsEvent, view) {

		$(".fc-body").unbind('click');
		$(".fc-body").on('click', 'td', function(e) {

			$("#contextMenu")
				.addClass("contextOpened")
				.css({
					display: "block",
					left: e.pageX,
					top: e.pageY
				});
			return false;
		});

		var today = moment();

		if (view.name == "month") {
			startDate.set({
				hours: today.hours(),
				minute: today.minutes()
			});
			startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
			endDate = moment(endDate).subtract(1, 'days');

			endDate.set({
				hours: today.hours() + 1,
				minute: today.minutes()
			});
			endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
		} else {
			startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
			endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
		}

		//날짜 클릭시 카테고리 선택메뉴
		var $contextMenu = $("#contextMenu");
		$contextMenu.on("click", "a", function(e) {
			e.preventDefault();

			//닫기 버튼이 아닐때
			if ($(this).data().role !== 'close') {
				newEvent(startDate, endDate, $(this).html());
			}

			$contextMenu.removeClass("contextOpened");
			$contextMenu.hide();
		});

		$('body').on('click', function() {
			$contextMenu.removeClass("contextOpened");
			$contextMenu.hide();
		});

	},

	//이벤트 클릭시 수정이벤트
	eventClick: function(event, jsEvent, view) {
		editEvent(event);
	},

	locale: 'ko',
	timezone: "local",
	nextDayThreshold: "09:00:00",
	disableDragging: true,
	editable: false,
	droppable: false,
	allDaySlot: true,
	displayEventTime: true,
	displayEventEnd: true,
	firstDay: 0, //월요일이 먼저 오게 하려면 1
	weekNumbers: false,
	selectable: true,
	weekNumberCalculation: "ISO",
	eventLimit: true,
	views: {
		month: {
			eventLimit: 12
		}
	},
	eventLimitClick: 'week', //popover
	navLinks: true,
	//defaultDate: moment('2020-07'), //실제 사용시 삭제
	timeFormat: 'HH:mm',
	defaultTimedEventDuration: '01:00:00',
	minTime: '00:00:00',
	maxTime: '24:00:00',
	slotLabelFormat: 'HH:mm',
	weekends: true,
	nowIndicator: true,
	dayPopoverFormat: 'MM/DD dddd',
	longPressDelay: 0,
	eventLongPressDelay: 0,
	selectLongPressDelay: 0
});