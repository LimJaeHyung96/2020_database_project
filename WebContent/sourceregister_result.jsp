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
<title>��ó��� Ȯ��â</title>
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
		String query = "select * from ��ó_" + sourcegenre;
		String update_query = "";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String query2 = "select ��óID from ��ó where ����='"+sourcename+"' and ����='"+sourcegenre+"' and ����ID='"+userID+"';";
		rs = stmt.executeQuery(query2);
		int sourceID = 0;
		while(rs.next()){
			sourceID = rs.getInt(1);
		}
		
		if(sourcegenre.equals("�뷡")){
			String singer = request.getParameter("singer");
			String album = request.getParameter("album");
			String songyear = request.getParameter("songyear");
			
			//��ó ���� ����
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE ��ó_�뷡 SET ���� = '" + singer + "',�ٹ� = '" + album + "',�߸ų⵵ = '" + songyear + "' WHERE ��óID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(�뷡) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
			}
			//��ó ���� ���� ���
			else{
				//��ó ���� ���� �ٲ㼭 ���
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO ��ó_�뷡(����,�ٹ�,�߸ų⵵,��óID) values('" + singer + "','" + album + "','" + songyear + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(�뷡) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
				//��ó ���� ���� ���
				else{
					String insert_source_detail_value = "INSERT INTO ��ó_�뷡(����,�ٹ�,�߸ų⵵,��óID) values('" + singer + "','" + album + "','" + songyear + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>��ó(�뷡) ����� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
			}
		}else if(sourcegenre.equals("�Ӵ�")){
			String country = request.getParameter("country");
			
			//��ó ���� ����
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE ��ó_�Ӵ� SET ���� = '" + country + "' WHERE ��óID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(�Ӵ�) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
			}
			//��ó ���� ���� ���
			else{
				//��ó ���� ���� �ٲ㼭 ���
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO ��ó_�Ӵ�(����,��óID) values('" + country + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(�Ӵ�) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
				//��ó ���� ���� ���
				else{
					String insert_source_detail_value = "INSERT INTO ��ó_�Ӵ�(����,��óID) values('" + country + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>��ó(�Ӵ�) ����� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
			}
		}else if(sourcegenre.equals("��ȭ")){
			String director = request.getParameter("director");
			String actor = request.getParameter("actor");
			String movieyear = request.getParameter("movieyear");
			String moviegenre = request.getParameter("moviegenre");
			
			//��ó ���� ����
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE ��ó_��ȭ SET ���� = '" + director + "',�ֿ� = '" + actor + "',�����⵵ = '" + movieyear + "',�帣 = '" + moviegenre + "' WHERE ��óID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(��ȭ) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
			}
			//��ó ���� ���� ���
			else{
				//��ó ���� ���� �ٲ㼭 ���
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO ��ó_��ȭ(����,�ֿ�,�����⵵,�帣,��óID) values('" + director + "','" + actor + "','" + movieyear + "','" + moviegenre + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(��ȭ) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
				//��ó ���� ���� ���
				else{
					String insert_source_detail_value = "INSERT INTO ��ó_��ȭ(����,�ֿ�,�����⵵,�帣,��óID) values('" + director + "','" + actor + "','" + movieyear + "','" + moviegenre + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>��ó(��ȭ) ����� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
			}
		}else if(sourcegenre.equals("���ͳ�")){
			String site = request.getParameter("site");
			String url = request.getParameter("url");

			//��ó ���� ����
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE ��ó_���ͳ� SET ����Ʈ�� = '" + site + "',URL = '" + url + "' WHERE ��óID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(���ͳ�) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
			}
			//��ó ���� ���� ���
			else{
				//��ó ���� ���� �ٲ㼭 ���
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO ��ó_���ͳ�(����Ʈ��,URL,��óID) values('" + site + "','" + url + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(���ͳ�) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
				//��ó ���� ���� ���
				else{
					String insert_source_detail_value = "INSERT INTO ��ó_���ͳ�(����Ʈ��,URL,��óID) values('" + site + "','" + url + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>��ó(���ͳ�) ����� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
			}
		}else if(sourcegenre.equals("���ͺ�")){
			String interviewdate = request.getParameter("interviewdate");
			String company = request.getParameter("company");

			//��ó ���� ����
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				String update_source_detail_value = "UPDATE ��ó_���ͺ� SET ���� = '" + interviewdate + "',ȸ�� = '" + company + "' WHERE ��óID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(���ͺ�) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
			}
			//��ó ���� ���� ���
			else{
				//��ó ���� ���� �ٲ㼭 ���
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO ��ó_���ͺ�(����,ȸ��,��óID) values('" + interviewdate + "','" + company + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(���ͺ�) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
				//��ó ���� ���� ���
				else{
					String insert_source_detail_value = "INSERT INTO ��ó_���ͺ�(����,ȸ��,��óID) values('" + interviewdate + "','" + company + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>��ó(���ͺ�) ����� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
			}
		}else if(sourcegenre.equals("å")){
			String writer = request.getParameter("writer");
			String publishing = request.getParameter("publishing");
			String bookyear = request.getParameter("bookyear");

			//��ó ���� ����
			if(selectedgenre.equals(sourcegenre)){
				String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
				int selected_ID = Integer.parseInt(selected_id_str);
				
				String update_source_detail_value = "UPDATE ��ó_�뷡 SET ���� = '" + writer + "',���ǻ� = '" + publishing + "',���ǳ⵵ = '" + bookyear + "' WHERE ��óID=" + selected_ID + ";";
				stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(å) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
			}
			//��ó ���� ���� ���
			else{
				//��ó ���� ���� �ٲ㼭 ���
				if(update_value.equals("True")){
					String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
					int selected_ID = Integer.parseInt(selected_id_str);
					
					String update_source_detail_value = "INSERT INTO ��ó_å(����,���ǻ�,���ǳ⵵,��óID) values('" + writer + "','" + publishing + "','" + bookyear + "','" + selected_ID + "');";
					stmt.executeUpdate(update_source_detail_value);
	%>		
	<h1>��ó(å) ������ ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
				//��ó ���� ���� ���
				else{
					String insert_source_detail_value = "INSERT INTO ��ó_å(����,���ǻ�,���ǳ⵵,��óID) values('" + writer + "','" + publishing + "','" + bookyear + "','" + sourceID + "');";
					stmt.executeUpdate(insert_source_detail_value);
	%>
	
	<h1>��ó(å) ����� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">�Ϸ�</button>
	<%
				}
			}
		}else{
	%>
			
	<h1>��ó ��Ͽ� �����Ͽ����ϴ�!.</h1>
	<br>
	<button type = "submit">������������</button>

	<%	
		}
		System.out.println("Success");
		}catch(SQLException se){
	%>
	<h1>�ι� ��Ͽ� �����Ͽ����ϴ�.</h1>
	<br>
	<button type = "submit">����</button>	
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