<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �����ͺ��̽�</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
        function goPersonRegister() {
            location.href="person_register.jsp";
        } 
        
        function goPhraseRegister() {
            location.href="phrase_register.jsp";
        }
        
        function goResourceRegister() {
            location.href="source_register.jsp";
        }
        
        function goLoginPage() {
            location.href="loginpage.jsp";
        }
        
        function goMainPage() {
            location.href="mainpage.jsp";
        }
        
        function goShowUserPhrase() {
            location.href="showuserphrase.jsp";
        }
        
        function goShowSharePhrase() {
            location.href="showsharephrase.jsp";
        }
    </script>
</head>
<body>
	<%
		String userID = (String)session.getAttribute("id");
	%>
<div>
<input type='button' onclick="goLoginPage()" value='�α׾ƿ�' style="float: left;">
<input type='button' onclick="goShowSharePhrase()" value='������ ���� ����' style="float: left;">
<p style="text-align:right; text-decoration:underline" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
<h1>���� �����ͺ��̽�</h1>
<h2>��Ÿ��� ������ �����ϼ���!</h2>
	<%
		String update_value = "False";
		session.setAttribute("update_value",update_value); //�ű� ��Ͻ� ����� ���� �ذ�
		String selectedgenre= "����";
		session.setAttribute("selectedgenre",selectedgenre);//��ó ���� �ű� ��Ͻ� ����� ���� �ذ�
	%>
	<form action="searchdatabase.jsp" method="post" name="MainPage">
	<hr>
	<h4>DB �˻��ϱ�</h4>
	<b>DB ���� :</b> 
			<select name = "search">
				<option value="����">����</option><option value="�ι�">�ι�</option>
				<option value="��ó">��ó</option>
			</select>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="submit">�˻�</button>
	<br><br>
	<hr>
</form>
<form action="updateordelpage.jsp" method="post" name="MainPage">
	<hr>
	<h4>DB ���� �� �����ϱ�</h4>
	<b>DB ���� :</b> 
			<select name = "select">
				<option value="����">����</option><option value="�ι�">�ι�</option>
				<option value="��ó">��ó</option>
			</select>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="submit">����/����</button>
	<br><br>
	<hr>
</form>
	<hr>
	<h4>DB ����ϱ�</h4>
	<button type="button" onclick="goPhraseRegister()">�������</button>&nbsp;&nbsp;
	<button type="button" onclick="goResourceRegister()">��ó���</button>&nbsp;&nbsp;
	<button type="button" onclick="goPersonRegister()">�ι����</button>
	<br><br>
	<hr>
</div>
</body>
</html>