<%@page import="board.dao.BoardDao"%>
<%@page import="board.dto.BoardDto"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");

	String keyword = "";
	if(request.getParameter("keyword") != null){
		keyword = request.getParameter("keyword");
	}

	int pageSize = 7; // 한 페이지에 출력할 레코드 수
	
	// 페이지 링크를 클릭한 번호 / 현재 페이지
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null){ // 클릭한게 없으면 1번 페이지
		pageNum = "1";
	}
	// 연산을 하기 위한 pageNum 형변환 / 현재 페이지
	int currentPage = Integer.parseInt(pageNum);
	
	// 해당 페이지에서 시작할 레코드 / 마지막 레코드
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	int count = 0;
	BoardDao boardDao = new BoardDao();
	count = boardDao.getBoardCount(keyword); // 데이터베이스에 저장된 총 갯수
	
	List<BoardDto> list = null;
	if (count > 0) {
		// getList()메서드 호출 / 해당 레코드 반환
		list = boardDao.getBoardList(startRow, endRow, keyword);
	}
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
							<input type="text" class="form-control" placeholder="Search" id="keyword" value="<%=keyword%>">
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
					<th style="text-align: center;">글번호</th>
					<th style="text-align: center;" >타이틀</th>
					<th style="text-align: center;">작성자</th>
					<th style="text-align: center;">작성일</th>
				</tr>
			</thead>
			<tbody align="center">
			
				<%
				if (count > 0){ 
					int number = count - (currentPage - 1) * pageSize; // 글 번호 순번 
					for (BoardDto board : list){
				%>
				<tr>
					<td><%=number-- %></td>
					<td><a href="boardDetail.jsp?seq=<%=board.getSeq()%>"><%=board.getTitle() %></a></td>
					<td><%=board.getWriter() %></td>
					<td><%=board.getReg_dtm() %></td>
				</tr>
				<%}
				} else { %>
				<tr>
					<td colspan="4" align="center">게시글이 없습니다.</td>
				</tr>
				<%} %>
				<tr>
					<td colspan="4" align="right">
						<%-- 버튼을 클릭하면 writeForm.jsp로 이동 --%>
						<input type="button" value="글작성"
						onclick="location.href='boardInsertForm.jsp'">
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<ul class="pagination">
						
						<%	// 페이징  처리
							if(count > 0){
								// 총 페이지의 수
								int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1);
								// 한 페이지에 보여줄 페이지 블럭(링크) 수
								int pageBlock = 10;
								// 한 페이지에 보여줄 시작 및 끝 번호(예 : 1, 2, 3 ~ 10 / 11, 12, 13 ~ 20)
								int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
								int endPage = startPage + pageBlock - 1;
								
								// 마지막 페이지가 총 페이지 수 보다 크면 endPage를 pageCount로 할당
								if(endPage > pageCount){
									endPage = pageCount;
								}
								
								if(startPage > pageBlock){ // 페이지 블록수보다 startPage가 클경우 이전 링크 생성
						%>
									<li class="active"><a href="boardList.jsp?pageNum=<%=startPage - 10%>&keyword=<%=keyword%>">[이전]</a></li>	
						<%			
								}
								
								for(int i=startPage; i <= endPage; i++){ // 페이지 블록 번호
									if(i == currentPage){ // 현재 페이지에는 링크를 설정하지 않음
						%>
										<li class="disabled"><a href="#"><%=i%></a></li>
						<%									
									}else{ // 현재 페이지가 아닌 경우 링크 설정
						%>
										<li class="active"><a href="boardList.jsp?pageNum=<%=i%>&keyword=<%=keyword%>"><%=i %></a></li>
						<%	
									}
								} // for end
								
								if(endPage < pageCount){ // 현재 블록의 마지막 페이지보다 페이지 전체 블록수가 클경우 다음 링크 생성
						%>
									<li class="active"><a href="boardList.jsp?pageNum=<%=startPage + 10 %>&keyword=<%=keyword%>">다음</a></li>
						<%			
								}
							}
						%>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>