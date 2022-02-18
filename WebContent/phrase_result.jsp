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
<title>���� ��� Ȯ��â</title>
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

		int sourceid = 0;
		String insert;
		
		String update_value = (String) session.getAttribute("update_value");

		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String query = "select * from ����";
		String query2 = "select ��óID from ��ó where ����ID='"+ userID +"';";
		String update_query = "";
	
		Connection conn = null;
		Connection conn2 = null;
		
		Statement stmt = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		
		ResultSet rs = null;
		ResultSet rs2 = null;
		
		try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query2);
	
		while(rs.next()){
			int get_sourceid = rs.getInt("��óID");
			insert = request.getParameter("selectedsource"+get_sourceid);
			if(insert != null){
				sourceid = get_sourceid;
				break;
			}
		}
	
		String phrase = (String)session.getAttribute("phrase");
		String category = (String)session.getAttribute("category");
		String keyword = (String)session.getAttribute("keyword");
		String explain = (String)session.getAttribute("explain");
		String memo = (String)session.getAttribute("memo");
		String share = (String)session.getAttribute("share");
		String person_id_str = (String)session.getAttribute("person_id_str");
		int person_id = Integer.parseInt(person_id_str);
	
		Class.forName(driver);
		conn2 = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt2 = conn.createStatement();
		
		//���� ����
		if(update_value.equals("True")){
			String selected_id_str = (String)session.getAttribute("selected_id_str");//���� �ÿ� ���õ� ��ó�� ID(primary key)
			int selected_ID = Integer.parseInt(selected_id_str);
			String update_phrase_value = "UPDATE ���� SET ���� = '" + phrase + "',ī�װ� = '" + category + "',Ű���� = '" + keyword + "',���� = '" + explain + "',�޸� = '" + memo + "',�������� = '" + share + "',����ID = '" + userID + "',��óID = "+ sourceid +",�ι�ID = "+ person_id +" WHERE ����ID = "+ selected_ID +";";
			stmt2.executeUpdate(update_phrase_value);	
	%>
	<h1>���������� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">����ȭ������</button>
	<%
		}
		//���� �ű� ���
		else{
			String query3 = "SELECT ���� FROM ���� WHERE id = '" + userID + "';";
			rs2 = stmt.executeQuery(query3);
			
			//���� �ű� ��Ͻ� ������� ���� +5
			int score = 0;
			while (rs2.next()){
				score = rs2.getInt("����");
			}
			score += 5;
			
			stmt3 = conn.createStatement();
			String update_user_score = "UPDATE ���� SET ���� = "+ score +" WHERE id = '"+ userID +"';";
			stmt3.executeUpdate(update_user_score);
			
			//���� ���
			String insert_phrase_value = "INSERT INTO ����(����,ī�װ�,Ű����,����,�޸�,��������,����ID,��óID,�ι�ID) values('" + phrase + "','" + category + "','" + keyword + "','" + explain + "','" + memo + "','" + share + "','" + userID + "',"+ sourceid +","+ person_id +");";
			stmt2.executeUpdate(insert_phrase_value);
	%>
	<h1>��������� ���������� �Ϸ�Ǿ����ϴ�!.</h1>
	<br>
	<button type = "submit">����ȭ������</button>
	<%
		}
		}catch(SQLException se){
	%>
	<h1>������Ͽ� �����Ͽ����ϴ�.</h1>
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