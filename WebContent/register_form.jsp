<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �����ͺ��̽� ȸ������</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
		function checkValue(){
        	if(!document.userInfo.id.value){
            	alert("���̵� �Է��ϼ���.");
            	return false;
        	}
        
        	if(!document.userInfo.password.value){
            	alert("��й�ȣ�� �Է��ϼ���.");
            	return false;
        	}
        
        	// ��й�ȣ�� ��й�ȣ Ȯ�ο� �Էµ� ���� �������� Ȯ��
        	if(document.userInfo.password.value != document.userInfo.passwordcheck.value ){
            	alert("��й�ȣ�� �����ϰ� �Է��ϼ���.");
            	return false;
        	}
        	
        	if(!document.userInfo.birth.value){
            	alert("��������� �Է��ϼ���.");
            	return false;
        	}
        	
        	if(!document.userInfo.address.value){
            	alert("�ּҸ� �Է��ϼ���.");
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
	<h1>ȸ������</h1>
	<h2>��� ������ ������ּ���!</h2>
	<form action="register_result.jsp" method="post" name="userInfo" onsubmit="return checkValue()">
	
		<br>
		<b>ID</b> 
		<br>
		<input type = "text" name = "id" maxlength="20" placeholder="20�� �̸����� �Է����ּ���."> 
		<br>
		<br>
		<b>PASSWORD</b> 
		<br>
		<input type = "password" name = "password" maxlength="20" placeholder="20�� �̸����� �Է����ּ���.">
		<br>
		<br>
		<b>PASSWORD Ȯ��</b>
		<br>
		<input type = "password" maxlength="20">
		<br>
		<br>
		<b>�̸�</b>
		<br>
		<input type = "text" name = "name" maxlength="30">
		<br>
		<br>
		<b>����</b>
		<br>
		<input type = "radio" name = "gender" value = "��">��
		<input type = "radio" name = "gender" value = "��">��
		<br>
		<br>
		<b>�������</b>
		<br>
		<input type="text" name="birth" placeholder="yyyy-mm-dd"/>
		<br>
		<br>
		<b>�ּ�</b>
		<br>
		<input type = "text" name = "address" maxlength="15" placeholder="15�� �̸����� �Է����ּ���.">
		<br>
		<br>
		<button type="submit">����</button>
		<button type="button" onclick="goJoinForm()">���</button>
	</form>
</div>
</body>
</html>