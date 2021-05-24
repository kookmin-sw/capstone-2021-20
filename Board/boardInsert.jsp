<%@page import="board.dao.BoardDao"%>
<%@page import="board.dto.BoardDto"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf-8");

	// "auth" 라는 세션이 없으면(인증이 되어있지 않으면) 메인 페이지로 이동
	if (session.getAttribute("auth") != null){
		
	} else {
		out.println("<script>alert('로그인이 필요합니다.')</script>");
		out.println("<script>location.href='main.jsp'</script>");
		return;
	}
	
	String writer = (String)session.getAttribute("auth");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDto boardDto = new BoardDto();
	boardDto.setWriter(writer);
	boardDto.setTitle(title);
	boardDto.setContent(content);
	
	BoardDao boardDao = new BoardDao();
	int result = boardDao.insertBoard(boardDto);
	
	if(result > 0){
		out.println("<script>alert('등록되었습니다.')</script>");
		out.println("<script>location.href='boardList.jsp'</script>");
	}
	else {
		out.println("<script>alert('등록에 실패하였습니다.')</script>");
		out.println("<script>location.href='boardList.jsp'</script>");
	}
	
%>
