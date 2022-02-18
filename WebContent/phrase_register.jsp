<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>문구 등록</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
		function checkValue(){
        	if(!document.phraseInfo.phrase.value){
            	alert("문구를 입력하세요.");
            	return false;
        	}
        	
        	if(!document.phraseInfo.keyword.value){
            	alert("키워드를 입력하세요.");
            	return false;
        	}
        	
        	if(!document.phraseInfo.explain.value){
            	alert("설명을 입력하세요.");
            	return false;
        	}
        	
        	if(!document.phraseInfo.memo.value){
            	alert("메모를 입력하세요.");
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
	<h1>문구 등록</h1>
	<form action="phrase_person_choice.jsp" method="post" name="phraseInfo" onsubmit="return checkValue()">
	
		<br>
		<b>문구</b> 
		<br>
		<input type = "text" name = "phrase" maxlength="100" placeholder="50자 미만으로 입력해주세요."> 
		<br>
		<br>
		<b>카테고리 :</b> 
			<select name = "category">
				<option value="사랑">사랑</option><option value="이별">이별</option>
				<option value="노력">노력</option><option value="유머">유머</option>
				<option value="감동">감동</option><option value="기타">기타</option>
			</select>
		<br>
		<br>
		<b>키워드</b> 
		<br>
		<input type = "text" name = "keyword" maxlength="10"> 
		<br>
		<br>
		<b>설명</b> 
		<br>
		<input type = "text" name = "explain" maxlength="50"> 
		<br>
		<br>
		<b>메모</b> 
		<br>
		<input type = "text" name = "memo" maxlength="30"> 
		<br>
		<br>
		<b>공유 여부</b>
		<br>
		<input type = "radio" name = "share" value = "YES">YES
		<input type = "radio" name = "share" value = "NO">NO
		<br>
		<br>
		<button type="submit">문구에 인물 등록하기</button>
		<button type="button" onclick="goMainPage()">돌아가기</button>
	</form>
</div>
</body>
</html>