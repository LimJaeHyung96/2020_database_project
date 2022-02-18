<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>인물 등록</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
		function checkValue(){
        	if(!document.personInfo.name.value){
            	alert("인물 이름를 입력하세요.");
            	return false;
        	}
        
        	if(!document.personInfo.nation.value){
            	alert("국적을 입력하세요.");
            	return false;
        	}
        
        	if(!document.personInfo.job.value){
            	alert("직업을 입력하세요.");
            	return false;
        	}
        	
        	if(!document.personInfo.year.value){
            	alert("출생년도를 입력하세요.");
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
	<h1>인물 등록</h1>
	<h2>모든 정보를 기록해주세요!</h2>
	<form action="personregister_result.jsp" method="post" name="personInfo" onsubmit="return checkValue()">
	
		<br>
		<b>인물 이름</b> 
		<br>
		<input type = "text" name = "name" maxlength="50" placeholder="50자 미만으로 입력해주세요."> 
		<br>
		<br>
		<b>국적</b> 
		<br>
		<input type = "text" name = "nation" maxlength="10">
		<br>
		<br>
		<b>직업</b>
		<br>
		<input type = "text" name = "job" maxlength="10">
		<br>
		<br>
		<b>출생년도</b>
		<br>
		<input type="text" name="year"/>
		<br>
		<br>
		<button type="submit">등록</button>
		<button type="button" onclick="goMainPage()">돌아가기</button>
	</form>
</div>
</body>
</html>