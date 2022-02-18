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
<title>��ó ���λ��� ���</title>
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
<input type='button' onclick="goLoginPage()" value='�α׾ƿ�' style="float: left;">
<input type='button' onclick="goMainPage()" value='����ȭ������' style="float: left;">
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
		String query = "select * from ��ó";
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
		
		String selectedgenre = (String)session.getAttribute("selectedgenre"); //���� �ÿ� ���õ� �帣 ���� ������.
		
		//������ �� ����� �帣���� ���� ������ �帣�� ���� �� - ��ó ���ΰ��� �״�� ������� ��
		if(selectedgenre.equals(genre)){
			String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
			int selected_ID = Integer.parseInt(selected_id_str);
			
			String update_source_value ="UPDATE ��ó SET ���� = '"+ name +"',���� = '"+ genre +"' WHERE ��óID="+ selected_ID +";";
			stmt.executeUpdate(update_source_value);	
	%>	
	<h1>��ó ������ ���������� �Ϸ�Ǿ����ϴ�!</h1>
	<h2>���� ��ó ���������� �����غ����?</h2>	
	<%
			//���õ� �帣�� �´� �帣�� �����鼭 �ؽ�Ʈ�ڽ��� ������ �� �־�� ��.
			if(selectedgenre.equals("�뷡")){
				
				stmt2 = conn.createStatement();
				String query2 = "select * from ��ó_�뷡 where ��óID="+ selected_ID +";";
				rs = stmt2.executeQuery(query2);
				
				String singer = null;
				String album = null;
				String songyear = null;
				
				while(rs.next()){
					singer = rs.getNString("����");
					album = rs.getNString("�ٹ�");
					songyear = rs.getNString("�߸ų⵵");
				}
		%>
			<br>
			<b>����</b> 
			<br>
			<input type = "text" name = "singer" maxlength="20" value="<%=singer%>"> 
			<br>
			<br>
			<b>�ٹ�</b> 
			<br>
			<input type = "text" name = "album" maxlength="30" value="<%=album%>"> 
			<br>
			<br>
			<b>�߸ų⵵</b> 
			<br>
			<input type = "text" name = "songyear" maxlength="20" value="<%=songyear%>"> 
			<br>
			<button type = "submit">�Ϸ�</button>
		<%		
				}else if(selectedgenre.equals("å")){
					stmt2 = conn.createStatement();
					String query2 = "select * from ��ó_å where ��óID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String writer = null;
					String publishing = null;
					String bookyear = null;
					
					while(rs.next()){
						writer = rs.getNString("����");
						publishing = rs.getNString("���ǻ�");
						bookyear = rs.getNString("���ǳ⵵");
					}
		%>
			<br>
			<b>����</b> 
			<br>
			<input type = "text" name = "writer" maxlength="20" value="<%=writer%>"> 
			<br>
			<br>
			<b>���ǻ�</b> 
			<br>
			<input type = "text" name = "publishing" maxlength="10" value="<%=publishing%>"> 
			<br>
			<br>
			<b>���ǳ⵵</b> 
			<br>
			<input type = "text" name = "bookyear" maxlength="20" value="<%=bookyear%>"> 
			<br>
			<button type = "submit">�Ϸ�</button>
		<%	
				}else if(selectedgenre.equals("�Ӵ�")){
					stmt2 = conn.createStatement();
					String query2 = "select * from ��ó_�Ӵ� where ��óID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String country = null;
					
					while(rs.next()){
						country = rs.getNString("����");
					}
		%>
			<br>
			<b>����</b> 
			<br>
			<input type = "text" name = "country" maxlength="20" value="<%=country%>"> 
			<br>
			<button type = "submit">�Ϸ�</button>
		<%	
				}else if(selectedgenre.equals("��ȭ")){
					stmt2 = conn.createStatement();
					String query2 = "select * from ��ó_��ȭ where ��óID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String director = null;
					String actor = null;
					String movieyear = null;
					String moviegenre = null;
					
					while(rs.next()){
						director = rs.getNString("����");
						actor = rs.getNString("�ֿ�");
						movieyear = rs.getNString("�����⵵");
						moviegenre = rs.getNString("�帣");
					}
		%>
			<br>
			<b>����</b> 
			<br>
			<input type = "text" name = "director" maxlength="20" value="<%=director%>"> 
			<br>
			<br>
			<b>�ֿ�</b> 
			<br>
			<input type = "text" name = "actor" maxlength="50" value="<%=actor%>"> 
			<br>
			<br>
			<b>�����⵵</b> 
			<br>
			<input type = "text" name = "movieyear" maxlength="10" value="<%=movieyear%>"> 
			<br>
			<br>
			<b>�帣</b> 
			<br>
			<input type = "text" name = "moviegenre" maxlength="15" value="<%=moviegenre%>"> 
			<br>
			<button type = "submit">�Ϸ�</button>
		<%	
				}else if(selectedgenre.equals("���ͳ�")){
					stmt2 = conn.createStatement();
					String query2 = "select * from ��ó_���ͳ� where ��óID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String site = null;
					String url = null;
					
					while(rs.next()){
						site = rs.getNString("����Ʈ��");
						url = rs.getNString("URL");
					}
		%>
			<br>
			<b>����Ʈ��</b> 
			<br>
			<input type = "text" name = "site" maxlength="20" value="<%=site%>"> 
			<br>
			<br>
			<b>URL</b> 
			<br>
			<input type = "text" name = "url" maxlength="300" value="<%=url%>"> 
			<br>
			<button type = "submit">�Ϸ�</button>
		<%	
				}else if(selectedgenre.equals("���ͺ�")){
					stmt2 = conn.createStatement();
					String query2 = "select * from ��ó_���ͺ� where ��óID="+ selected_ID +";";
					rs = stmt2.executeQuery(query2);
					
					String interviewdate = null;
					String company = null;
					
					while(rs.next()){
						interviewdate = rs.getNString("����");
						company = rs.getNString("ȸ��");
					}
		%>
			<br>
			<b>����</b> 
			<br>
			<input type = "text" name = "interviewdate" maxlength="20" value="<%=interviewdate%>"> 
			<br>
			<br>
			<b>���ͺ��� ȸ��</b> 
			<br>
			<input type = "text" name = "company" maxlength="30" value="<%=company%>"> 
			<br>
			<button type = "submit">�Ϸ�</button>
		<%
			}
		}
		//������ �� ���õ� �帣���� ���� �帣�� �ٸ� �� - ���� ��ó ���θ� �����ϰ� ���� ���ų� �ű� ���
		else{
			//���� ��ó ���� ���� - �����ϴ� ��
			if(update_value.equals("True")){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				//��ó ������Ʈ
				String update_source_value ="UPDATE ��ó SET ���� = '"+ name +"',���� = '"+ genre +"' WHERE ��óID="+ selected_ID +";";
				stmt.executeUpdate(update_source_value);
				//���� ���� ��ó ���� ����
				stmt2 = conn.createStatement();
				String query2 = "delete from ��ó_"+ selectedgenre +" where ��óID="+ selected_ID +";";
				rs = stmt2.executeQuery(query2);
	%>	
	<h1>��ó ������ ���������� �Ϸ�Ǿ����ϴ�!</h1>
	<h2>���� ��ó ���������� �����غ����?</h2>	
	<%
			}
			//�űԵ��
			else if(update_value.equals("False")){
				String insert_source_value = "INSERT INTO ��ó(����,����,����ID) values('" + name + "','" + genre + "','" + userID + "');";
				stmt.executeUpdate(insert_source_value);
	%>	
	<h1>��ó ����� ���������� �Ϸ�Ǿ����ϴ�!</h1>
	<h2>���� ��ó ���������� �Է��غ����?</h2>
	<%
			}
			//���ο� ��ó ���θ� ���������
			if(genre.equals("�뷡")){
				%>
					<br>
					<b>����</b> 
					<br>
					<input type = "text" name = "singer" maxlength="20"> 
					<br>
					<br>
					<b>�ٹ�</b> 
					<br>
					<input type = "text" name = "album" maxlength="30"> 
					<br>
					<br>
					<b>�߸ų⵵</b> 
					<br>
					<input type = "text" name = "songyear" maxlength="20"> 
					<br>
					<button type = "submit">�Ϸ�</button>
				<%		
						}else if(genre.equals("å")){
				%>
					<br>
					<b>����</b> 
					<br>
					<input type = "text" name = "writer" maxlength="20"> 
					<br>
					<br>
					<b>���ǻ�</b> 
					<br>
					<input type = "text" name = "publishing" maxlength="10"> 
					<br>
					<br>
					<b>���ǳ⵵</b> 
					<br>
					<input type = "text" name = "bookyear" maxlength="20"> 
					<br>
					<button type = "submit">�Ϸ�</button>
				<%	
						}else if(genre.equals("�Ӵ�")){
				%>
					<br>
					<b>����</b> 
					<br>
					<input type = "text" name = "country" maxlength="20"> 
					<br>
					<button type = "submit">�Ϸ�</button>
				<%	
						}else if(genre.equals("��ȭ")){
				%>
					<br>
					<b>����</b> 
					<br>
					<input type = "text" name = "director" maxlength="20"> 
					<br>
					<br>
					<b>�ֿ�</b> 
					<br>
					<input type = "text" name = "actor" maxlength="50"> 
					<br>
					<br>
					<b>�����⵵</b> 
					<br>
					<input type = "text" name = "movieyear" maxlength="10"> 
					<br>
					<br>
					<b>�帣</b> 
					<br>
					<input type = "text" name = "moviegenre" maxlength="15"> 
					<br>
					<button type = "submit">�Ϸ�</button>
				<%	
						}else if(genre.equals("���ͳ�")){
				%>
					<br>
					<b>����Ʈ��</b> 
					<br>
					<input type = "text" name = "site" maxlength="20"> 
					<br>
					<br>
					<b>URL</b> 
					<br>
					<input type = "text" name = "url" maxlength="300"> 
					<br>
					<button type = "submit">�Ϸ�</button>
				<%	
						}else if(genre.equals("���ͺ�")){
				%>
					<br>
					<b>����</b> 
					<br>
					<input type = "text" name = "interviewdate" maxlength="20"> 
					<br>
					<br>
					<b>���ͺ��� ȸ��</b> 
					<br>
					<input type = "text" name = "company" maxlength="30"> 
					<br>
					<button type = "submit">�Ϸ�</button>
				<%
				}
			}
		}catch(SQLException se){
	%>
	<h1>��ó ��Ͽ� �����Ͽ����ϴ�.</h1>
	<br>
	<button type = "button" onclick="goMainPage()">����</button>	
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