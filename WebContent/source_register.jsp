<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ó ���</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
		function checkValue(){
        	if(!document.sourceInfo.name.value){
            	alert("��ó ���� �Է��ϼ���.");
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
	<h1>��ó ���</h1>
	<h2>��� ������ ������ּ���!</h2>
	<form action="source_detail_register.jsp" method="post" name="sourceInfo" onsubmit="return checkValue()">
	
		<br>
		<b>��ó ����</b> 
		<br>
		<input type = "text" name = "name" maxlength="50" placeholder="50�� �̸����� �Է����ּ���."> 
		<br>
		<br>
		<b>���� :</b> 
			<select name = "genre">
				<option>å</option><option>��ȭ</option>
				<option>�뷡</option><option>���ͳ�</option>
				<option>���ͺ�</option><option>�Ӵ�</option>
			</select>
		<br>
		<br>
		<button type="submit">��������</button>
		<button type="button" onclick="goMainPage()">���ư���</button>
	</form>
</div>
</body>
</html>