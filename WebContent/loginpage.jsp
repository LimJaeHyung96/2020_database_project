<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>문구DB 로그인</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
   <script type="text/javascript">
    
        function checkValue()
        {
            if(!document.loginInfo.id.value){
            	alert("아이디를 입력하세요");
            	return false;
        	}
            if(!document.loginInfo.password.value){
                alert("비밀번호를 입력하세요");    
                return false;
            }
        }
    
        function goJoinForm() {
            location.href="register_form.jsp";
        }    
    </script>

</head>
<body>
<div id="wrap">
 	<h1>로그인</h1>
 	<h2>환영합니다.</h2>
 	<form name = "loginInfo" method="post" action="login_result.jsp" onsubmit="return checkValue()">
 		<br>
 		<b>ID</b>
 		<br>
 		<input type = "text" name = "id" maxlength="20">
 		<br>
 		<b>PASSWORD</b>
 		<br>
 		<input type = "password" name = "password" maxlength="20">
 		<br>
 		<br>
 	<button type="submit">로그인</button>
 	<button type="button" onclick="goJoinForm()">회원가입</button>
 	</form>
</div>
</body>
</html>