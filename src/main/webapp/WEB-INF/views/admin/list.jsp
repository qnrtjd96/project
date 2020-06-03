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
				<h1 style="font-size: -webkit-xxx-large;">project-manager</h1>
			</header>
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			
			<section id="container">
				<form role="form" method="get" name="memberForm">
					<table class="table table-hover">
						<thead>
							<tr><th>번호</th><th>아이디</th><th>비밀번호</th><th>이름</th><th>회원등급</th><th>삭제</th></tr>
						</thead>	
						<c:forEach items="${list}" var = "list">
							<tr>
								<td><c:out value="${list.mno}"/></td>
								<td><c:out value="${list.userId}" /></td>
								<td><c:out value="${list.userPass}" /></td>
								<td><c:out value="${list.userName}" /></td>
								<td><c:out value="${list.grade}"></c:out></td>
								<td><button type="button" class="delete_btn btn btn-danger" id="btnDelete" onclick='deleteUser("${list.userId}");'>삭제</button></td>
							</tr>
						</c:forEach>
					</table>
					<div class="search row">
						<div class="col-xs-2 col-sm-2">
							<select name="searchType" class="form-control">
							<!-- 검색부분이며 데이터가 들어갈때에는 option의 value값이 n t c w tc 의 값을 스크립트로 보내줌-->
								<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
								<option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>아이디</option>
								<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>비밀번호</option>
								<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>이름</option>
								<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>회원등급</option>
							</select>
						</div>
						 
						<div class="col-xs-10 col-sm-10">
							<div class="input-group">
							<!-- 이부분이 원하는 키워드를 적용할 곳 이다. -->
								<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
								<span class="input-group-btn">
									<button id="searchBtn" type="button" class="btn btn-default">검색</button> 	
								</span>
							</div>
						</div>
						 
						<script>
						//searchBtn를 클릭했을때 함수를 호출하는대 그건 아래와 같다.
							 $(function(){$('#searchBtn').click(function() {
								 	 //self.location은 다른 url로 이동시키는 방법 이며  pageMaker의 makeQuery의 메소드에 파라미터 1을 넣어준다. + 옵션의 벨류값을 가져옴 + 키워드인풋의 벨류값을 가져온다. 이것을 url로 보낸다.
									 self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
								 });
							 });   			 
						</script>
					</div>
					<div class="col-md-offset-3" style="padding-left: 100px;">
						<ul class="pagination">
							<!-- 이전페이지 -->
							<!--  -->
							<c:if test="${pageMaker.prev}">
								<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li> <!--  -->
							</c:if> 
							
							<!-- 현재 페이지 -->
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : ''}" />>
								<a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
							</c:forEach>
							
							<!-- 다음페이지 -->
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
							</c:if> 
						</ul>
					</div>
				</form>
			</section>
		</div>
		<script type="text/javascript">
			  function deleteUser(userId){
				var deleteYN = confirm("삭제하시겠습니까?");
				if(deleteYN == true){
					location.href="/admin/delete?userId="+userId;
					}	
				}
		</script>
	</body>
</html>