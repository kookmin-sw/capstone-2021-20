<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="google-signin-client_id" content="876119375074-n01s0t7pf6bnlvsehhkmvsvslku905ft.apps.googleusercontent.com">
<title>소프트웨어 사용자 입력 사전</title>
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=onLibraryLoaded" async defer></script>
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/custom.js"></script>
</head>
<body>
	<div style="text-align: center;">
		<h1>소프트웨어 사용자 입력 사전에 오신 것을 환영합니다!</h1>
		<h2>이 곳에서는 여러분들의 소프트웨어 용어 및 지식들을 배워갈 수 있습니다!</h2>
		<br><br>
		<% if(session.getAttribute("auth") == null){ %>
		<div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"  data-width="240" data-height="60" style="text-align: center; display: inline-block;" onclick="init()"></div>
		<% } else {%>
		<div class="row" >
			<div id="customBtn" class="customGPlusSignIn" onclick="signOut()"
				style="text-align: center; display: inline-block;">
				<span class="icon"></span> <span class="buttonText">로그아웃</span>
			</div>
			<div style="margin: 20px;"> <input class="btn btn-default" type="button" value="메인으로 이동" onclick="location.href='main.jsp'"></div>
		</div>
		
		<%
					}
				%>
	</div>
	
</body>
<script type="text/javascript">
function onLibraryLoaded() {
	console.log(gapi.auth2);
    gapi.load('auth2', function() {
        gapi.auth2.init({
            client_id: '876119375074-n01s0t7pf6bnlvsehhkmvsvslku905ft.apps.googleusercontent.com',
            scope: 'profile'
        })
    })
}

function signOut(){
    var auth2 = gapi.auth2.getAuthInstance();
    
    $.ajax({
		// type을 설정합니다.
		type : 'POST',
		url : "logOut.jsp",
		dataType : 'json',
		success : function(data) {
			console.log(data);
			if(data.code){
				if(data.code == 200){
					alert('로그아웃되었습니다.');
					auth2.signOut().then(function () {
						console.log('User signed out.');
						
					});
					//auth2.disconnect();
					location.reload();
				} else {
					location.reload();
				}
			}
		}
	});
}
 function init(){
	 //localStorage.clear();
} 
function onSignIn(googleUser) {
//	onLibraryLoaded();
	
	console.log(gapi.auth2.isSignedIn);
	console.log(googleUser);
	
	//var tkId = googleUser.xc.id_token;
	var clId = '876119375074-n01s0t7pf6bnlvsehhkmvsvslku905ft.apps.googleusercontent.com';
	//var clId = '129576415424-mtedmbigqff6h6vijrknhoep8uq8pjhh.apps.googleusercontent.com';

	console.log(googleUser.getAuthResponse().id_token);
	var tkId = googleUser.getAuthResponse().id_token;
	var profile = googleUser.getBasicProfile();
	console.log(profile);
	console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
	console.log('Name: ' + profile.getName());
	console.log('Image URL: ' + profile.getImageUrl());
	console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
	
	$.ajax({
			// type을 설정합니다.
			type : 'POST',
			url : "loginCheck.jsp",
			data : {
				"idToken" : tkId,
				"clId" : clId
			},
			dataType : 'json',
			success : function(data) {
				console.log(data);
				if(data.auth){
					if(data.auth == 1){
						alert('인증되었습니다.');
						  gapi.load('auth2', function() {
						        gapi.auth2.signIn().then(function(googleUser) {
						        	console.log('user signed in');
						        	//location.href = 'main.jsp';
						        }, function(error) {
						        	console.log('user failed to sign in');
						        })
						    })
						location.reload();
					} else {
						location.reload();
					}
				}
				
			}

		});
	}

</script>
<style type="text/css">
    #customBtn {
      display: inline-block;
      background: white;
      color: #444;
      width: 190px;
      border-radius: 5px;
      border: thin solid #888;
      box-shadow: 1px 1px 1px grey;
      white-space: nowrap;
    }
    #customBtn:hover {
      cursor: pointer;
    }
    span.label {
      font-family: serif;
      font-weight: normal;
    }
    span.icon {
      background: url('img/g-normal.png') transparent 5px 50% no-repeat;
      display: inline-block;
      vertical-align: middle;
      width: 42px;
      height: 42px;
    }
    span.buttonText {
      display: inline-block;
      vertical-align: middle;
      padding-left: 42px;
      padding-right: 42px;
      font-size: 14px;
      font-weight: bold;
      /* Use the Roboto font that is loaded in the <head> */
      font-family: 'Roboto', sans-serif;
    }
  </style>
</html>