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
<title>���� ��ó ����</title>
	<script type="text/javascript">
        function goLoginPage() {
            location.href="loginpage.jsp";
        }
        
        function goMainPage() {
            location.href="mainpage.jsp";
        }
    </script>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
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
	<%
		int selectedID = 0;
		String insert;
		
		request.setCharacterEncoding("euc-kr");
		
		String upordel = request.getParameter("upordel");
		String select = (String) session.getAttribute("select");

		String jdbcDriver = "jdbc:mariadb://localhost:3306/myproject";
		String dbUser = "root";
		String dbPass = "9612";
		String update_query = "";
		
		Connection conn = null;
		Connection conn2 = null;
		Statement stmt = null;
		Statement stmt2 = null;
		ResultSet rs = null;
		ResultSet rs2 = null;

	try{
		String driver = "org.mariadb.jdbc.Driver";
		Class.forName(driver);
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String query = "select "+ select +"ID from "+ select +" where ����ID='"+ userID +"';";		
		rs = stmt.executeQuery(query);
		while(rs.next()){
			int get_selectedID = rs.getInt(select+"ID");
			insert = request.getParameter("selected"+get_selectedID);
			if(insert != null){
				selectedID = get_selectedID;
				break;
			}
		}
		String selected_id_str = Integer.toString(selectedID);
		session.setAttribute("selected_id_str",selected_id_str);
		
		conn2 = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt2 = conn.createStatement();
		
		//�� ���������� ���� ��ư���� �����ϰ� ����� ���� ���� ���� �� �Ѿ���� �ÿ� �������������� ������ ������ �����ͺ��̽��� ���õ� ���� ��������
		//�����ͺ��̽� ����
		if(upordel.equals("����")){
			String query2 = "DELETE FROM "+ select +" WHERE "+ select +"ID="+ selectedID +";";
			stmt2.executeUpdate(query2);
	%>
		<h1><%=select %> ������ �Ϸ�Ǿ����ϴ�.</h1>
		<br>
		<button type="button" onclick="goMainPage()">����ȭ������</button>
	<%
		}
		//���� ��ư �� ������ �����ͺ��̽��� ������ ���� ������ �� �ֵ��� ��.
		//���� �����ͺ��̽� ����
		else if(upordel.equals("����") && select.equals("����")){
	%>
	<form action = "phrase_person_choice.jsp" method="post">
	<%
			
			String query2 = "select ����,Ű����,����,�޸� from ���� where ����ID="+ selectedID +";";
			rs2 = stmt2.executeQuery(query2);
			
			String phrase = null;
			String keyword = null;
			String explain = null;
			String memo = null;
			String update_value = "True";
			session.setAttribute("update_value",update_value);
			
			while(rs2.next()){
				phrase = rs2.getNString("����");
				keyword = rs2.getNString("Ű����");
				explain = rs2.getNString("����");
				memo = rs2.getNString("�޸�");
			}
	%>
	<h1>���� ����</h1>
		<br>
		<b>����</b> 
		<br>
		<input type = "text" name = "phrase" maxlength="100" value="<%=phrase %>"> 
		<br>
		<br>
		<b>ī�װ� :</b> 
			<select name = "category">
				<option value="���">���</option><option value="�̺�">�̺�</option>
				<option value="���">���</option><option value="����">����</option>
				<option value="����">����</option><option value="��Ÿ">��Ÿ</option>
			</select>
		<br>
		<br>
		<b>Ű����</b> 
		<br>
		<input type = "text" name = "keyword" maxlength="10" value="<%=keyword %>"> 
		<br>
		<br>
		<b>����</b> 
		<br>
		<input type = "text" name = "explain" maxlength="50"value="<%=explain %>"> 
		<br>
		<br>
		<b>�޸�</b> 
		<br>
		<input type = "text" name = "memo" maxlength="30" value="<%=memo %>"> 
		<br>
		<br>
		<b>���� ����</b>
		<br>
		<input type = "radio" name = "share" value = "YES">YES
		<input type = "radio" name = "share" value = "NO" checked>NO
		<br>
		<br>
		<button type="submit">�ι� �����Ϸ� ����</button>
	</form>
	<%
		}
		//��ó �����ͺ��̽� ����
		else if(upordel.equals("����") && select.equals("��ó")){
	%>
	<form action = "source_detail_register.jsp" method="post">
	<%
			
			String query2 = "select ����,���� from ��ó where ��óID="+ selectedID +";";
			rs2 = stmt2.executeQuery(query2);
			
			String sourcename = null;
			String selectedgenre = null;
			String update_value = "True";
			session.setAttribute("update_value",update_value);
			
			while(rs2.next()){
				sourcename = rs2.getNString("����");
				selectedgenre = rs2.getNString("����");
			}
			session.setAttribute("selectedgenre",selectedgenre);
	%>
	<h1>��ó ����</h1>
		<br>
		<b>��ó ����</b> 
		<br>
		<input type = "text" name = "name" maxlength="50" value="<%=sourcename %>"> 
		<br>
		<br>
		<b>���� :</b> 
			<select name = "genre">
				<option>å</option><option>��ȭ</option>
				<option>�뷡</option><option>���ͳ�</option>
				<option>���ͺ�</option><option>�Ӵ�</option>
			</select>
		<br>
		<br>
		<button type="submit">��������</button>
	</form>
	<%
		}
		//�ι� �����ͺ��̽� ����
		else if(upordel.equals("����") && select.equals("�ι�")){
	%>
	<form action = "personregister_result.jsp" method="post">
	<%
			
			String query2 = "select �̸�,����,����,����⵵ from �ι� where �ι�ID="+ selectedID +";";
			rs2 = stmt2.executeQuery(query2);
			
			String personname = null;
			String nation = null;
			String job = null;
			String birth = null;
			String update_value = "True";
			session.setAttribute("update_value",update_value);
			
			while(rs2.next()){
				personname = rs2.getNString("�̸�");
				nation = rs2.getNString("����");
				job = rs2.getNString("����");
				birth = rs2.getNString("����⵵");
			}	
	%>
		<h1>�ι� ����</h1>
		<br>
		<b>�ι� �̸�</b> 
		<br>
		<input type = "text" name = "name" maxlength="50" value="<%=personname %>"> 
		<br>
		<br>
		<b>����</b> 
		<br>
		<input type = "text" name = "nation" maxlength="10" value="<%=nation %>">
		<br>
		<br>
		<b>����</b>
		<br>
		<input type = "text" name = "job" maxlength="10" value="<%=job %>">
		<br>
		<br>
		<b>����⵵</b>
		<br>
		<input type="text" name="year" value="<%= birth%>">
		<br>
		<br>
		<button type="submit">����</button>
	</form>
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
</div>
</body>
</html>