<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�ι� ���</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
		function checkValue(){
        	if(!document.personInfo.name.value){
            	alert("�ι� �̸��� �Է��ϼ���.");
            	return false;
        	}
        
        	if(!document.personInfo.nation.value){
            	alert("������ �Է��ϼ���.");
            	return false;
        	}
        
        	if(!document.personInfo.job.value){
            	alert("������ �Է��ϼ���.");
            	return false;
        	}
        	
        	if(!document.personInfo.year.value){
            	alert("����⵵�� �Է��ϼ���.");
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
<input type='button' onclick="goLoginPage()" value='�α׾ƿ�' style="float: left;">
<p style="text-align:right; text-decoration:underline" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
	<h1>�ι� ���</h1>
	<h2>��� ������ ������ּ���!</h2>
	<form action="personregister_result.jsp" method="post" name="personInfo" onsubmit="return checkValue()">
	
		<br>
		<b>�ι� �̸�</b> 
		<br>
		<input type = "text" name = "name" maxlength="50" placeholder="50�� �̸����� �Է����ּ���."> 
		<br>
		<br>
		<b>����</b> 
		<br>
		<input type = "text" name = "nation" maxlength="10">
		<br>
		<br>
		<b>����</b>
		<br>
		<input type = "text" name = "job" maxlength="10">
		<br>
		<br>
		<b>����⵵</b>
		<br>
		<input type="text" name="year"/>
		<br>
		<br>
		<button type="submit">���</button>
		<button type="button" onclick="goMainPage()">���ư���</button>
	</form>
</div>
</body>
</html>