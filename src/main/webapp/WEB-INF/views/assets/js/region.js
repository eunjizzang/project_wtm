/**
* @filename : region.js
* @description : --- 병원/약국 찾기(hospital.jsp & drug.jsp) ---
* @author : 이 상 희(46wendy@naver.com)
*/

data={
    "seoul": [
                {"text":"종로구", "value":"종로구"},
                {"text":"중구", "value":"중구"},
                {"text":"용산구", "value":"용산구"},
                {"text":"성동구", "value":"성동구"},
                {"text":"광진구", "value":"광진구"},
                {"text":"동대문구", "value":"동대문구"},
                {"text":"중랑구", "value":"중랑구"},
                {"text":"성북구", "value":"성북구"},
                {"text":"강북구", "value":"강북구"},
                {"text":"도봉구", "value":"도봉구"},
                {"text":"노원구", "value":"노원구"},
                {"text":"은평구", "value":"은평구"},
                {"text":"서대문구", "value":"서대문구"},
                {"text":"마포구", "value":"마포구"},
                {"text":"양천구", "value":"양천구"},
                {"text":"강서구", "value":"강서구"},
                {"text":"구로구", "value":"구로구"},
                {"text":"금천구", "value":"금천구"},
                {"text":"영등포구", "value":"영등포구"},
                {"text":"동작구", "value":"동작구"},
                {"text":"관악구", "value":"관악구"},
                {"text":"서초구", "value":"서초구"},
                {"text":"강남구", "value":"강남구"},
                {"text":"송파구", "value":"송파구"},
                {"text":"강북구", "value":"강북구"},
                {"text":"강동구", "value":"강동구"}
           ],
    "busan": [
                {"text": "중구", "value": "중구"},
                {"text": "서구", "value": "서구"},
                {"text": "동구", "value": "동구"},
                {"text": "영도구", "value": "영도구"},
                {"text": "부산진구", "value": "부산진구"},
                {"text": "동래구", "value": "동래구"},
                {"text": "남구", "value": "남구"},
                {"text": "북구", "value": "북구"},
                {"text": "강서구", "value": "강서구"},
                {"text": "해운대구", "value": "해운대구"},
                {"text": "사하구", "value": "사하구"},
                {"text": "금정구", "value": "금정구"},
                {"text": "연제구", "value": "연제구"},
                {"text": "수영구", "value": "수영구"},
                {"text": "사상구", "value": "사상구"},
                {"text": "기장군", "value": "기장군"}
            ],
    "incheon": [
                {"text": "중구", "value": "중구"},
                {"text": "동구", "value": "동구"},
                {"text": "남구", "value": "남구"},
                {"text": "연수구", "value": "연수구"},
                {"text": "남동구", "value": "남동구"},
                {"text": "부평구", "value": "부평구"},
                {"text": "계양구", "value": "계양구"},
                {"text": "서구", "value": "서구"},
                {"text": "강화군", "value": "강화군"},
                {"text": "옹진군", "value": "옹진군"}
            ],
    "daegu": [
                {"text": "중구", "value": "중구"},
                {"text": "동구", "value": "동구"},
                {"text": "서구", "value": "서구"},
                {"text": "남구", "value": "남구"},
                {"text": "북구", "value": "북구"},
                {"text": "수성구", "value": "수성구"},
                {"text": "달서구", "value": "달서구"},
                {"text": "달성군", "value": "달성군"}
            ],
    "gwangju": [
                {"text": "동구", "value": "동구"},
                {"text": "서구", "value": "서구"},
                {"text": "남구", "value": "남구"},
                {"text": "북구", "value": "북구"},
                {"text": "광산구", "value": "광산구"}
            ],
    "daejeon": [
                {"text": "동구", "value": "동구"},
                {"text": "중구", "value": "중구"},
                {"text": "서구", "value": "서구"},
                {"text": "유성구", "value": "유성구"},
                {"text": "대덕구", "value": "대덕구"}
            ],
    "ulsan": [
                {"text": "중구", "value": "중구"},
                {"text": "남구", "value": "남구"},
                {"text": "동구", "value": "동구"},
                {"text": "북구", "value": "북구"},
                {"text": "울주군", "value": "울주군"}
            ],
    "sejong": [
                {"text": "", "value": ""}
            ],
    "gyeonggi": [
                {"text": "가평군", "value": "가평군"},
                {"text": "고양시", "value": "고양시"},
                {"text": "과천시", "value": "과천시"},
                {"text": "광명시", "value": "광명시"},
                {"text": "광주시", "value": "광주시"},
                {"text": "구리시", "value": "구리시"},
                {"text": "군포시", "value": "군포시"},
                {"text": "김포시", "value": "김포시"},
                {"text": "남양주시", "value": "남양주시"},
                {"text": "동두천시", "value": "동두천시"},
                {"text": "부천시", "value": "부천시"},
                {"text": "성남시", "value": "성남시"},
                {"text": "수원시", "value": "수원시"},
                {"text": "시흥시", "value": "시흥시"},
                {"text": "안산시", "value": "안산시"},
                {"text": "안성시", "value": "안성시"},
                {"text": "안양시", "value": "안양시"},
                {"text": "양주시", "value": "양주시"},
                {"text": "양평군", "value": "양평군"},
                {"text": "여주시", "value": "여주시"},
                {"text": "연천군", "value": "연천군"},
                {"text": "오산시", "value": "오산시"},
                {"text": "용인시", "value": "용인시"},
                {"text": "의왕시", "value": "의왕시"},
                {"text": "의정부시", "value": "의정부시"},
                {"text": "이천시", "value": "이천시"},
                {"text": "파주시", "value": "파주시"},
                {"text": "평택시", "value": "평택시"},
                {"text": "포천시", "value": "포천시"},
                {"text": "화성시", "value": "화성시"}
            ],
    "gangwon": [
                {"text": "원주시", "value": "원주시"},
                {"text": "춘천시", "value": "춘천시"},
                {"text": "강릉시", "value": "강릉시"},
                {"text": "동해시", "value": "동해시"},
                {"text": "속초시", "value": "속초시"},
                {"text": "삼척시", "value": "삼척시"},
                {"text": "홍천군", "value": "홍천군"},
                {"text": "태백시", "value": "태백시"},
                {"text": "철원군", "value": "철원군"},
                {"text": "횡성군", "value": "횡성군"},
                {"text": "평창군", "value": "평창군"},
                {"text": "영월군", "value": "영월군"},
                {"text": "정선군", "value": "정선군"},
                {"text": "인제군", "value": "인제군"},
                {"text": "고성군", "value": "고성군"},
                {"text": "양양군", "value": "양양군"},
                {"text": "화천군", "value": "화천군"},
                {"text": "양구군", "value": "양구군"}
            ],
    "chungbuk": [
                {"text": "청주시", "value": "청주시"},
                {"text": "충주시", "value": "충주시"},
                {"text": "제천시", "value": "제천시"},
                {"text": "보은군", "value": "보은군"},
                {"text": "옥천군", "value": "옥천군"},
                {"text": "영동군", "value": "영동군"},
                {"text": "증평군", "value": "증평군"},
                {"text": "진천군", "value": "진천군" },
                {"text": "괴산군", "value": "괴산군"},
                {"text": "음성군", "value": "음성군"},
                {"text": "단양군", "value": "단양군"}
            ],
    "chungnam": [
                {"text": "천안시", "value": "천안시"},
                {"text": "공주시", "value": "공주시"},
                {"text": "보령시", "value": "보령시"},
                {"text": "아산시", "value": "아산시"},
                {"text": "서산시", "value": "서산시"},
                {"text": "논산시", "value": "논산시"},
                {"text": "계룡시", "value": "계룡시"},
                {"text": "당진시", "value": "당진시"},
                {"text": "금산군", "value": "금산군"},
                {"text": "부여군", "value": "부여군"},
                {"text": "서천군", "value": "서천군"},
                {"text": "청양군", "value": "청양군"},
                {"text": "홍성군", "value": "홍성군"},
                {"text": "예산군", "value": "예산군"},
                {"text": "태안군", "value": "태안군"}
            ],
    "gyeongbuk": [
                {"text": "포항시", "value": "포항시"},
                {"text": "경주시", "value": "경주시"},
                {"text": "김천시", "value": "김천시"},
                {"text": "안동시", "value": "안동시"},
                {"text": "구미시", "value": "구미시"},
                {"text": "영주시", "value": "영주시"},
                {"text": "영천시", "value": "영천시"},
                {"text": "상주시", "value": "상주시"},
                {"text": "문경시", "value": "문경시"},
                {"text": "경산시", "value": "경산시"},
                {"text": "군위군", "value": "군위군"},
                {"text": "의성군", "value": "의성군"},
                {"text": "청송군", "value": "청송군"},
                {"text": "영양군", "value": "영양군"},
                {"text": "영덕군", "value": "영덕군"},
                {"text": "청도군", "value": "청도군"},
                {"text": "고령군", "value": "고령군"},
                {"text": "성주군", "value": "성주군"},
                {"text": "칠곡군", "value": "칠곡군"},
                {"text": "예천군", "value": "예천군"},
                {"text": "봉화군", "value": "봉화군"},
                {"text": "울진군", "value": "울진군"},
                {"text": "울릉군", "value": "울진군"}
            ],
    "gyeongnam": [
                {"text": "창원시", "value": "창원시"},
                {"text": "김해시", "value": "김해시"},
                {"text": "진주시", "value": "진주시"},
                {"text": "양산시", "value": "양산시"},
                {"text": "거제시", "value": "거제시"},
                {"text": "통영시", "value": "통영시"},
                {"text": "사천시", "value": "사천시"},
                {"text": "밀양시", "value": "밀양시"},
                {"text": "함안군", "value": "함안군"},
                {"text": "거창군", "value": "거창군"},
                {"text": "창녕군", "value": "창녕군"},
                {"text": "고성군", "value": "고성군"},
                {"text": "하동군", "value": "하동군"},
                {"text": "합천군", "value": "합천군"},
                {"text": "남해군", "value": "남해군"},
                {"text": "함양군", "value": "함양군"},
                {"text": "산청군", "value": "산청군"},
                {"text": "의령군", "value": "의령군"}
            ],
	"jeonbuk": [
				{"text": "전주시", "value": "전주시"},
				{"text": "익산시", "value": "익산시"},
				{"text": "군산시", "value": "군산시"},
				{"text": "정읍시", "value": "정읍시"},
				{"text": "완주군", "value": "완주군"},
				{"text": "김제시", "value": "김제시"},
				{"text": "남원시", "value": "남원시"},
				{"text": "고창군", "value": "고창군"},
				{"text": "부안군", "value": "부안군"},
				{"text": "임실군", "value": "임실군"},
				{"text": "순창군", "value": "순창군"},
				{"text": "진안군", "value": "진안군"},
				{"text": "장수군", "value": "장수군"},
				{"text": "무주군", "value": "무주군"}
			],
    "jeonnam": [
                {"text": "여수시", "value": "여수시"},
                {"text": "순천시", "value": "순천시"},
                {"text": "목포시", "value": "목포시"},
                {"text": "광양시", "value": "광양시"},
                {"text": "나주시", "value": "나주시"},
                {"text": "무안군", "value": "무안군"},
                {"text": "해남군", "value": "해남군"},
                {"text": "고흥군", "value": "고흥군"},
                {"text": "화순군", "value": "화순군"},
                {"text": "영암군", "value": "영암군"},
                {"text": "영광군", "value": "영광군"},
                {"text": "완도군", "value": "완도군"},
                {"text": "담양군", "value": "담양군"},
                {"text": "장성군", "value": "장성군"},
                {"text": "보성군", "value": "보성군"},
                {"text": "신안군", "value": "신안군"},
                {"text": "장흥군", "value": "장흥군"},
                {"text": "강진군", "value": "강진군"},
                {"text": "함평군", "value": "함평군"},
                {"text": "진도군", "value": "진도군"},
                {"text": "곡성군", "value": "곡성군"},
                {"text": "구례군", "value": "구례군"}
            ],
    "jeju": [    
                {"text": "제주시", "value": "제주시"},
                {"text": "서귀포시", "value": "서귀포시"}
            ]
};

$(function() {
		// 드롭다운의 선택변경 이벤트
		$("#drop_city").change(function() {
			// 결과가 표시될 #drop_gu에 내용 삭제
			$("#drop_gu").empty();
			// 사용자 선택값 가져오기
			var region = $("#drop_city option:selected").val();
			// 선택값이 없다면 중단
			if (region == null) {
				return false;
			} else if (region == "서울특별시") {
				// 서울 지역 시/구 드롭다운
			var html = "";
			for (var i=0; i<data.seoul.length; i++) {
				html += "<option value=" + data.seoul[i].text + ">" + "&nbsp;" + data.seoul[i].value + "</option>\n";
			}
				$("#drop_gu").html(html);
			} else if (region == "부산광역시") {
				// 부산 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.busan.length; i++) {
					html += "<option value=" + data.busan[i].text + ">" + "&nbsp;" + data.busan[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "인천광역시") {
				// 인천 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.incheon.length; i++) {
					html += "<option value=" + data.incheon[i].text + ">" + "&nbsp;" + data.incheon[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "대구광역시") {
				// 대구 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.daegu.length; i++) {
					html += "<option value=" + data.daegu[i].text + ">" + "&nbsp;" + data.daegu[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "광주광역시") {
				// 광주 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.gwangju.length; i++) {
					html += "<option value=" + data.gwangju[i].text + ">" + "&nbsp;" + data.gwangju[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "대전광역시") {
				// 대전 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.daejeon.length; i++) {
					html += "<option value=" + data.daejeon[i].text + ">" + "&nbsp;" + data.daejeon[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "울산광역시") {
				// 울산 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.ulsan.length; i++) {
					html += "<option value=" + data.ulsan[i].text + ">" + "&nbsp;" + data.ulsan[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "세종특별자치시") {
				// 세종 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.sejong.length; i++) {
					html += "<option value=" + data.sejong[i].text + ">" + "&nbsp;" +data.sejong[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "경기도") {
				// 경기 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.gyeonggi.length; i++) {
					html += "<option value=" + data.gyeonggi[i].text + ">" + "&nbsp;" + data.gyeonggi[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "강원도") {
				// 강원 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.gangwon.length; i++) {
					html += "<option value=" + data.gangwon[i].text + ">" + "&nbsp;" + data.gangwon[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "충청북도") {
				// 충북 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.chungbuk.length; i++) {
					html += "<option value=" + data.chungbuk[i].text + ">" + "&nbsp;" + data.chungbuk[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "충청남도") {
				// 충남 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.chungnam.length; i++) {
					html += "<option value=" + data.chungnam[i].text + ">" + "&nbsp;" + data.chungnam[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "경상북도") {
				// 경북 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.gyeongbuk.length; i++) {
					html += "<option value=" + data.gyeongbuk[i].text + ">" + "&nbsp;" + data.gyeongbuk[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "경상남도") {
				// 경남 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.gyeongnam.length; i++) {
					html += "<option value=" + data.gyeongnam[i].text + ">" + "&nbsp;" + data.gyeongnam[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "전라북도") {
				// 전북 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.jeonbuk.length; i++) {
					html += "<option value=" + data.jeonbuk[i].text + ">" + "&nbsp;" + data.jeonbuk[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "전라남도") {
				// 전남 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.jeonnam.length; i++) {
					html += "<option value=" + data.jeonnam[i].text + ">" + "&nbsp;" + data.jeonnam[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			} else if (region == "제주특별자치도") {
				// 제주 지역 시/구 드롭다운
				var html = "";
				for (var i=0; i<data.jeju.length; i++) {
					html += "<option value=" + data.jeju[i].text + ">" + "&nbsp;" + data.jeju[i].value + "</option>\n";
				}
					$("#drop_gu").html(html);
			}
		});
	});