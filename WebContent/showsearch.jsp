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
			
			
			if(selectedsearch.equals("����")){
				String category = request.getParameter("category");
				String phrasesearch = request.getParameter("phrasesearch");
				String phrasefind = request.getParameter("phrasefind");
				String query = "select * from ���� where ī�װ� <= '"+ category +"' and ī�װ� >= '"+ category +"' and "+ phrasesearch +" like '%"+ phrasefind +"%';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>����</b>
		<br>
		<table border="1">
		<tr>
			<th>����</th><th>ī�װ�</th><th>Ű����</th><th>����</th><th>�޸�</th>
		</tr>
	<%	
				while(rs.next()){
					String phrase = rs.getNString("����");
					String phraseCategory = rs.getNString("ī�װ�");
					String phraseKeyword = rs.getNString("Ű����");
					String phraseExplain = rs.getNString("����");
					String phraseMemo = rs.getNString("�޸�");
	%>
		<tr>
		<td><%=phrase %></td> <td><%=phraseCategory %></td> <td><%=phraseKeyword %></td> <td><%=phraseExplain %></td><td><%=phraseMemo %></td>
		</tr>
	<%
				}
	%>
		</table>
	<%
			}else if(selectedsearch.equals("�ι�")){
				String personsearch = request.getParameter("personsearch");
				String personfind = request.getParameter("personfind");
				String query = "select * from �ι� where "+ personsearch +" like '%"+ personfind +"%' ;";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>�ι�</b>
		<br>
		<table border="1">
		<tr>
			<th>�̸�</th><th>����</th><th>����</th><th>�����⵵</th>
		</tr>
	<%	
				while(rs.next()){
					String name = rs.getNString("�̸�");
					String nation = rs.getNString("����");
					String job = rs.getNString("����");
					String birth = rs.getNString("����⵵");
	%>
		<tr>
		<td><%=name %></td> <td><%=nation %></td> <td><%=job %></td> <td><%=birth %></td>
		</tr>
	<%
				}
	%>
		</table>
	<% 
			}else if(selectedsearch.equals("��ó")){
				String sourcefind = request.getParameter("sourcefind");
				session.setAttribute("sourcefind",sourcefind);
				String sourcegenre = request.getParameter("sourcegenre");
				session.setAttribute("sourcegenre",sourcegenre);
				String searchdetail = request.getParameter("searchdetail");
				
				//�������� �˻��ϵ��� �Ѿ
				if(searchdetail.equals("checkon")){
					if(sourcegenre.equals("�뷡")){
	%>
		<h4>�뷡 �������� �˻��ϱ�</h4> 
			<select name = "detailsearch">
				<option value="����">����</option><option value="�ٹ�">�ٹ�</option>
				<option value="�߸ų⵵">�߸ų⵵</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">�˻�</button>
	<%
					}else if(sourcegenre.equals("å")){
	%>
		<h4>å �������� �˻��ϱ�</h4> 
			<select name = "detailsearch">
				<option value="����">����</option><option value="���ǻ�">���ǻ�</option>
				<option value="���ǳ⵵">���ǳ⵵</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">�˻�</button>
	<%
					
					}else if(sourcegenre.equals("��ȭ")){
	%>
		<h4>��ȭ �������� �˻��ϱ�</h4> 
			<select name = "detailsearch">
				<option value="����">����</option><option value="�ֿ�">�ֿ�</option>
				<option value="�����⵵">�����⵵</option><option value="�帣">�帣</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">�˻�</button>
	<%
					
					}else if(sourcegenre.equals("���ͳ�")){
	%>
		<h4>���ͳ� ��ó���� �˻��ϱ�</h4> 
			<select name = "detailsearch">
				<option value="����Ʈ��">����Ʈ��</option><option value="URL">URL</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">�˻�</button>
	<%
					
					}else if(sourcegenre.equals("�Ӵ�")){
	%>
		<h4>�Ӵ� ���� �˻��ϱ�</h4> 
			<b>����</b>&nbsp;
			<input type='text' name='detailfind' value='' placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">�˻�</button>
	<%
					}else if(sourcegenre.equals("���ͺ�")){
	%>
		<h4>���ͺ� ���� �˻��ϱ�</h4> 
			<select name = "detailsearch">
				<option value="����">����</option><option value="ȸ��">ȸ��</option>
			</select>
			<input type='text' name='detailfind' value='' placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="submit">�˻�</button>
	<%
					}
			}else if(searchdetail.equals("checkoff")){ //��ó �⺻ ������ ������
				
				String query = "select * from ��ó where ���� like '%"+ sourcefind +"%' and ���� >= '"+ sourcegenre +"' and ���� <= '"+ sourcegenre +"';";
				rs = stmt.executeQuery(query);
	%>
		<br>
		<b>��ó</b>
		<br>
		<table border="1">
		<tr>
			<th>����</th><th>����</th>
		</tr>
	<%	
				while(rs.next()){
					String name = rs.getNString("����");
					String genre = rs.getNString("����");
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
</form>
</div>
</body>
</html>