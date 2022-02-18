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
<form action="showsearch.jsp" method="post" name="MainPage">
<div id="wrap">
	<%
		request.setCharacterEncoding("euc-kr");
	
		String selectedsearch = request.getParameter("search");
		session.setAttribute("selectedsearch",selectedsearch);
	
		if(selectedsearch.equals("����")){
	%>
	<h4>DB �˻��ϱ�</h4> 
		<input type = "radio" name = "category" value = "���">���
		<input type = "radio" name = "category" value = "�̺�">�̺�
		<input type = "radio" name = "category" value = "���">���
		<input type = "radio" name = "category" value = "����">����
		<input type = "radio" name = "category" value = "����">����
		<input type = "radio" name = "category" value = "��Ÿ">��Ÿ
		<br><br>
		<select name = "phrasesearch">
			<option value="����">����</option><option value="Ű����">Ű����</option>
			<option value="����">����</option><option value="�޸�">�޸�</option>
		</select>
		<input type="text" name="phrasefind" placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="submit">�˻�</button>
	<%
		}else if(selectedsearch.equals("��ó")){
	%>
	<h4>��ó �˻��ϱ�</h4> 
		<input type = "radio" name = "sourcegenre" value = "�뷡">�뷡
		<input type = "radio" name = "sourcegenre" value = "å">å	
		<input type = "radio" name = "sourcegenre" value = "��ȭ">��ȭ
		<input type = "radio" name = "sourcegenre" value = "���ͳ�">���ͳ�
		<input type = "radio" name = "sourcegenre" value = "�Ӵ�">�Ӵ�
		<input type = "radio" name = "sourcegenre" value = "���ͺ�">���ͺ�
		<br><br>
		<b>����</b>&nbsp;
		<input type='text' name='sourcefind' placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="submit">�˻�</button>
		<br>
		���� �˻�:
		<input type = "radio" name = "searchdetail" value = "checkon" checked>O
		<input type = "radio" name = "searchdetail" value = "checkoff">X
	<%
		}else if(selectedsearch.equals("�ι�")){
	%>
	<h4>�ι� �˻��ϱ�</h4> 
		<select name = "personsearch">
			<option value="�̸�">�̸�</option><option value="����">����</option>
			<option value="����">����</option><option value="����⵵">����⵵</option>
		</select>
		<input type='text' name='personfind' placeholder="Ư�����ڴ� ����Ҽ� �����ϴ�.">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="submit">�˻�</button>
	<%
						}
	%>
</div>
</form>
</body>
</html>