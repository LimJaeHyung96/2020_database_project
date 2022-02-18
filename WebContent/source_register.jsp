<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>출처 등록</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
		function checkValue(){
        	if(!document.sourceInfo.name.value){
            	alert("출처 제목를 입력하세요.");
            	return false;
        	}
        }
		
		function goMainPage() {
			location.href="mainpage.jsp";
	    } 
		
        function goLoginPage() {
            location.href="loginpage.jsp";
        }
	   </script>
</head>
<body bgcolor = "white">
	<%
		String userID = (String)session.getAttribute("id");
	%>
<div>
<input type='button' onclick="goLoginPage()" value='로그아웃' style="float: left;">
<p style="text-align:right; text-decoration:underline" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
	<h1>출처 등록</h1>
	<h2>모든 정보를 기록해주세요!</h2>
	<form action="source_detail_register.jsp" method="post" name="sourceInfo" onsubmit="return checkValue()">
	
		<br>
		<b>출처 제목</b> 
		<br>
		<input type = "text" name = "name" maxlength="50" placeholder="50자 미만으로 입력해주세요."> 
		<br>
		<br>
		<b>종류 :</b> 
			<select name = "genre">
				<option>책</option><option>영화</option>
				<option>노래</option><option>인터넷</option>
				<option>인터뷰</option><option>속담</option>
			</select>
		<br>
		<br>
		<button type="submit">다음으로</button>
		<button type="button" onclick="goMainPage()">돌아가기</button>
	</form>
</div>
</body>
</html>