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
<title>�ι���� Ȯ��â</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
</head>
<script type="text/javascript">
        function goLoginPage() {
            location.href="loginpage.jsp";
        }
        
        function goMainPage() {
            location.href="mainpage.jsp";
        }
    </script>
<body>
	<%
		String userID = (String)session.getAttribute("id");
	%>
<div>
<input type='button' onclick="goLoginPage()" value='�α׾ƿ�' style="float: left;">
<p style="text-align:right; text-decoration:underline" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
	<form action="mainpage.jsp" name="result">
	<%
		request.setCharacterEncoding("euc-kr");

		String name = request.getParameter("name");
		String nation = request.getParameter("nation");
		String job = request.getParameter("job");
		String year = request.getParameter("year");
		String update_value = (String)session.getAttribute("update_value");
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select * from �ι�";
		String update_query = "";
		
		Connection conn = null;
		Statement stmt = null;

	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		if(update_value.equals("True")){
			String selected_id_str = (String)session.getAttribute("selected_id_str");
			int selected_ID = Integer.parseInt(selected_id_str);
			String update_person_value ="UPDATE �ι� SET �̸� = '"+ name +"',���� = '"+ nation +"',���� = '"+ job +"',����⵵ = '"+ year +"' WHERE �ι�ID="+ selected_ID +";";
			stmt.executeUpdate(update_person_value);
	%>
	<h1>�ι� ������ ���������� �Ϸ�Ǿ����ϴ�!</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
		}
		else{
			String insert_person_value = "INSERT INTO �ι�(�̸�,����,����,����⵵,����ID) values('" + name + "','" + nation + "','" + job + "','" + year + "','" + userID + "');";
			stmt.executeUpdate(insert_person_value);
	%>
	<h1>�ι� ����� ���������� �Ϸ�Ǿ����ϴ�!</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
			}
		}catch(SQLException se){
	%>
	<h1>�ι� ��Ͽ� �����Ͽ����ϴ�.</h1>
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