<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload"%>
<%@page import="java.util.Collections"%>
<%@page import="com.google.api.client.json.gson.GsonFactory"%>
<%@page import="com.google.api.client.json.*"%>
<%@page import="com.google.api.client.http.javanet.NetHttpTransport"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.google.api.client.googleapis.auth.oauth2.*" %>
<%
	final String CLIENT_ID = "876119375074-n01s0t7pf6bnlvsehhkmvsvslku905ft.apps.googleusercontent.com";
	String idToken = request.getParameter("idToken");
	String clId = request.getParameter("clId");
	
	final NetHttpTransport transport = new NetHttpTransport();
	final JsonFactory jsonFactory = new GsonFactory();
	
	GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jsonFactory)
		    // Specify the CLIENT_ID of the app that accesses the backend:
		    .setAudience(Collections.singletonList(CLIENT_ID))
		    // Or, if multiple clients access the backend:
		    //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
		    .build();
	
	GoogleIdToken gIdToken = verifier.verify(idToken);
	
	response.setContentType("application/json");
	PrintWriter writer = response.getWriter();
	JsonObject jsonObject = new JsonObject();
			  
	if (gIdToken != null) {
		Payload payload = gIdToken.getPayload();

		// Print user identifier
		String userId = payload.getSubject();
		System.out.println("User ID: " + userId);

		// Get profile information from payload
		String email = payload.getEmail();
		boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
		String name = (String) payload.get("name");
		String pictureUrl = (String) payload.get("picture");
		String locale = (String) payload.get("locale");
		String familyName = (String) payload.get("family_name");
		String givenName = (String) payload.get("given_name");
		
		System.out.println(name);
		jsonObject.addProperty("auth", "1");
		
		session.setAttribute("auth", email);
		

	} else {
		System.out.println("Invalid ID token.");
		jsonObject.addProperty("auth", "0");
	}
	writer.print(jsonObject);
	writer.flush();
%>