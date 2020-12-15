<%/**
 *@FileName : write-review.jsp
 *@프로그램 설명  : 리뷰쓰는 페이지
 *@작성자 : 정은지 (ejzzang56@gmail.com)
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="../_inc/header.jsp"%>
<!-- ========== 컨텐츠 영역 시작 ========== -->
<style>
.fivestar{margin-top:25px;}
.starR{
  background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
  background-size: auto 100%;
  width: 30px;
  height: 30px;
  display: inline-block;
  text-indent: -9999px;
  cursor: pointer;
}
.starR.on{background-position:0 0;}
.stars{float:left;}
.re{padding-left:45%;}
textarea {
        width: 100%;
        height: 100px;
      }
.hos{margin-left:600px;}
*{margin:0; padding:0;}
</style>
<div class="container" style="min-height:600px;">
<div class="stars">
<div class="fivestar">
별점을 남겨주세요!</div>
<div class="starRev">
  <span class="starR on">별1</span>
  <span class="starR">별2</span>
  <span class="starR">별3</span>
  <span class="starR">별4</span>
  <span class="starR">별5</span>
</div></div>

<div class="hos">
							<small>No.11</small>
                            <h3>은지네 병원</h3>
                            <p class="text-left text-muted">
                                <small>일정| 2020.07.27.(월)</small>
                            </p>
                        </div>
                        
	<form name="join_form" id="join_form" method="post" action="${pageContext.request.contextPath}/write-review/review_ok.do">
		<p>
			<textarea id="content" name="content"
				placeholder="다음 이용자를 위해 방문 시 분위기나 서비스 만족도에 대해 적어 주세요.(5자 이상 30자 이하)"></textarea>
		</p>
		<div class="re">
			<button type="button" class="btn btn-default ">
				<a href="<%=request.getContextPath()%>/my-reserve/reserve-2.do">취소</a>
			</button>
			<button type="submit" class="btn btn-default ">등록</button>
		</div>
	</form>
<!--	<script>
$(document).ready(function() {
    $('#wr-re').on('keyup', function() {
        if($(this).val().length > 30) {
            $(this).val($(this).val().substring(0, 30));
        }
    });
});

$('.starRev span').click(function(){
	  $(this).parent().children('span').removeClass('on');
	  $(this).addClass('on').prevAll('span').addClass('on');
	  return false;
	});
</script>
	<script src="assets/js/regex.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#join_form").submit(function(e) {
				e.preventDefault();
				if(!regex.min_length("#wr-re",5,"내용은 최소 5자 이상 입력 가능합니다.")) {return false;}
					swal({
						text: "등록하시겠습니까?",
						type: "question",
						confirmButtonText: "예",
					}).then(function(result) {
						if (result.value) {
							swal({
								text: "리뷰가 등록되었습니다 3초후 페이지가 이동됩니다",
								type: "success",
								confirmButtonText: "확인",
							})
						}
						setTimeout(function(){
							window.location = "my-reserve.jsp";
					      }, 3000);
					});
			});
		});
	</script>	 -->
</div>
<!--// ========== 컨텐츠 영역 끝 ========== -->
<%@ include file="../_inc/footer.jsp"%>
