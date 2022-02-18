<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>문구 데이터베이스 회원가입</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
		function checkValue(){
        	if(!document.userInfo.id.value){
            	alert("아이디를 입력하세요.");
            	return false;
        	}
        
        	if(!document.userInfo.password.value){
            	alert("비밀번호를 입력하세요.");
            	return false;
        	}
        
        	// 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
        	if(document.userInfo.password.value != document.userInfo.passwordcheck.value ){
            	alert("비밀번호를 동일하게 입력하세요.");
            	return false;
        	}
        	
        	if(!document.userInfo.birth.value){
            	alert("생년월일을 입력하세요.");
            	return false;
        	}
        	
        	if(!document.userInfo.address.value){
            	alert("주소를 입력하세요.");
            	return false;
        	}
        }
		
		function goJoinForm() {
			location.href="loginpage.jsp";
	    }    
	   </script>
</head>
<body bgcolor = "white">
<div id="wrap">
	<h1>회원가입</h1>
	<h2>모든 정보를 기록해주세요!</h2>
	<form action="register_result.jsp" method="post" name="userInfo" onsubmit="return checkValue()">
	
		<br>
		<b>ID</b> 
		<br>
		<input type = "text" name = "id" maxlength="20" placeholder="20자 미만으로 입력해주세요."> 
		<br>
		<br>
		<b>PASSWORD</b> 
		<br>
		<input type = "password" name = "password" maxlength="20" placeholder="20자 미만으로 입력해주세요.">
		<br>
		<br>
		<b>PASSWORD 확인</b>
		<br>
		<input type = "password" maxlength="20">
		<br>
		<br>
		<b>이름</b>
		<br>
		<input type = "text" name = "name" maxlength="30">
		<br>
		<br>
		<b>성별</b>
		<br>
		<input type = "radio" name = "gender" value = "남">남
		<input type = "radio" name = "gender" value = "여">여
		<br>
		<br>
		<b>생년월일</b>
		<br>
		<input type="text" name="birth" placeholder="yyyy-mm-dd"/>
		<br>
		<br>
		<b>주소</b>
		<br>
		<input type = "text" name = "address" maxlength="15" placeholder="15자 미만으로 입력해주세요.">
		<br>
		<br>
		<button type="submit">가입</button>
		<button type="button" onclick="goJoinForm()">취소</button>
	</form>
</div>
</body>
</html>