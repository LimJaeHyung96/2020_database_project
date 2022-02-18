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
<title>로그인 중...</title>
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
<div id="wrap">
	<form action="loginpage.jsp" name="result">
	<%
		request.setCharacterEncoding("euc-kr");
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		session.setAttribute("id", id);
		session.setAttribute("password", password);

		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select id,password from 유저;";
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
		
		int login_value = 2;
		while(rs.next()){
			String db_id = rs.getNString("id");
			String db_password = rs.getNString("password");
			if(id.equals(db_id)){
				if(password.equals(db_password)){
					login_value = 1;
					break;
				}else{
					login_value = 0;
					break;
				}
			}else
				login_value = -1;
			}

		if(login_value == 1){
	%>
		<h1><%=id %>님 환영합니다.</h1>
		<br>
		<Button type = "button" onclick="goMainPage()">계속하기</Button>
		<Button type = "submit">돌아가기</Button>
	<%
		}else if(login_value == 0){
	%>
		<h1>비밀번호가 틀렸습니다.</h1>
		<br>
		<Button type = "submit">돌아가기</Button>
	<%
		}else if(login_value == -1){
	%>
		<h1>없는 아이디입니다. 회원가입을 해주세요</h1>
		<br>
		<Button type = "submit">돌아가기</Button>
		<button type="button" onclick="goUserRegisterForm()">회원가입</button>
	<%
		}else{
	%>
		<h1>잘못된 접근입니다.</h1>
		<br>
		<Button type = "submit">돌아가기</Button>
		<button type="button" onclick="goUserRegisterForm()">회원가입</button>
	<%
				}
		
		}catch(SQLException se){

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