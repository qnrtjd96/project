<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<head>
	 	<title>블로그</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			//updateView와 동일하다.
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				formObj.attr("action", "/board/write");
				formObj.attr("method", "post");
				formObj.submit();
			});
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
	</script>
	<body>
	  <article>
		<div id="root" class="container">
			<header>
				<h1 style="font-size: -webkit-xxx-large;">project</h1>
			</header>
			<hr />
			
			<div>	
				<%@include file="nav.jsp" %>
			</div>
			<div class='table-responsive'>
			<section id="container">
				<form name="writeForm" method="post" action="/board/write">
					<table class="table table-striped table-sm">
						<tbody>
							<!-- 로그인한 아이디가 널이면 보여지지않는다. -->
							<c:if test="${member.userId != null}">
								<tr>
									<td>
										<label for="title">제목 </label>
										<input type="text" id="title" name="title" class="chk" title="제목을 입력하세요" style="height: 10%; width: 100%;"/>
									</td>
								</tr>	
								<tr>
									<td>
										<label for="content">내용</label>
										<textarea id="content" name="content" class="chk" title="내용을 입력하세요"  style="height: 300; width: 100%;"></textarea>
									</td>
								</tr>
								<tr>
									<td>
										<label for="writer">작성자</label>
										<input type="text" id="writer" name="writer" class="chk" title="작성자 를입력하세요" value="${member.userId}" readonly/>
									</td>
									<td>						
										<button type="submit" class="write_btn">작성</button>
									</td>
								</tr>
							</c:if>
							<!-- 로그인한 아이디가 널이면 밑에 <p>를 출력한다. -->
							<c:if test="${member.userId == null}">
								<p style="text-align: center; margin-top: 20px; font-size: 30px;">로그인 후에 작성하실 수 있습니다.</p>
							</c:if>			
						</tbody>			
					</table>
				</form>
			</section>
		  </div>
			<hr />
		</div>
	  </article>
	</body>
</html>