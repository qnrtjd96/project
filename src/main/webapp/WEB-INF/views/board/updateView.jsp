<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- jstl을 사용하기위한 태그 라이브러리 -->
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
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			//취소버튼을 클릭했을때
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/readView?bno=${update.bno}"
					   + "&page=${scri.page}"
					   + "&perPageNum=${scri.perPageNum}"
					   + "&searchType=${scri.searchType}"
					   + "&keyword=${scri.keyword}";
			})
			
			//업그레이드 버튼을 클릭했을때
			$(".update_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board/update");
				formObj.attr("method", "post");
				formObj.submit();
			})
		})
		
		//fn_valiChk버튼에 대한 펑션
		function fn_valiChk(){
			var updateForm = $("form[name='updateForm'] .chk").length;
			for(var i = 0; i<updateForm; i++){//반복문
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){ //클래스의 i번째가 공백이거나 null이면
					alert($(".chk").eq(i).attr("title")); //i번째의 타이틀을 출력한다
					return true;
				}
			}
		}
		
	</script>
	<body>
	<article>
		<div id="root" class="container">
		<div id="root">
			<header>
				<h1 style="font-size: -webkit-xxx-large;">project</h1>
			</header>
			<hr />
			 
			<div>
				<div>
					<%@include file="nav.jsp" %>
				</div>
			</div>
			<hr />
			
			<div class='table-responsive'>
			<section id="container">
				<form name="updateForm" role="form" method="post" action="/board/update">
					<input type="hidden" name="bno" value="${update.bno}" readonly="readonly"/>
					<table class="table table-striped table-sm">
						<tbody>
							<tr>
								<td>
									<label for="title">제목</label><input type="text" id="title" name="title" classs="chk" title="제목을 입력하세요" value="${update.title}" style="height: 10%; width: 100%;"/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="content">내용</label><textarea id="content" name="content" classs="chk" title="내용을 입력하세요" style="height: 300; width: 100%;"><c:out value="${update.content}" /></textarea>
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer">작성자</label><input type="text" id="writer" name="writer" classs="chk" title="작성자을 입력하세요" value="${update.writer}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>
									<label for="regdate">작성날짜</label>
									<fmt:formatDate value="${update.regdate}" pattern="yyyy-MM-dd a hh:mm"/>					
								</td>
							</tr>		
						</tbody>			
					</table>
					<div>
						<button type="submit" class="update_btn" style="font-size: large;">저장</button>
						<button type="submit" class="cancel_btn" style="font-size: large;">취소</button>
					</div>
				</form>
			</section>
			</div>
			<hr />
		</div>
		</div>
		</article>
	</body>
</html>