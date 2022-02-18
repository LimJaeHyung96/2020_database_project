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
<form action="showsourcedetail.jsp" method="post">
	<%
		request.setCharacterEncoding("euc-kr");
	
		String selectedsearch = (String)session.getAttribute("selectedsearch");
	
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
			
			
			if(selectedsearch.equals("문구")){
				String category = request.getParameter("category");
				String phrasesearch = request.getParameter("phrasesearch");
				String phrasefind = request.getParameter("phrasefind");
				String query = "select * from 문구 where 카테고리 <= '"+ category +"' and 카테고리 >= '"+ category +"' and "+ phrasesearch +" like '%"+ phrasefind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>문구</b>
		<br>
		<table border="1">
		<tr>
			<th>문구</th><th>카테고리</th><th>키워드</th><th>설명</th><th>메모</th>
		</tr>
	<%	
				while(rs.next()){
					String phrase = rs.getNString("문구");
					String phraseCategory = rs.getNString("카테고리");
					String phraseKeyword = rs.getNString("키워드");
					String phraseExplain = rs.getNString("설명");
					String phraseMemo = rs.getNString("메모");
	%>
		<tr>
		<td><%=phrase %></td> <td><%=phraseCategory %></td> <td><%=phraseKeyword %></td> <td><%=phraseExplain %></td><td><%=phraseMemo %></td>
		</tr>
	<%
				}
	%>
		</table>
	<%
			}else if(selectedsearch.equals("인물")){
				String personsearch = request.getParameter("personsearch");
				String personfind = request.getParameter("personfind");
				String query = "select * from 인물 where "+ personsearch +" like '%"+ personfind +"%' ;";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>인물</b>
		<br>
		<table border="1">
		<tr>
			<th>이름</th><th>국적</th><th>직업</th><th>츨생년도</th>
		</tr>
	<%	
				while(rs.next()){
					String name = rs.getNString("이름");
					String nation = rs.getNString("국적");
					String job = rs.getNString("직업");
					String birth = rs.getNString("출생년도");
	%>
		<tr>
		<td><%=name %></td> <td><%=nation %></td> <td><%=job %></td> <td><%=birth %></td>
		</tr>
	<%
				}
	%>
		</table>
	<% 
			}else if(selectedsearch.equals("출처")){
				String sourcefind = request.getParameter("sourcefind");
				session.setAttribute("sourcefind",sourcefind);
				String sourcegenre = request.getParameter("sourcegenre");
				session.setAttribute("sourcegenre",sourcegenre);
				String searchdetail = request.getParameter("searchdetail");
				
				//세부정보 검색하도록 넘어감
				if(searchdetail.equals("checkon")){
					if(sourcegenre.equals("노래")){
	%>
		<h4>노래 세부정보 검색하기</h4> 
			<select name = "detailsearch">
				<option value="가수">가수</option><option value="앨범">앨범</option>
				<option value="발매년도">발매년도</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="특수문자는 사용할수 없습니다.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">검색</button>
	<%
					}else if(sourcegenre.equals("책")){
	%>
		<h4>책 세부정보 검색하기</h4> 
			<select name = "detailsearch">
				<option value="저자">저자</option><option value="출판사">출판사</option>
				<option value="출판년도">출판년도</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="특수문자는 사용할수 없습니다.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">검색</button>
	<%
					
					}else if(sourcegenre.equals("영화")){
	%>
		<h4>영화 세부정보 검색하기</h4> 
			<select name = "detailsearch">
				<option value="감독">감독</option><option value="주연">주연</option>
				<option value="개봉년도">개봉년도</option><option value="장르">장르</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="특수문자는 사용할수 없습니다.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">검색</button>
	<%
					
					}else if(sourcegenre.equals("인터넷")){
	%>
		<h4>인터넷 출처정보 검색하기</h4> 
			<select name = "detailsearch">
				<option value="사이트명">사이트명</option><option value="URL">URL</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="특수문자는 사용할수 없습니다.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">검색</button>
	<%
					
					}else if(sourcegenre.equals("속담")){
	%>
		<h4>속담 나라 검색하기</h4> 
			<b>나라</b>&nbsp;
			<input type='text' name='detailfind' value='' placeholder="특수문자는 사용할수 없습니다.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">검색</button>
	<%
					}else if(sourcegenre.equals("인터뷰")){
	%>
		<h4>인터뷰 정보 검색하기</h4> 
			<select name = "detailsearch">
				<option value="일자">일자</option><option value="회사">회사</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="특수문자는 사용할수 없습니다.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">검색</button>
	<%
					}
			}else if(searchdetail.equals("checkoff")){ //출처 기본 정보만 보여줌
				
				String query = "select * from 출처 where 제목 like '%"+ sourcefind +"%' and 종류 >= '"+ sourcegenre +"' and 종류 <= '"+ sourcegenre +"';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>출처</b>
		<br>
		<table border="1">
		<tr>
			<th>제목</th><th>종류</th>
		</tr>
	<%	
				while(rs.next()){
					String name = rs.getNString("제목");
					String genre = rs.getNString("종류");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td>
		</tr>
	<%
				}
	%>
		</table>
	<% 
			}
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
</form>
</div>
</body>
</html>