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
<title>문구 등록 확인창</title>
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
<p style="text-align:right; text-decoration:underline" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
	<form action="mainpage.jsp" name="result">
	<%
		request.setCharacterEncoding("euc-kr");

		int sourceid = 0;
		String insert;
		
		String update_value = (String) session.getAttribute("update_value");

		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select * from 문구";
		String query2 = "select 출처ID from 출처 where 유저ID='"+ userID +"';";
		String update_query = "";
	
		Connection conn = null;
		Connection conn2 = null;
		
		Statement stmt = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query2);
	
		while(rs.next()){
			int get_sourceid = rs.getInt("출처ID");
			insert = request.getParameter("selectedsource"+get_sourceid);
			if(insert != null){
				sourceid = get_sourceid;
				break;
			}
		}
	
		String phrase = (String)session.getAttribute("phrase");
		String category = (String)session.getAttribute("category");
		String keyword = (String)session.getAttribute("keyword");
		String explain = (String)session.getAttribute("explain");
		String memo = (String)session.getAttribute("memo");
		String share = (String)session.getAttribute("share");
		String person_id_str = (String)session.getAttribute("person_id_str");
		int person_id = Integer.parseInt(person_id_str);
	
		Class.forName(driver);
		conn2 = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt2 = conn.createStatement();
		
		//문구 수정
		if(update_value.equals("True")){
			String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
			int selected_ID = Integer.parseInt(selected_id_str);
			String update_phrase_value = "UPDATE 문구 SET 문구 = '" + phrase + "',카테고리 = '" + category + "',키워드 = '" + keyword + "',설명 = '" + explain + "',메모 = '" + memo + "',공유여부 = '" + share + "',유저ID = '" + userID + "',출처ID = "+ sourceid +",인물ID = "+ person_id +" WHERE 문구ID = "+ selected_ID +";";
			stmt2.executeUpdate(update_phrase_value);	
	%>
	<h1>문구수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">메인화면으로</button>
	<%
		}
		//문구 신규 등록
		else{
			String query3 = "SELECT 점수 FROM 유저 WHERE id = '" + userID + "';";
			rs2 = stmt.executeQuery(query3);
			
			//문구 신규 등록시 사용자의 점수 +5
			int score = 0;
			while (rs2.next()){
				score = rs2.getInt("점수");
			}
			score += 5;
			
			stmt3 = conn.createStatement();
			String update_user_score = "UPDATE 유저 SET 점수 = "+ score +" WHERE id = '"+ userID +"';";
			stmt3.executeUpdate(update_user_score);
			
			//문구 등록
			String insert_phrase_value = "INSERT INTO 문구(문구,카테고리,키워드,설명,메모,공유여부,유저ID,출처ID,인물ID) values('" + phrase + "','" + category + "','" + keyword + "','" + explain + "','" + memo + "','" + share + "','" + userID + "',"+ sourceid +","+ person_id +");";
			stmt2.executeUpdate(insert_phrase_value);
	%>
	<h1>문구등록이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">메인화면으로</button>
	<%
		}
		}catch(SQLException se){
	%>
	<h1>문구등록에 실패하였습니다.</h1>
	<br>
	<button type = "submit">실패</button>	
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