<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����DB �α���</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
   <script type="text/javascript">
    
        function checkValue()
        {
            if(!document.loginInfo.id.value){
            	alert("���̵� �Է��ϼ���");
            	return false;
        	}
            if(!document.loginInfo.password.value){
                alert("��й�ȣ�� �Է��ϼ���");    
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
 	<h1>�α���</h1>
 	<h2>ȯ���մϴ�.</h2>
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
 	<button type="submit">�α���</button>
 	<button type="button" onclick="goJoinForm()">ȸ������</button>
 	</form>
</div>
</body>
</html>