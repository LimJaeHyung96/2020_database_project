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
<title>DB ����/����</title>
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
<input type='button' onclick="goLoginPage()" value='�α׾ƿ�' style="float: left;">
<input type='button' onclick="goMainPage()" value='����ȭ������' style="float: left;">
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
		<b>����/����</b>
		<br>
		<input type = "radio" name = "upordel" value = "����" checked>����
		<input type = "radio" name = "upordel" value = "����">����
		<br>
		<br>
	<%
		if(select.equals("����")){
			String query = "select ����ID,����,ī�װ�,Ű����,����,�޸� from ���� where ����ID='"+ userID +"';";
			rs = stmt.executeQuery(query);
	%>
		<br>
		<b>����</b>
		<br>
		<table border="1">
			<tr>
				<th>����</th><th>����ID</th><th>����</th><th>ī�װ�</th><th>Ű����</th><th>����</th><th>�޸�</th>
			</tr>
	<%	
		while(rs.next()){
			int phraseID = rs.getInt("����ID");
			String phrase = rs.getNString("����");
			String phraseCategory = rs.getNString("ī�װ�");
			String phraseKeyword = rs.getNString("Ű����");
			String phraseExplain = rs.getNString("����");
			String phraseMemo = rs.getNString("�޸�");
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
		<Button type = "submit">���ÿϷ�</Button>
	<%	
			}else if(select.equals("��ó")){
				String query = "select ��óID,����,���� from ��ó where ����ID='"+ userID +"';";
				rs = stmt.executeQuery(query);
		%>
			<b>��ó</b>
			<br>
			<table border="1">
				<tr>
					<th>����</th><th>��óID</th><th>����</th><th>����</th>
				</tr>
		<%	
			while(rs.next()){
				int sourceID = rs.getInt("��óID");
				String sourceName = rs.getNString("����");
				String sourceCategory = rs.getNString("����");
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
			<Button type = "submit">���ÿϷ�</Button>
		<%	
				}else if(select.equals("�ι�")){
					String query = "select �ι�ID,�̸�,����,����,����⵵ from �ι� where ����ID='"+ userID +"';";
					rs = stmt.executeQuery(query);
		%>
				<b>�ι�</b>
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
					<td><input type="checkbox" name="selected<%=personID%>"></td>
					<td><%=personID %></td> <td><%=personName %></td> <td><%=personNation %></td> <td><%=personJob %></td> <td><%=personYear %></td>
					</tr>
			<%
					}
			%>
				</table>
				<br>
				<Button type = "submit">���ÿϷ�</Button>
			<%	
					}
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