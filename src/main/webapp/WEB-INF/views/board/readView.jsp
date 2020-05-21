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
			var formObj = $("form[name='readForm']");
			
			// 수정 
			$(".update_btn").on("click", function(){
				formObj.attr("action", "/board/updateView");
				formObj.attr("method", "get");
				formObj.submit();				
			})
			
			// 삭제
			$(".delete_btn").on("click", function(){
				/* var count ="${count}";
				
				if(count > 0){
					alert("댓글이 있는 게시물은 삭제가 불가능 합니다.")
					return;
				} */
				var deleteYN = confirm("삭제하시겠습니까?");
				if(deleteYN == true){
						formObj.attr("action", "/board/delete");
						formObj.attr("method", "post");
						formObj.submit();
					//}
				}
			})
			
			// 목록
			$(".list_btn").on("click", function(){
				
				location.href = "/board/list?page=${scri.page}"
						      +"&perPageNum=${scri.perPageNum}"
						      +"&searchType=${scri.searchType}&keyword=${scri.keyword}";
			})
			
			//댓글 작성
			$(".replyWriteBtn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				var formObj = $("form[name='replyForm']");
				formObj.attr("action", "/board/replyWrite");
				formObj.submit();
			});
			
			//댓글 작성
			function fn_valiChk(){
				var regForm = $("form[name='replyForm'] .chk").length;
				for(var i = 0; i<regForm; i++){
					if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
						alert($(".chk").eq(i).attr("title"));
						return true;
					}
				}
			}
			
			//댓글 수정 View
			$(".replyUpdateBtn").on("click", function(){
				location.href = "/board/replyUpdateView?bno=${read.bno}"
								+ "&page=${scri.page}"
								+ "&perPageNum=${scri.perPageNum}"
								+ "&searchType=${scri.searchType}"
								+ "&keyword=${scri.keyword}"
								+ "&rno="+$(this).attr("data-rno");
			});
			
			//댓글 삭제 View
			$(".replyDeleteBtn").on("click", function(){
				location.href = "/board/replyDeleteView?bno=${read.bno}"
					+ "&page=${scri.page}"
					+ "&perPageNum=${scri.perPageNum}"
					+ "&searchType=${scri.searchType}"
					+ "&keyword=${scri.keyword}"
					+ "&rno="+$(this).attr("data-rno");
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
					
					<c:if test='${member.userId == read.writer or member.userId== "123"}'>
						<div style="float: right;">
							<button type="button" class="update_btn btn btn-warning">수정</button>
							<button type="button" class="delete_btn btn btn-danger">삭제</button>
						</div>
					</c:if>
					
					
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
									<c:if test='${member.userId == replyList.writer or member.userId== "123"}'>
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