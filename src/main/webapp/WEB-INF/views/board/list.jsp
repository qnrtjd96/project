<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- jstl사용하려면 추가해야대는 라이브러리 -->
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
				<h1 style="font-size: -webkit-xxx-large;">project</h1>
			</header>
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			
			<section id="container">
				<form role="form" method="get">
					<table class="table table-hover">
						<thead>
							<tr><th>번호</th><th>제목</th><th>작성자</th><th>등록일</th></tr>
						</thead>
						<c:forEach items="${list}" var ="list"> <!--list를 출력해주는 jstl문(배열요소를 순서대로 반복적으로 처리할수 있음)  -->
							<tr>
								<td><c:out value="${list.bno}" /></td><!-- 번호칸에들어감 list.bno list 객체의 bno를 뽑아준다. -->
								<!--
								페이징 유지를 위한 수정값 
								get방식으로 보내는것을 볼 수 있으며(URL형식) 코드가 길어졋지만 
								list객체의 title을 뽑아주는것을 볼 수 있음 
								-->
								<td>
									<a href="/board/readView?bno=${list.bno}&page=${scri.page}&perPageNum=${scri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}"><c:out value="${list.title}" /></a>
								</td>
								<!-- list객체의 작성자를 뽑아준다. -->
								<td><c:out value="${list.writer}" /></td>
								<!-- list객체의 regdate를 뽑아주는대 패턴은 yyyy-mm-dd a(오전오후) hh:mm 이다.  -->
								<td><fmt:formatDate value="${list.regdate}" pattern="yyyy-MM-dd a hh:mm"/></td>
							</tr>
						</c:forEach>
						
					</table>
					<div class="search row">
						<div class="col-xs-2 col-sm-2">
							<select name="searchType" class="form-control">
							<!--   -->
								<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
								<option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
								<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
								<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
								<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
							</select>
						</div>
						 
						<div class="col-xs-10 col-sm-10">
							<div class="input-group">
							<!-- 키워드를 통해서 검색을 진행한다 -->
								<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
								<span class="input-group-btn">
									<button id="searchBtn" type="button" class="btn btn-default">검색</button> 	
								</span>
							</div>
						</div>
						 
						<script>
						//searchBtn를 눌렀을때, list, pageMaker.makeQuery+searchType과 select의 값과 키워드의 값을 넣어서  self.location으로 url을 호출한다.
							 $(function(){$('#searchBtn').click(function() {
									 self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
								 });
							 });   			 
						</script>
					</div>
					<div class="col-md-offset-3" style="padding-left: 100px;">
						<ul class="pagination">
							<!-- 이전페이지 -->
							<c:if test="${pageMaker.prev}">
								<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
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
	</body>
</html>