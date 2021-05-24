<%@page import="board.dao.BoardDao"%>
<%@page import="board.dto.BoardDto"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf-8");

	//"auth" 라는 세션이 없으면(인증이 되어있지 않으면) 메인 페이지로 이동
	if (session.getAttribute("auth") != null){
		
	} else {
		out.println("<script>alert('로그인이 필요합니다.')</script>");
		out.println("<script>location.href='main.jsp'</script>");
		return;
	}

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
		<form action="boardUpdate.jsp" method="post">
			<input type="hidden" name="seq" value="<%=boardDto.getSeq()%>">
			<div class="row">
				<div class="col-sm-12">
					<h2>게시물 수정하기</h2>
				</div>
			</div>
			<hr>
			<div class="row" style="font-size: 20px; margin: 20px;">
				<div class="col-sm-6" style="text-align: center;">제목</div>
				<div class="col-sm-6 form-group"><input type="text" class="form-control" name="title" placeholder="제목을 입력하세요" value="<%=boardDto.getTitle()%>"></div>
			</div>
			<div class="row" style="font-size: 20px; margin: 20px;">	
				<div class="col-sm-6" style="text-align: center;">내용</div>
				<div class="col-sm-6"><textarea class="form-control" cols="30" rows="10" name="content"><%=boardDto.getContent() %></textarea></div>
			</div>
			
			<div class="row" style="font-size: 20px; margin-top: 40px; text-align: center;">	
				<input class="btn btn-default" type="submit" value="수정완료">
				<input class="btn btn-default" type="button" value="삭제" onclick="location.href='boardDelete.jsp?seq=<%=boardDto.getSeq()%>'">
			</div>
		</form>
	</div>

</body>
</html>