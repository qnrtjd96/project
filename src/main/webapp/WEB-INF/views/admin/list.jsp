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
	<body>
		<div class="container">
			<header>
				<h1 style= "font-size: 50;">블로그-관리자</h1>
			</header>
			
			<script type="text/javascript">
			 $(document).ready(function(){
				var formObj = $("form[name='memberForm']");
				
				// 회원 삭제
				$(".delete_btn").on("click", function(){
					var deleteYN = confirm("삭제하시겠습니까?");
					if(deleteYN == true){
						
					formObj.attr("action", "/admin/delete");
					formObj.attr("method", "post");
					formObj.submit();
						
					}
				});
			}); 
			 
			 
			
			/* function deleteUser(String userId){
				var deleteYN = confirm("삭제하시겠습니까?");
				if(deleteYN == true){
					form.submit();	
				}	
			}; */
				
			</script>
			
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			
			<section id="container">
				<form role="form" method="get" name="memberForm">
					<table class="table table-hover">
						<thead>
							<tr><th>아이디</th><th>비밀번호</th><th>이름</th><th>등록일</th><th>등급</th><th>삭제</th></tr>
						</thead>
						
						<c:forEach items="${list}" var = "list">
							<tr>
								<td><c:out value="${list.userId}" /></td>
								<td><c:out value="${list.userPass}" /></td>
								<td><c:out value="${list.userName}" /></td>
								<td><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd"/></td>
								<td><c:out value="${list.grade}"></c:out></td>
								<td><button type="button" class="delete_btn btn btn-danger" onclick="deleteUser(${list.userId});">삭제</button></td>
							</tr>
						</c:forEach>
					</table>
				</form>
			</section>
		</div>
	</body>
</html>