<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.JsonObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setContentType("application/json");

	session.invalidate();
	PrintWriter writer = response.getWriter();
	JsonObject jsonObject = new JsonObject();
	jsonObject.addProperty("code", "200");
	
	 response.setHeader("Cache-Control","no-cache");
	 response.setHeader("Pragma","no-cache");
	 response.setDateHeader("Expires",0);
	 
	// 전체 쿠키 삭제하기
	Cookie[] cookies = request.getCookies() ;
	if(cookies != null){
		for(int i=0; i < cookies.length; i++){
	    
			// 쿠키의 유효시간을 0으로 설정하여 만료시킨다
			cookies[i].setMaxAge(0) ;
	             
			// 응답 헤더에 추가한다
			response.addCookie(cookies[i]) ;
		}
	}

	
	writer.print(jsonObject);
	writer.flush();
%>