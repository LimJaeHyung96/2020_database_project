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
<title>������ ���� ����</title>
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
<div>
	<%
		String userID = (String)session.getAttribute("id");
	%>
<input type='button' onclick="goLoginPage()" value='�α׾ƿ�' style="float: left;">
<input type='button' onclick="goMainPage()" value='����ȭ������' style="float: left;">
<p style="text-align:right;" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
	<%
		String update_value = "False";
		session.setAttribute("update_value",update_value);
		String selectedgenre= "����";
		session.setAttribute("selectedgenre",selectedgenre);

		request.setCharacterEncoding("euc-kr");
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String update_query = "";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		String query = "SELECT ����.����,��ó.����,�ι�.�̸� FROM ����,��ó,�ι� WHERE ����.��óID = ��ó.��óID AND ����.�ι�ID = �ι�.�ι�ID AND �������� <= 'YES' AND �������� >= 'YES';";
		rs = stmt.executeQuery(query);
	%>
		<h1>�̿��ڵ��� ������ �����Դϴ�.</h1>
		<br>
		<table border="1">
			<tr>
				<th>����</th><th>��ó ����</th><th>�ι� �̸�</th>
			</tr>
	<%	
		while(rs.next()){
			String phrase = rs.getNString("����");
			String sourcename = rs.getNString("����");
			String personname = rs.getNString("�̸�");
	%>
			<tr>
			<td><%=phrase %></td> <td><%=sourcename %></td> <td><%=personname %></td>
			</tr>
	<%
			}
	%>
	</table>
</div>
</body>
</html>