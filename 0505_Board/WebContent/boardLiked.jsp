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
	
	BoardDto boardDto = new BoardDto();
	boardDto.setSeq(seq);
	
	BoardDao boardDao = new BoardDao();
	int result = boardDao.updateBoardLiked(boardDto);
	
	if(result > 0){
		out.println("<script>alert('좋아요 되었습니다.')</script>");
		out.println("<script>location.href='boardDetail.jsp?seq="+seq+"'</script>");
	}
	else {
		out.println("<script>alert('업데이트에 실패하였습니다.')</script>");
		out.println("<script>location.href='boardDetail.jsp?seq="+seq+"'</script>");
	}
	
%>
