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
<title>문구 출처 선택</title>
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
<input type='button' onclick="goLoginPage()" value='로그아웃' style="float: left;">
<input type='button' onclick="goMainPage()" value='메인화면으로' style="float: left;">
<p style="text-align:right; text-decoration:underline" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
	<form action="phrase_result.jsp" method="post" name="test">
	<%
		int personid = 0;
		String insert;
		
		request.setCharacterEncoding("euc-kr");

		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select 인물ID from 인물 where 유저ID='"+ userID +"';";
		String query2 = "select 출처ID,제목,종류 from 출처 where 유저ID='"+ userID +"';";
		String update_query = "";
		
		Connection conn = null;
		Connection conn2 = null;
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;

	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
		while(rs.next()){
			int get_personid = rs.getInt("인물ID");
			insert = request.getParameter("selectedperson"+get_personid);
			if(insert != null){
				personid = get_personid;
				break;
			}
		}
		String person_id_str = Integer.toString(personid);
		session.setAttribute("person_id_str",person_id_str);
		
		conn2 = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(query2);
	%>
		<b>출처</b>
		<br>
		문구의 출처을 선택해주세요.(하나만 선택 가능)
		<table border="1">
			<tr>
				<th>선택</th><th>출처ID</th><th>제목</th><th>종류</th>
			</tr>
	<%	
		while(rs2.next()){
			int sourceID = rs2.getInt("출처ID");
			String sourceName = rs2.getNString("제목");
			String sourcegenre = rs2.getNString("종류");
	%>
			<tr>
			<td><input type="checkbox" name="selectedsource<%=sourceID%>"></td>
			<td><%=sourceID %></td> <td><%=sourceName %></td> <td><%=sourcegenre %></td>
	<%
			}
	%>
		</table>
		<br>
		<Button type = "submit">등록완료</Button>
	<%
		}catch(SQLException se){
	%>
			<br>
			<Button type = "button" onclick="goMainPage()">계속하기</Button>
			<Button type = "submit">돌아가기</Button>
	<%
			}finally{
				try{
					rs.close();
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