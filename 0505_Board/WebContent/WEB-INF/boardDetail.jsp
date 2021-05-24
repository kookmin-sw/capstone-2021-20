<%@page import="board.dao.BoardDao"%>
<%@page import="board.dto.BoardDto"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf-8");

	// 페이지 링크를 클릭한 번호 / 현재 페이지
	if (request.getParameter("seq") != null){
		
	} else {
		response.sendRedirect("main.jsp");
	}
	int seq = Integer.parseInt(request.getParameter("seq"));
	BoardDao boardDao = new BoardDao();
	BoardDto boardDto = boardDao.getBoard(seq);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
						<li><a href="ranking.jsp">랭킹</a></li>
						<li><a href="liked_ranking.jsp">좋아요</a></li>
						<li class="active"><a href="boardList.jsp">게시판</a></li>
					</ul>
					<form class="navbar-form navbar-right">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Search" id="keyword">
						</div>
						<button type="button" class="btn btn-default" onclick="search();">Search</button>
					</form>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>

	</div>
	<div class="container" style="margin-top: 30px">
		<input type="hidden" id="seq" value="<%=boardDto.getSeq()%>">
		<div class="row">
			<div class="col-sm-12">
				<h2>게시물 상세보기 
				<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true" style="font-size: 24px; cursor: pointer;" id="liked"></span>
				<span><%= boardDto.getLiked() %> </span>
				</h2>
				
			</div>
		</div>
		<hr>
		<div class="row" style="font-size: 20px; margin: 20px;">
			<div class="col-sm-6" style="text-align: center;">글쓴이</div>
			<div class="col-sm-6"><%=boardDto.getTitle() %></div>
		</div>
		<div class="row" style="font-size: 20px; margin: 20px;">	
			<div class="col-sm-6" style="text-align: center;">등록일시</div>
			<div class="col-sm-6"><%=boardDto.getReg_dtm() %></div>
		</div>
		<div class="row" style="font-size: 20px; margin: 20px;">	
			<div class="col-sm-6" style="text-align: center;">내용</div>
			<div class="col-sm-6"><pre id="contents"><%=boardDto.getContent() %></pre></div>
		</div>
		
		<div class="row" style="font-size: 20px; margin-top: 40px; text-align: center;">	
			<input class="btn btn-default" type="button" value="수정" onclick="location.href='boardUpdateForm.jsp?seq=<%=boardDto.getSeq()%>'">
			<input class="btn btn-default" type="button" value="삭제" onclick="location.href='boardDelete.jsp?seq=<%=boardDto.getSeq()%>'">
		</div>
	</div>

</body>
<script type="text/javascript">
$('#liked').on('click',function(){
	
	var seq = $('#seq').val();
	
	location.href = 'boardLiked.jsp?seq='+seq;
});


</script>
</html>