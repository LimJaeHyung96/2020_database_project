<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������ Ȯ��â</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
</head>
<body>
<div id="wrap">
	<form action="loginpage.jsp" name="result">
	<%
		request.setCharacterEncoding("euc-kr");

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String birth = request.getParameter("birth");
		String address = request.getParameter("address");

		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select * from ����";
		String update_query = "";
		
		Connection conn = null;
		Statement stmt = null;

		String insert_user_value = "INSERT INTO ����(id,password,�̸�,����,�������,�ּ�,����) values('" + id + "','" + password + "','" + name + "','" + gender + "','" + birth + "','" + address + "',0);";
	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		stmt.executeUpdate(insert_user_value);
	%>
	
	<h1>ȸ�������� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>

	<%
		}catch(SQLException se){
	%>
	<h1>ȸ�����Կ� �����Ͽ����ϴ�.</h1>
	<br>
	<button type = "submit">����</button>	
	<% 	
		}finally{
			try{
				stmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
	</form>
</div>
</body>
</html>