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
<title>문구 인물 선택</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
   <script type="text/javascript">
        function goUserRegisterForm() {
            location.href="register_form.jsp";
        } 
        
        function goMainPage() {
            location.href="mainpage.jsp";
        }
    </script>
</head>
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
	<form action="phrase_source_choice.jsp" method="post" name="test">
	<%
		request.setCharacterEncoding("euc-kr");

		String phrase = request.getParameter("phrase");
		String category = request.getParameter("category");
		String keyword = request.getParameter("keyword");
		String explain = request.getParameter("explain");
		String memo = request.getParameter("memo");
		String share = request.getParameter("share");
		
		session.setAttribute("phrase",phrase);
		session.setAttribute("category",category);
		session.setAttribute("keyword",keyword);
		session.setAttribute("explain",explain);
		session.setAttribute("memo",memo);
		session.setAttribute("share",share);

		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select 인물ID,이름,국적,직업,출생년도 from 인물 where 유저ID='"+ userID +"';";
		String update_query = "";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		
	%>
		<b>인물</b>
		문구의 인물을 선택해주세요.(하나만 선택 가능)
		<br>
		<table border="1">
			<tr>
				<th>선택</th><th>인물ID</th><th>이름</th><th>국적</th><th>직업</th><th>출생년도</th>
			</tr>
	<%	
		while(rs.next()){
			int personID = rs.getInt("인물ID");
			String personName = rs.getNString("이름");
			String personNation = rs.getNString("국적");
			String personJob = rs.getNString("직업");
			String personYear = rs.getNString("출생년도");
	%>
			<tr>
			<td><input type="checkbox" name="selectedperson<%=personID%>"></td>
			<td><%=personID %></td> <td><%=personName %></td> <td><%=personNation %></td> <td><%=personJob %></td> <td><%=personYear %></td>
			</tr>
	<%
			}
	%>
		</table>
		<br>
		<Button type = "submit">문구에 출처 등록하기</Button>
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