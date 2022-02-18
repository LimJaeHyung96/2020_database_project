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
<title>문구 데이터베이스</title>
<link href='pagestyle.css' rel='stylesheet' style='text/css'/>
	<script type="text/javascript">
        function goPersonRegister() {
            location.href="person_register.jsp";
        } 
        
        function goPhraseRegister() {
            location.href="phrase_register.jsp";
        }
        
        function goResourceRegister() {
            location.href="source_register.jsp";
        }
        
        function goLoginPage() {
            location.href="loginpage.jsp";
        }
        
        function goMainPage() {
            location.href="mainpage.jsp";
        }
        
        function goShowUserPhrase() {
            location.href="showuserphrase.jsp";
        }
        
        function goShowSharePhrase() {
            location.href="showsharephrase.jsp";
        }
    </script>
</head>
<body>
	<%
		String userID = (String)session.getAttribute("id");
	%>
<div>
<input type='button' onclick="goLoginPage()" value='로그아웃' style="float: left;">
<input type='button' onclick="goShowSharePhrase()" value='공유된 문구 보기' style="float: left;">
<p style="text-align:right; text-decoration:underline" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<div id="wrap">
<h1>문구 데이터베이스</h1>
<h2>당신만의 문구를 관리하세요!</h2>
	<%
		String update_value = "False";
		session.setAttribute("update_value",update_value); //신규 등록시 생기는 문제 해결
		String selectedgenre= "없음";
		session.setAttribute("selectedgenre",selectedgenre);//출처 세부 신규 등록시 생기는 문제 해결
	%>
	<form action="searchdatabase.jsp" method="post" name="MainPage">
	<hr>
	<h4>DB 검색하기</h4>
	<b>DB 선택 :</b> 
			<select name = "search">
				<option value="문구">문구</option><option value="인물">인물</option>
				<option value="출처">출처</option>
			</select>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="submit">검색</button>
	<br><br>
	<hr>
</form>
<form action="updateordelpage.jsp" method="post" name="MainPage">
	<hr>
	<h4>DB 수정 및 삭제하기</h4>
	<b>DB 선택 :</b> 
			<select name = "select">
				<option value="문구">문구</option><option value="인물">인물</option>
				<option value="출처">출처</option>
			</select>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="submit">수정/삭제</button>
	<br><br>
	<hr>
</form>
	<hr>
	<h4>DB 등록하기</h4>
	<button type="button" onclick="goPhraseRegister()">문구등록</button>&nbsp;&nbsp;
	<button type="button" onclick="goResourceRegister()">출처등록</button>&nbsp;&nbsp;
	<button type="button" onclick="goPersonRegister()">인물등록</button>
	<br><br>
	<hr>
</div>
</body>
</html>