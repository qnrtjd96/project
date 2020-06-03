<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	
	 	<title>블로그</title>
	</head>
	
	<script type="text/javascript">
		//이름이 reaform인 form을 formObj에 넣어준다.
		$(document).ready(function(){
			//form obj의 변수선언, 이름이readForm의 폼을 넣어준다.
			var formObj = $("form[name='readForm']");
			
			// 수정 
			//수정버튼을 클릭했을때 함수를 호출한다. .은 class를 의미함
			$(".update_btn").on("click", function(){
				
				//이름이 readFrom의 form을 보낸다.
				//attr의 메서드는 속성값을 가져오거나 추가하는 메소드임
				formObj.attr("action", "/board/updateView");
				formObj.attr("method", "get"); //메소드는 get으로
				formObj.submit();
			});
			
			// 삭제
			$(".delete_btn").on("click", function(){
				/* var count ="${count}"; //변수count를 
					if(count > 0){
						alert("댓글이 있는 게시물은 삭제할 수 없습니다.")
						return;
					} */
					
				var deleteYN = confirm("삭제하시겠습니까?");
				if(deleteYN == true){
						formObj.attr("action", "/board/delete");
						formObj.attr("method", "post");
						formObj.submit();
						}
			});
			
			// 목록
			$(".list_btn").on("click", function(){
				location.href = "/board/list?page=${scri.page}"
						      +"&perPageNum=${scri.perPageNum}"
						      +"&searchType=${scri.searchType}&keyword=${scri.keyword}"; //url에 이걸 태워서 보낸다. 뒤에 붙어있는건 페이징 유지를 위한 값이다.
			});
			
			//댓글 작성
			$(".replyWriteBtn").on("click", function(){
				if(fn_valiChk()){ //fn_check를 호출해서 값이 맞지 않으면 return한다.
					return false;
				}
				var formObj = $("form[name='replyForm']"); //formObj 다시 선언하기
				formObj.attr("action", "/board/replyWrite");//보낸다 /board/replyWrite로 controller에서 확인가능
				formObj.submit();//submit시킨다.
			});
			
			//댓글 작성
			function fn_valiChk(){ //함수 fn_valiChk를 호출한다.
				var regForm = $("form[name='replyForm'] .chk").length; //regFrom의 변수에 replyFrom을chk하는데, 이것의 길이를 체크한다.
				for(var i = 0; i<regForm; i++){ //반복문 실행
					if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){ //.chk는 댓글내용의 class값이 널이거나(이거나는 ||가 or의 역할을 함), chk가 null이면(공백)이면
						alert($(".chk").eq(i).attr("title")); //타이틀을 alert창을 띄운다.
						
						//여기서 eq(i)는 선택한 요소중에서 전달받은 인덱스에 해당하는 요소를 선택해주는것 즉, 반복문을 실행함으로써, i값을 지정해준것을 볼 수 있음(작성자가 지금은 지정이라서 코딩 오류임 수정해야됨)------------------------ 굳이 반복문을 안써도 됨
						return true; //리턴
					}
				}
			};
			
			//댓글 수정 View
			$(".replyUpdateBtn").on("click", function(){
				location.href = "/board/replyUpdateView?bno=${read.bno}"
								+ "&page=${scri.page}"
								+ "&perPageNum=${scri.perPageNum}"
								+ "&searchType=${scri.searchType}"
								+ "&keyword=${scri.keyword}"
								+ "&rno="+$(this).attr("data-rno");
								//this는 
			});
			//이걸 url에 태워서 보내는대 페이징값을 유지하기위한 값을 전부 보내는것을 알 수 있음,
			//rno의 값은 replyList.rno을 가지고 오는것을 알 수 있다.
			
			//댓글 삭제 View
			$(".replyDeleteBtn").on("click", function(){
				location.href = "/board/replyDeleteView?bno=${read.bno}"
					+ "&page=${scri.page}"
					+ "&perPageNum=${scri.perPageNum}"
					+ "&searchType=${scri.searchType}"
					+ "&keyword=${scri.keyword}"
					+ "&rno="+$(this).attr("data-rno");
					//위와 동일
			});
		})
	</script>
	
	<body>
		<div class="container">
			<header>
				<h1 style="font-size: -webkit-xxx-large;">project</h1>
			</header>
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			<!-- jstl구문으로 member의 id가 널이 아니면 보여준다. -->
			<c:if test="${member.userId != null}">
				<section id="container">
					<!-- 페이징 유지를 위한 hidden값 -->
					<form name="readForm" role="form" method="post">
						<input type="hidden" id="bno" name="bno" value="${read.bno}" />
						<input type="hidden" id="page" name="page" value="${scri.page}"> 
						<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
						<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
						<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
					</form>
					
					<!-- member.userId가 == read.writer랑 같거나, member.userId가 123이면, 목록 수정 삭제를 보여준다. -->
					<c:if test='${member.userId == read.writer or member.grade == "1"}'>
						<div style="float: right;">
							<button type="button" class="update_btn btn btn-warning">수정</button>
							<button type="button" class="delete_btn btn btn-danger">삭제</button>
						</div>
					</c:if>
						<div style="float: right;">
							<button type="button" class="list_btn btn btn-warning">목록</button>
						</div>
					<div class="form-group">
						<label for="title" class="col-sm-2 control-label">제목</label>
						<input type="text" id="title" name="title" class="form-control" value="${read.title}" readonly="readonly" style="height: 10%; width: 100%;"/>
					</div>
					<div class="form-group">
						<label for="content" class="col-sm-2 control-label">내용</label>
						<textarea id="content" name="content" class="form-control" readonly="readonly" style="height: 300; width: 100%;"><c:out value="${read.content}"/></textarea>
					</div>
					<div class="form-group">
						<label for="writer" class="col-sm-2 control-label">작성자</label>
						<input type="text" id="writer" name="writer" class="form-control" value="${read.writer}" readonly="readonly"/>
					</div>
					<div class="form-group">
						<label for="regdate" class="col-sm-2 control-label">작성날짜</label>
						<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd a hh:mm" />	
					</div>
					
					<!-- 댓글 -->
					<div id="reply">
						<ol class="replyList">
							<!-- 배열 뽑아주는 jstl구문 c:forEach -->
							<c:forEach items="${replyList}" var="replyList">
								<li>
									<p>
									작성자 : ${replyList.writer}<br />
									작성 날짜 :  <fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd a hh:mm" />
									</p>
									  
									<p>${replyList.content}</p>
									<!-- 세션에 저장된 member.userId와 replyList.writer 이거나 userid가 123(관리자)일때는 수정삭제가 열린다. -->
									<c:if test='${member.userId == replyList.writer or member.grade== "1"}'>
											<button type="button" class="replyUpdateBtn btn btn-warning" data-rno="${replyList.rno}">수정</button>
											<button type="button" class="replyDeleteBtn btn btn-danger" data-rno="${replyList.rno}">삭제</button>
									</c:if>
								</li>
							</c:forEach>   
						</ol>
					</div>
					
					<!-- 페이징유지를 위한  hidden값 -->
					<form name="replyForm" method="post" class="form-horizontal">
						<input type="hidden" id="bno" name="bno" value="${read.bno}" />
						<input type="hidden" id="page" name="page" value="${scri.page}"> 
						<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
						<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
						<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
					
						<div class="form-group">
							<label for="writer" class="col-sm-2 control-label">댓글 작성자</label>
							<div class="col-sm-10">
								<!-- session에 있는 아이디값을 가져옴 -->
								<input type="text" id="writer" name="writer" class="form-control" value="${member.userId}"  readonly="readonly"/>
							</div>
						</div>
						
						<div class="form-group">
							<label for="content" class="col-sm-2 control-label">댓글 내용</label>
							<div class="col-sm-10">
								<input type="text" id="content" name="content" class="chk form-control" title="내용을 입력해주세요"/>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="button" class="replyWriteBtn btn btn-success">작성</button>
							</div>
						</div>
					</form>
				</section>
			</c:if>
			<c:if test="${member.userId == null}">
				<p style="text-align: center; margin-top: 20px; font-size: 30px;">로그인 후에 게시글을 볼 수 있습니다.</p>
			</c:if>
			<hr />
		</div>
	</body>
</html>