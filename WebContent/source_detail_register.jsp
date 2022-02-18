<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>출처 세부사항 등록</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
<script type="text/javascript">
        function goLoginPage() {
            location.href="loginpage.jsp";
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
	<form action="sourceregister_result.jsp" method="post" name="result">
	<%
		request.setCharacterEncoding("euc-kr");

		String name = request.getParameter("name");
		String genre = request.getParameter("genre");
		String update_value = (String)session.getAttribute("update_value");
		
		session.setAttribute("sourcegenre", genre);
		session.setAttribute("sourcename",name);
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select * from 출처";
		String update_query = "";
		
		Connection conn = null;
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet rs = null;

	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String selectedgenre = (String)session.getAttribute("selectedgenre"); //수정 시에 선택된 장르 값을 가져옴.
		
		//수정할 때 저장된 장르값과 현재 선택한 장르가 같을 때 - 출처 세부값을 그대로 보여줘야 함
		if(selectedgenre.equals(genre)){
			String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
			int selected_ID = Integer.parseInt(selected_id_str);
			
			String update_source_value ="UPDATE 출처 SET 제목 = '"+ name +"',종류 = '"+ genre +"' WHERE 출처ID="+ selected_ID +";";
			stmt.executeUpdate(update_source_value);	
	%>	
	<h1>출처 수정이 성공적으로 완료되었습니다!</h1>
	<h2>이제 출처 세부정보를 수정해볼까요?</h2>	
	<%
			//선택된 장르와 맞는 장르가 나오면서 텍스트박스에 내용이 들어가 있어야 함.
			if(selectedgenre.equals("노래")){
				
				stmt2 = conn.createStatement();
				String query2 = "select * from 출처_노래 where 출처ID="+ selected_ID +";";
				rs = stmt2.executeQuery(query2);
				
				String singer = null;
				String album = null;
				String songyear = null;
				
				while(rs.next()){
					singer = rs.getNString("가수");
					album = rs.getNString("앨범");
					songyear = rs.getNString("발매년도");
				}
		%>
			<br>
			<b>가수</b> 
			<br>
			<input type = "text" name = "singer" maxlength="20" value="<%=singer%>"> 
			<br>
			<br>
			<b>앨범</b> 
			<br>
			<input type = "text" name = "album" maxlength="30" value="<%=album%>"> 
			<br>
			<br>
			<b>발매년도</b> 
			<br>
			<input type = "text" name = "songyear" maxlength="20" value="<%=songyear%>"> 
			<br>
			<button type = "submit">완료</button>
		<%		
				}else if(selectedgenre.equals("책")){
					stmt2 = conn.createStatement();
					String query2 = "select * from 출처_책 where 출처ID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String writer = null;
					String publishing = null;
					String bookyear = null;
					
					while(rs.next()){
						writer = rs.getNString("저자");
						publishing = rs.getNString("출판사");
						bookyear = rs.getNString("출판년도");
					}
		%>
			<br>
			<b>저자</b> 
			<br>
			<input type = "text" name = "writer" maxlength="20" value="<%=writer%>"> 
			<br>
			<br>
			<b>출판사</b> 
			<br>
			<input type = "text" name = "publishing" maxlength="10" value="<%=publishing%>"> 
			<br>
			<br>
			<b>출판년도</b> 
			<br>
			<input type = "text" name = "bookyear" maxlength="20" value="<%=bookyear%>"> 
			<br>
			<button type = "submit">완료</button>
		<%	
				}else if(selectedgenre.equals("속담")){
					stmt2 = conn.createStatement();
					String query2 = "select * from 출처_속담 where 출처ID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String country = null;
					
					while(rs.next()){
						country = rs.getNString("나라");
					}
		%>
			<br>
			<b>나라</b> 
			<br>
			<input type = "text" name = "country" maxlength="20" value="<%=country%>"> 
			<br>
			<button type = "submit">완료</button>
		<%	
				}else if(selectedgenre.equals("영화")){
					stmt2 = conn.createStatement();
					String query2 = "select * from 출처_영화 where 출처ID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String director = null;
					String actor = null;
					String movieyear = null;
					String moviegenre = null;
					
					while(rs.next()){
						director = rs.getNString("감독");
						actor = rs.getNString("주연");
						movieyear = rs.getNString("개봉년도");
						moviegenre = rs.getNString("장르");
					}
		%>
			<br>
			<b>감독</b> 
			<br>
			<input type = "text" name = "director" maxlength="20" value="<%=director%>"> 
			<br>
			<br>
			<b>주연</b> 
			<br>
			<input type = "text" name = "actor" maxlength="50" value="<%=actor%>"> 
			<br>
			<br>
			<b>개봉년도</b> 
			<br>
			<input type = "text" name = "movieyear" maxlength="10" value="<%=movieyear%>"> 
			<br>
			<br>
			<b>장르</b> 
			<br>
			<input type = "text" name = "moviegenre" maxlength="15" value="<%=moviegenre%>"> 
			<br>
			<button type = "submit">완료</button>
		<%	
				}else if(selectedgenre.equals("인터넷")){
					stmt2 = conn.createStatement();
					String query2 = "select * from 출처_인터넷 where 출처ID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String site = null;
					String url = null;
					
					while(rs.next()){
						site = rs.getNString("사이트명");
						url = rs.getNString("URL");
					}
		%>
			<br>
			<b>사이트명</b> 
			<br>
			<input type = "text" name = "site" maxlength="20" value="<%=site%>"> 
			<br>
			<br>
			<b>URL</b> 
			<br>
			<input type = "text" name = "url" maxlength="300" value="<%=url%>"> 
			<br>
			<button type = "submit">완료</button>
		<%	
				}else if(selectedgenre.equals("인터뷰")){
					stmt2 = conn.createStatement();
					String query2 = "select * from 출처_인터뷰 where 출처ID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String interviewdate = null;
					String company = null;
					
					while(rs.next()){
						interviewdate = rs.getNString("일자");
						company = rs.getNString("회사");
					}
		%>
			<br>
			<b>일자</b> 
			<br>
			<input type = "text" name = "interviewdate" maxlength="20" value="<%=interviewdate%>"> 
			<br>
			<br>
			<b>인터뷰한 회사</b> 
			<br>
			<input type = "text" name = "company" maxlength="30" value="<%=company%>"> 
			<br>
			<button type = "submit">완료</button>
		<%
			}
		}
		//수정할 때 선택된 장르값과 현재 장르가 다를 때 - 전의 출처 세부를 삭제하고 새로 쓰거나 신규 등록
		else{
			//전의 출처 세부 삭제 - 수정하는 중
			if(update_value.equals("True")){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				//출처 업데이트
				String update_source_value ="UPDATE 출처 SET 제목 = '"+ name +"',종류 = '"+ genre +"' WHERE 출처ID="+ selected_ID +";";
				stmt.executeUpdate(update_source_value);
				//수정 전의 출처 세부 삭제
				stmt2 = conn.createStatement();
				String query2 = "delete from 출처_"+ selectedgenre +" where 출처ID="+ selected_ID +";";
				rs = stmt2.executeQuery(query2);
	%>	
	<h1>출처 수정이 성공적으로 완료되었습니다!</h1>
	<h2>이제 출처 세부정보를 수정해볼까요?</h2>	
	<%
			}
			//신규등록
			else if(update_value.equals("False")){
				String insert_source_value = "INSERT INTO 출처(제목,종류,유저ID) values('" + name + "','" + genre + "','" + userID + "');";
				stmt.executeUpdate(insert_source_value);
	%>	
	<h1>출처 등록이 성공적으로 완료되었습니다!</h1>
	<h2>이제 출처 세부정보를 입력해볼까요?</h2>
	<%
			}
			//새로운 출처 세부를 보여줘야함
			if(genre.equals("노래")){
				%>
					<br>
					<b>가수</b> 
					<br>
					<input type = "text" name = "singer" maxlength="20"> 
					<br>
					<br>
					<b>앨범</b> 
					<br>
					<input type = "text" name = "album" maxlength="30"> 
					<br>
					<br>
					<b>발매년도</b> 
					<br>
					<input type = "text" name = "songyear" maxlength="20"> 
					<br>
					<button type = "submit">완료</button>
				<%		
						}else if(genre.equals("책")){
				%>
					<br>
					<b>저자</b> 
					<br>
					<input type = "text" name = "writer" maxlength="20"> 
					<br>
					<br>
					<b>출판사</b> 
					<br>
					<input type = "text" name = "publishing" maxlength="10"> 
					<br>
					<br>
					<b>출판년도</b> 
					<br>
					<input type = "text" name = "bookyear" maxlength="20"> 
					<br>
					<button type = "submit">완료</button>
				<%	
						}else if(genre.equals("속담")){
				%>
					<br>
					<b>나라</b> 
					<br>
					<input type = "text" name = "country" maxlength="20"> 
					<br>
					<button type = "submit">완료</button>
				<%	
						}else if(genre.equals("영화")){
				%>
					<br>
					<b>감독</b> 
					<br>
					<input type = "text" name = "director" maxlength="20"> 
					<br>
					<br>
					<b>주연</b> 
					<br>
					<input type = "text" name = "actor" maxlength="50"> 
					<br>
					<br>
					<b>개봉년도</b> 
					<br>
					<input type = "text" name = "movieyear" maxlength="10"> 
					<br>
					<br>
					<b>장르</b> 
					<br>
					<input type = "text" name = "moviegenre" maxlength="15"> 
					<br>
					<button type = "submit">완료</button>
				<%	
						}else if(genre.equals("인터넷")){
				%>
					<br>
					<b>사이트명</b> 
					<br>
					<input type = "text" name = "site" maxlength="20"> 
					<br>
					<br>
					<b>URL</b> 
					<br>
					<input type = "text" name = "url" maxlength="300"> 
					<br>
					<button type = "submit">완료</button>
				<%	
						}else if(genre.equals("인터뷰")){
				%>
					<br>
					<b>일자</b> 
					<br>
					<input type = "text" name = "interviewdate" maxlength="20"> 
					<br>
					<br>
					<b>인터뷰한 회사</b> 
					<br>
					<input type = "text" name = "company" maxlength="30"> 
					<br>
					<button type = "submit">완료</button>
				<%
				}
			}
		}catch(SQLException se){
	%>
	<h1>출처 등록에 실패하였습니다.</h1>
	<br>
	<button type = "button" onclick="goMainPage()">실패</button>	
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