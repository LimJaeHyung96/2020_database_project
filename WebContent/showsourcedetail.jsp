<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>검색</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
        function goLoginPage() {
            location.href="loginpage.jsp";
        }
        
        function goShowUserPhrase() {
            location.href="showuserphrase.jsp";
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
<p style="text-decoration:underline; text-align:right;" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
	<%
		request.setCharacterEncoding("euc-kr");
	
		String sourcefind = (String)session.getAttribute("sourcefind");
		String sourcegenre = (String)session.getAttribute("sourcegenre");
		String detailsearch = request.getParameter("detailsearch");
		String detailfind = request.getParameter("detailfind");
	
		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
	
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs= null;

		try{
			String driver = "org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			stmt = conn.createStatement();
			
			
			if(sourcegenre.equals("노래")){
				
				String query = "select * from 출처,출처_노래 where 출처.출처ID = 출처_노래.출처ID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>출처(노래)</b>
		<br>
		<table border="1">
		<tr>
			<th>제목</th><th>종류</th><th>가수</th><th>앨범</th><th>발매년도</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("제목");
					String genre = rs.getNString("종류");
					String singer = rs.getNString("가수");
					String album = rs.getNString("앨범");
					String songyear = rs.getNString("발매년도");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=singer %></td> <td><%=album %></td> <td><%=songyear %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("속담")){
				
				String query = "select * from 출처,출처_속담 where 출처.출처ID = 출처_속담.출처ID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>출처(속담)</b>
		<br>
		<table border="1">
		<tr>
			<th>제목</th><th>종류</th><th>나라</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("제목");
					String genre = rs.getNString("종류");
					String country = rs.getNString("나라");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=country %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("영화")){
				
				String query = "select * from 출처,출처_영화 where 출처.출처ID = 출처_영화.출처ID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>출처(영화)</b>
		<br>
		<table border="1">
		<tr>
			<th>제목</th><th>종류</th><th>감독</th><th>주연</th><th>개봉년도</th><th>장르</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("제목");
					String genre = rs.getNString("종류");
					String director = rs.getNString("감독");
					String actor = rs.getNString("주연");
					String movieyear = rs.getNString("개봉년도");
					String moviegenre = rs.getNString("장르");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=director %></td> <td><%=actor %></td> <td><%=movieyear %></td> <td><%=moviegenre %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("인터넷")){
				
				String query = "select * from 출처,출처_인터넷 where 출처.출처ID = 출처_인터넷.출처ID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>출처(인터넷)</b>
		<br>
		<table border="1">
		<tr>
			<th>제목</th><th>종류</th><th>사이트명</th><th>URL</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("제목");
					String genre = rs.getNString("종류");
					String site = rs.getNString("사이트명");
					String url = rs.getNString("URL");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=site %></td> <td><%=url %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("인터뷰")){
				
				String query = "select * from 출처,출처_인터뷰 where 출처.출처ID = 출처_인터뷰.출처ID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>출처(인터뷰)</b>
		<br>
		<table border="1">
		<tr>
			<th>제목</th><th>종류</th><th>일자</th><th>회사</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("제목");
					String genre = rs.getNString("종류");
					String date = rs.getNString("일자");
					String company = rs.getNString("회사");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=date %></td> <td><%=company %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("책")){
				
				String query = "select * from 출처,출처_책 where 출처.출처ID = 출처_책.출처ID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>출처(책)</b>
		<br>
		<table border="1">
		<tr>
			<th>제목</th><th>종류</th><th>저자</th><th>출판사</th><th>출판년도</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("제목");
					String genre = rs.getNString("종류");
					String writer = rs.getNString("저자");
					String publishing = rs.getNString("출판사");
					String bookyear = rs.getNString("출판년도");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=writer %></td> <td><%=publishing %></td> <td><%=bookyear %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}

		}catch(SQLException se){
	%>
		<h1>DB 검색에 실패하였습니다.</h1>
		<br>
		<button type = "button" onclick = "goMainPage()">실패</button>	
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
</div>
</body>
</html>