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
<title>공유된 문구 보기</title>
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
<input type='button' onclick="goLoginPage()" value='로그아웃' style="float: left;">
<input type='button' onclick="goMainPage()" value='메인화면으로' style="float: left;">
<p style="text-align:right;" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
	<%
		String update_value = "False";
		session.setAttribute("update_value",update_value);
		String selectedgenre= "없음";
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
		String query = "SELECT 문구.문구,출처.제목,인물.이름 FROM 문구,출처,인물 WHERE 문구.출처ID = 출처.출처ID AND 문구.인물ID = 인물.인물ID AND 공유여부 <= 'YES' AND 공유여부 >= 'YES';";
		rs = stmt.executeQuery(query);
	%>
		<h1>이용자들이 공유한 문구입니다.</h1>
		<br>
		<table border="1">
			<tr>
				<th>문구</th><th>출처 제목</th><th>인물 이름</th>
			</tr>
	<%	
		while(rs.next()){
			String phrase = rs.getNString("문구");
			String sourcename = rs.getNString("제목");
			String personname = rs.getNString("이름");
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