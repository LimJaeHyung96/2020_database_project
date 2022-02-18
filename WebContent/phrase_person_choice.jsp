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
<title>���� �ι� ����</title>
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
<input type='button' onclick="goLoginPage()" value='�α׾ƿ�' style="float: left;">
<input type='button' onclick="goMainPage()" value='����ȭ������' style="float: left;">
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
		String query = "select �ι�ID,�̸�,����,����,����⵵ from �ι� where ����ID='"+ userID +"';";
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
		<b>�ι�</b>
		������ �ι��� �������ּ���.(�ϳ��� ���� ����)
		<br>
		<table border="1">
			<tr>
				<th>����</th><th>�ι�ID</th><th>�̸�</th><th>����</th><th>����</th><th>����⵵</th>
			</tr>
	<%	
		while(rs.next()){
			int personID = rs.getInt("�ι�ID");
			String personName = rs.getNString("�̸�");
			String personNation = rs.getNString("����");
			String personJob = rs.getNString("����");
			String personYear = rs.getNString("����⵵");
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
		<Button type = "submit">������ ��ó ����ϱ�</Button>
	<%	
		}catch(SQLException se){
	%>
		<br>
		<Button type = "button" onclick="goMainPage()">����ϱ�</Button>
		<Button type = "submit">���ư���</Button>
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