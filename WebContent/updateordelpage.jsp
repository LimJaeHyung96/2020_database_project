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
<title>DB 수정/삭제</title>
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
	<form action="deletepage.jsp" method = "post">
	<%
		request.setCharacterEncoding("euc-kr");
		
		String select = request.getParameter("select");
		session.setAttribute("select",select);
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String update_query = "";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
	%>
		<b>수정/삭제</b>
		<br>
		<input type = "radio" name = "upordel" value = "수정" checked>수정
		<input type = "radio" name = "upordel" value = "삭제">삭제
		<br>
		<br>
	<%
		if(select.equals("문구")){
			String query = "select 문구ID,문구,카테고리,키워드,설명,메모 from 문구 where 유저ID='"+ userID +"';";
			rs = stmt.executeQuery(query);
	%>
		<br>
		<b>문구</b>
		<br>
		<table border="1">
			<tr>
				<th>선택</th><th>문구ID</th><th>문구</th><th>카테고리</th><th>키워드</th><th>설명</th><th>메모</th>
			</tr>
	<%	
		while(rs.next()){
			int phraseID = rs.getInt("문구ID");
			String phrase = rs.getNString("문구");
			String phraseCategory = rs.getNString("카테고리");
			String phraseKeyword = rs.getNString("키워드");
			String phraseExplain = rs.getNString("설명");
			String phraseMemo = rs.getNString("메모");
	%>
			<tr>
			<td><input type="checkbox" name="selected<%=phraseID%>"></td>
			<td><%=phraseID %></td> <td><%=phrase %></td> <td><%=phraseCategory %></td> <td><%=phraseKeyword %></td> <td><%=phraseExplain %></td><td><%=phraseMemo %></td>
			</tr>
	<%
			}
	%>
		</table>
		<br>
		<Button type = "submit">선택완료</Button>
	<%	
			}else if(select.equals("출처")){
				String query = "select 출처ID,제목,종류 from 출처 where 유저ID='"+ userID +"';";
				rs = stmt.executeQuery(query);
		%>
			<b>출처</b>
			<br>
			<table border="1">
				<tr>
					<th>선택</th><th>출처ID</th><th>제목</th><th>종류</th>
				</tr>
		<%	
			while(rs.next()){
				int sourceID = rs.getInt("출처ID");
				String sourceName = rs.getNString("제목");
				String sourceCategory = rs.getNString("종류");
		%>
				<tr>
				<td><input type="checkbox" name="selected<%=sourceID%>"></td>
				<td><%=sourceID %></td> <td><%=sourceName %></td> <td><%=sourceCategory %></td>
				</tr>
		<%
				}
		%>
			</table>
			<br>
			<Button type = "submit">선택완료</Button>
		<%	
				}else if(select.equals("인물")){
					String query = "select 인물ID,이름,국적,직업,출생년도 from 인물 where 유저ID='"+ userID +"';";
					rs = stmt.executeQuery(query);
		%>
				<b>인물</b>
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
					<td><input type="checkbox" name="selected<%=personID%>"></td>
					<td><%=personID %></td> <td><%=personName %></td> <td><%=personNation %></td> <td><%=personJob %></td> <td><%=personYear %></td>
					</tr>
			<%
					}
			%>
				</table>
				<br>
				<Button type = "submit">선택완료</Button>
			<%	
					}
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