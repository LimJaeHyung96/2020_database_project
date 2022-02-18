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
<title>�˻�</title>
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
<input type='button' onclick="goLoginPage()" value='�α׾ƿ�' style="float: left;">
<input type='button' onclick="goMainPage()" value='����ȭ������' style="float: left;">
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
			
			
			if(sourcegenre.equals("�뷡")){
				
				String query = "select * from ��ó,��ó_�뷡 where ��ó.��óID = ��ó_�뷡.��óID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>��ó(�뷡)</b>
		<br>
		<table border="1">
		<tr>
			<th>����</th><th>����</th><th>����</th><th>�ٹ�</th><th>�߸ų⵵</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("����");
					String genre = rs.getNString("����");
					String singer = rs.getNString("����");
					String album = rs.getNString("�ٹ�");
					String songyear = rs.getNString("�߸ų⵵");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=singer %></td> <td><%=album %></td> <td><%=songyear %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("�Ӵ�")){
				
				String query = "select * from ��ó,��ó_�Ӵ� where ��ó.��óID = ��ó_�Ӵ�.��óID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>��ó(�Ӵ�)</b>
		<br>
		<table border="1">
		<tr>
			<th>����</th><th>����</th><th>����</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("����");
					String genre = rs.getNString("����");
					String country = rs.getNString("����");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=country %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("��ȭ")){
				
				String query = "select * from ��ó,��ó_��ȭ where ��ó.��óID = ��ó_��ȭ.��óID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>��ó(��ȭ)</b>
		<br>
		<table border="1">
		<tr>
			<th>����</th><th>����</th><th>����</th><th>�ֿ�</th><th>�����⵵</th><th>�帣</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("����");
					String genre = rs.getNString("����");
					String director = rs.getNString("����");
					String actor = rs.getNString("�ֿ�");
					String movieyear = rs.getNString("�����⵵");
					String moviegenre = rs.getNString("�帣");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=director %></td> <td><%=actor %></td> <td><%=movieyear %></td> <td><%=moviegenre %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("���ͳ�")){
				
				String query = "select * from ��ó,��ó_���ͳ� where ��ó.��óID = ��ó_���ͳ�.��óID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>��ó(���ͳ�)</b>
		<br>
		<table border="1">
		<tr>
			<th>����</th><th>����</th><th>����Ʈ��</th><th>URL</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("����");
					String genre = rs.getNString("����");
					String site = rs.getNString("����Ʈ��");
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
			}else if(sourcegenre.equals("���ͺ�")){
				
				String query = "select * from ��ó,��ó_���ͺ� where ��ó.��óID = ��ó_���ͺ�.��óID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>��ó(���ͺ�)</b>
		<br>
		<table border="1">
		<tr>
			<th>����</th><th>����</th><th>����</th><th>ȸ��</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("����");
					String genre = rs.getNString("����");
					String date = rs.getNString("����");
					String company = rs.getNString("ȸ��");
	%>
		<tr>
		<td><%=name %></td> <td><%=genre %></td> <td><%=date %></td> <td><%=company %></td>
		</tr>
	<%
				}
	%>
	</table>
	<% 
			}else if(sourcegenre.equals("å")){
				
				String query = "select * from ��ó,��ó_å where ��ó.��óID = ��ó_å.��óID and "+ detailsearch +" like '%"+ detailfind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>��ó(å)</b>
		<br>
		<table border="1">
		<tr>
			<th>����</th><th>����</th><th>����</th><th>���ǻ�</th><th>���ǳ⵵</th>
		</tr>
	<%	
				
				while(rs.next()){
					String name = rs.getNString("����");
					String genre = rs.getNString("����");
					String writer = rs.getNString("����");
					String publishing = rs.getNString("���ǻ�");
					String bookyear = rs.getNString("���ǳ⵵");
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
		<h1>DB �˻��� �����Ͽ����ϴ�.</h1>
		<br>
		<button type = "button" onclick = "goMainPage()">����</button>	
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