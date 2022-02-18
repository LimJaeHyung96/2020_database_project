<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ���</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
		function checkValue(){
        	if(!document.phraseInfo.phrase.value){
            	alert("������ �Է��ϼ���.");
            	return false;
        	}
        	
        	if(!document.phraseInfo.keyword.value){
            	alert("Ű���带 �Է��ϼ���.");
            	return false;
        	}
        	
        	if(!document.phraseInfo.explain.value){
            	alert("������ �Է��ϼ���.");
            	return false;
        	}
        	
        	if(!document.phraseInfo.memo.value){
            	alert("�޸� �Է��ϼ���.");
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
	<h1>���� ���</h1>
	<form action="phrase_person_choice.jsp" method="post" name="phraseInfo" onsubmit="return checkValue()">
	
		<br>
		<b>����</b> 
		<br>
		<input type = "text" name = "phrase" maxlength="100" placeholder="50�� �̸����� �Է����ּ���."> 
		<br>
		<br>
		<b>ī�װ� :</b> 
			<select name = "category">
				<option value="���">���</option><option value="�̺�">�̺�</option>
				<option value="���">���</option><option value="����">����</option>
				<option value="����">����</option><option value="��Ÿ">��Ÿ</option>
			</select>
		<br>
		<br>
		<b>Ű����</b> 
		<br>
		<input type = "text" name = "keyword" maxlength="10"> 
		<br>
		<br>
		<b>����</b> 
		<br>
		<input type = "text" name = "explain" maxlength="50"> 
		<br>
		<br>
		<b>�޸�</b> 
		<br>
		<input type = "text" name = "memo" maxlength="30"> 
		<br>
		<br>
		<b>���� ����</b>
		<br>
		<input type = "radio" name = "share" value = "YES">YES
		<input type = "radio" name = "share" value = "NO">NO
		<br>
		<br>
		<button type="submit">������ �ι� ����ϱ�</button>
		<button type="button" onclick="goMainPage()">���ư���</button>
	</form>
</div>
</body>
</html>