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
<title>출처등록 확인창</title>
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

		String sourcename = (String)session.getAttribute("sourcename");
		String sourcegenre = (String)session.getAttribute("sourcegenre");
		
		String selectedgenre = (String)session.getAttribute("selectedgenre");
		String update_value = (String)session.getAttribute("update_value");
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select * from 출처_" + sourcegenre;
		String update_query = "";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String query2 = "select 출처ID from 출처 where 제목='"+sourcename+"' and 종류='"+sourcegenre+"' and 유저ID='"+userID+"';";
		rs = stmt.executeQuery(query2);
		int sourceID = 0;
		while(rs.next()){
			sourceID = rs.getInt(1);
		}
		
		if(sourcegenre.equals("노래")){
			String singer = request.getParameter("singer");
			String album = request.getParameter("album");
			String songyear = request.getParameter("songyear");
			
			//출처 세부 수정
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE 출처_노래 SET 가수 = '" + singer + "',앨범 = '" + album + "',발매년도 = '" + songyear + "' WHERE 출처ID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(노래) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
			}
			//출처 세부 새로 등록
			else{
				//출처 세부 종류 바꿔서 등록
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO 출처_노래(가수,앨범,발매년도,출처ID) values('" + singer + "','" + album + "','" + songyear + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(노래) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
				//출처 완전 새로 등록
				else{
					String insert_source_detail_value = "INSERT INTO 출처_노래(가수,앨범,발매년도,출처ID) values('" + singer + "','" + album + "','" + songyear + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>출처(노래) 등록이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
			}
		}else if(sourcegenre.equals("속담")){
			String country = request.getParameter("country");
			
			//출처 세부 수정
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE 출처_속담 SET 나라 = '" + country + "' WHERE 출처ID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(속담) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
			}
			//출처 세부 새로 등록
			else{
				//출처 세부 종류 바꿔서 등록
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO 출처_속담(나라,출처ID) values('" + country + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(속담) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
				//출처 완전 새로 등록
				else{
					String insert_source_detail_value = "INSERT INTO 출처_속담(나라,출처ID) values('" + country + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>출처(속담) 등록이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
			}
		}else if(sourcegenre.equals("영화")){
			String director = request.getParameter("director");
			String actor = request.getParameter("actor");
			String movieyear = request.getParameter("movieyear");
			String moviegenre = request.getParameter("moviegenre");
			
			//출처 세부 수정
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE 출처_영화 SET 감독 = '" + director + "',주연 = '" + actor + "',개봉년도 = '" + movieyear + "',장르 = '" + moviegenre + "' WHERE 출처ID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(영화) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
			}
			//출처 세부 새로 등록
			else{
				//출처 세부 종류 바꿔서 등록
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO 출처_영화(감독,주연,개봉년도,장르,출처ID) values('" + director + "','" + actor + "','" + movieyear + "','" + moviegenre + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(영화) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
				//출처 완전 새로 등록
				else{
					String insert_source_detail_value = "INSERT INTO 출처_영화(감독,주연,개봉년도,장르,출처ID) values('" + director + "','" + actor + "','" + movieyear + "','" + moviegenre + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>출처(영화) 등록이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
			}
		}else if(sourcegenre.equals("인터넷")){
			String site = request.getParameter("site");
			String url = request.getParameter("url");

			//출처 세부 수정
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE 출처_인터넷 SET 사이트명 = '" + site + "',URL = '" + url + "' WHERE 출처ID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(인터넷) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
			}
			//출처 세부 새로 등록
			else{
				//출처 세부 종류 바꿔서 등록
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO 출처_인터넷(사이트명,URL,출처ID) values('" + site + "','" + url + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(인터넷) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
				//출처 완전 새로 등록
				else{
					String insert_source_detail_value = "INSERT INTO 출처_인터넷(사이트명,URL,출처ID) values('" + site + "','" + url + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>출처(인터넷) 등록이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
			}
		}else if(sourcegenre.equals("인터뷰")){
			String interviewdate = request.getParameter("interviewdate");
			String company = request.getParameter("company");

			//출처 세부 수정
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				String update_source_detail_value = "UPDATE 출처_인터뷰 SET 일자 = '" + interviewdate + "',회사 = '" + company + "' WHERE 출처ID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(인터뷰) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
			}
			//출처 세부 새로 등록
			else{
				//출처 세부 종류 바꿔서 등록
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO 출처_인터뷰(일자,회사,출처ID) values('" + interviewdate + "','" + company + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(인터뷰) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
				//출처 완전 새로 등록
				else{
					String insert_source_detail_value = "INSERT INTO 출처_인터뷰(일자,회사,출처ID) values('" + interviewdate + "','" + company + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>출처(인터뷰) 등록이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
			}
		}else if(sourcegenre.equals("책")){
			String writer = request.getParameter("writer");
			String publishing = request.getParameter("publishing");
			String bookyear = request.getParameter("bookyear");

			//출처 세부 수정
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE 출처_노래 SET 저자 = '" + writer + "',출판사 = '" + publishing + "',출판년도 = '" + bookyear + "' WHERE 출처ID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(책) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
			}
			//출처 세부 새로 등록
			else{
				//출처 세부 종류 바꿔서 등록
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//수정 시에 선택된 출처의 ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO 출처_책(저자,출판사,출판년도,출처ID) values('" + writer + "','" + publishing + "','" + bookyear + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>출처(책) 수정이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
				//출처 완전 새로 등록
				else{
					String insert_source_detail_value = "INSERT INTO 출처_책(저자,출판사,출판년도,출처ID) values('" + writer + "','" + publishing + "','" + bookyear + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>출처(책) 등록이 성공적으로 완료되었습니다!.</h1>
	<br>
	<button type = "submit">완료</button>
	<%
				}
			}
		}else{
	%>
			
	<h1>출처 등록에 실패하였습니다!.</h1>
	<br>
	<button type = "submit">메인페이지로</button>

	<%	
		}
		System.out.println("Success");
		}catch(SQLException se){
	%>
	<h1>인물 등록에 실패하였습니다.</h1>
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