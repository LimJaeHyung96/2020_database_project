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
<title>�α��� ��...</title>
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
		String query = "select id,password from ����;";
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
		<h1><%=id %>�� ȯ���մϴ�.</h1>
		<br>
		<Button type = "button" onclick="goMainPage()">����ϱ�</Button>
		<Button type = "submit">���ư���</Button>
	<%
		}else if(login_value == 0){
	%>
		<h1>��й�ȣ�� Ʋ�Ƚ��ϴ�.</h1>
		<br>
		<Button type = "submit">���ư���</Button>
	<%
		}else if(login_value == -1){
	%>
		<h1>���� ���̵��Դϴ�. ȸ�������� ���ּ���</h1>
		<br>
		<Button type = "submit">���ư���</Button>
		<button type="button" onclick="goUserRegisterForm()">ȸ������</button>
	<%
		}else{
	%>
		<h1>�߸��� �����Դϴ�.</h1>
		<br>
		<Button type = "submit">���ư���</Button>
		<button type="button" onclick="goUserRegisterForm()">ȸ������</button>
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