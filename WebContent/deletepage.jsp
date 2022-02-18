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
	<script type="text/javascript">
        function goLoginPage() {
            location.href="loginpage.jsp";
        }
        
        function goMainPage() {
            location.href="mainpage.jsp";
        }
    </script>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
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
	<%
		int selectedID = 0;
		String insert;
		
		request.setCharacterEncoding("euc-kr");
		
		String upordel = request.getParameter("upordel");
		String select = (String) session.getAttribute("select");

		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
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
		
		String query = "select "+ select +"ID from "+ select +" where 유저ID='"+ userID +"';";		
		rs = stmt.executeQuery(query);
		while(rs.next()){
			int get_selectedID = rs.getInt(select+"ID");
			insert = request.getParameter("selected"+get_selectedID);
			if(insert != null){
				selectedID = get_selectedID;
				break;
			}
		}
		String selected_id_str = Integer.toString(selectedID);
		session.setAttribute("selected_id_str",selected_id_str);
		
		conn2 = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt2 = conn.createStatement();
		
		//전 페이지에서 삭제 버튼으로 선택하고 지우고 싶은 행을 선택 후 넘어왔을 시에 메인페이지에서 선택한 종류의 데이터베이스의 선택된 행을 삭제해줌
		//데이터베이스 삭제
		if(upordel.equals("삭제")){
			String query2 = "DELETE FROM "+ select +" WHERE "+ select +"ID="+ selectedID +";";
			stmt2.executeUpdate(query2);
	%>
		<h1><%=select %> 삭제가 완료되었습니다.</h1>
		<br>
		<button type="button" onclick="goMainPage()">메인화면으로</button>
	<%
		}
		//수정 버튼 및 선택한 데이터베이스의 선택한 행을 수정할 수 있도록 함.
		//문구 데이터베이스 수정
		else if(upordel.equals("수정") && select.equals("문구")){
	%>
	<form action = "phrase_person_choice.jsp" method="post">
	<%
			
			String query2 = "select 문구,키워드,설명,메모 from 문구 where 문구ID="+ selectedID +";";
			rs2 = stmt2.executeQuery(query2);
			
			String phrase = null;
			String keyword = null;
			String explain = null;
			String memo = null;
			String update_value = "True";
			session.setAttribute("update_value",update_value);
			
			while(rs2.next()){
				phrase = rs2.getNString("문구");
				keyword = rs2.getNString("키워드");
				explain = rs2.getNString("설명");
				memo = rs2.getNString("메모");
			}
	%>
	<h1>문구 수정</h1>
		<br>
		<b>문구</b> 
		<br>
		<input type = "text" name = "phrase" maxlength="100" value="<%=phrase %>"> 
		<br>
		<br>
		<b>카테고리 :</b> 
			<select name = "category">
				<option value="사랑">사랑</option><option value="이별">이별</option>
				<option value="노력">노력</option><option value="유머">유머</option>
				<option value="감동">감동</option><option value="기타">기타</option>
			</select>
		<br>
		<br>
		<b>키워드</b> 
		<br>
		<input type = "text" name = "keyword" maxlength="10" value="<%=keyword %>"> 
		<br>
		<br>
		<b>설명</b> 
		<br>
		<input type = "text" name = "explain" maxlength="50"value="<%=explain %>"> 
		<br>
		<br>
		<b>메모</b> 
		<br>
		<input type = "text" name = "memo" maxlength="30" value="<%=memo %>"> 
		<br>
		<br>
		<b>공유 여부</b>
		<br>
		<input type = "radio" name = "share" value = "YES">YES
		<input type = "radio" name = "share" value = "NO" checked>NO
		<br>
		<br>
		<button type="submit">인물 선택하러 가기</button>
	</form>
	<%
		}
		//출처 데이터베이스 수정
		else if(upordel.equals("수정") && select.equals("출처")){
	%>
	<form action = "source_detail_register.jsp" method="post">
	<%
			
			String query2 = "select 제목,종류 from 출처 where 출처ID="+ selectedID +";";
			rs2 = stmt2.executeQuery(query2);
			
			String sourcename = null;
			String selectedgenre = null;
			String update_value = "True";
			session.setAttribute("update_value",update_value);
			
			while(rs2.next()){
				sourcename = rs2.getNString("제목");
				selectedgenre = rs2.getNString("종류");
			}
			session.setAttribute("selectedgenre",selectedgenre);
	%>
	<h1>출처 수정</h1>
		<br>
		<b>출처 제목</b> 
		<br>
		<input type = "text" name = "name" maxlength="50" value="<%=sourcename %>"> 
		<br>
		<br>
		<b>종류 :</b> 
			<select name = "genre">
				<option>책</option><option>영화</option>
				<option>노래</option><option>인터넷</option>
				<option>인터뷰</option><option>속담</option>
			</select>
		<br>
		<br>
		<button type="submit">다음으로</button>
	</form>
	<%
		}
		//인물 데이터베이스 수정
		else if(upordel.equals("수정") && select.equals("인물")){
	%>
	<form action = "personregister_result.jsp" method="post">
	<%
			
			String query2 = "select 이름,국적,직업,출생년도 from 인물 where 인물ID="+ selectedID +";";
			rs2 = stmt2.executeQuery(query2);
			
			String personname = null;
			String nation = null;
			String job = null;
			String birth = null;
			String update_value = "True";
			session.setAttribute("update_value",update_value);
			
			while(rs2.next()){
				personname = rs2.getNString("이름");
				nation = rs2.getNString("국적");
				job = rs2.getNString("직업");
				birth = rs2.getNString("출생년도");
			}	
	%>
		<h1>인물 수정</h1>
		<br>
		<b>인물 이름</b> 
		<br>
		<input type = "text" name = "name" maxlength="50" value="<%=personname %>"> 
		<br>
		<br>
		<b>국적</b> 
		<br>
		<input type = "text" name = "nation" maxlength="10" value="<%=nation %>">
		<br>
		<br>
		<b>직업</b>
		<br>
		<input type = "text" name = "job" maxlength="10" value="<%=job %>">
		<br>
		<br>
		<b>출생년도</b>
		<br>
		<input type="text" name="year" value="<%= birth%>">
		<br>
		<br>
		<button type="submit">수정</button>
	</form>
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
</div>
</body>
</html>