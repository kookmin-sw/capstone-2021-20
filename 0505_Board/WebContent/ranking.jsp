<%@page import="board.dao.BoardDao"%>
<%@page import="board.dto.BoardDto"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	BoardDao boardDao = new BoardDao();
	
	List<BoardDto> list = null;
	list = boardDao.getBoardRankList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>소프트웨어 사용자 입력 사전</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
</head>
<body>
	<div style="background: black; color: white;">
		<h1 style="margin: 0px; padding: 10px;">Software 사용자 입력 사전</h1>
	</div>
	<div>
		<nav class="navbar navbar-default">
			<div class="container-fluid">
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li><a href="index.jsp">로그인/로그아웃</a></li>
						<li class="active"><a href="ranking.jsp">랭킹</a></li>
						<li><a href="liked_ranking.jsp">좋아요</a></li>
						<li><a href="boardList.jsp">게시판</a></li>
					</ul>
					<form class="navbar-form navbar-right">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Search" id="keyword" >
						</div>
						<button type="button" class="btn btn-default" onclick="search();">Search</button>
					</form>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>
	</div>
	<div>
		<table class="table">
			<thead >
				<tr >
					<th style="text-align: center;">순위</th>
					<th style="text-align: center;">작성자</th>
					<th style="text-align: center;">작성글 개수</th>
				</tr>
			</thead>
			<tbody align="center">
			
				<%
				if (list.size() > 0){ 
					int i = 1;
					for (BoardDto board : list){
				%>
				<tr>
					<%if (i == 1) {%>
					<td><img src="./img/Gold Trophy.PNG" width="20px;"></td>
					<% i++;} else if (i == 2) { %>
					<td><img src="./img/Silver Trophy.PNG" width="20px;"></td>
					<% i++;} else if (i == 3) { %>
					<td><img src="./img/Bronze Trophy.PNG" width="20px;"></td>
					<% i++;} else {%>
					<td><%=i++ %></td>
					<%} %>
					<td><%=board.getWriter() %></td>
					<td><%=board.getCount() %></td>
				</tr>
				<%}
				} else { %>
				<tr>
					<td colspan="4" align="center">게시글이 없습니다.</td>
				</tr>
				<%} %>
			
			</tbody>
		</table>
	</div>
</body>
</html>