<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>검색</title>
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
<input type='button' onclick="goLoginPage()" value='로그아웃' style="float: left;">
<input type='button' onclick="goMainPage()" value='메인화면으로' style="float: left;">
<p style="text-decoration:underline; text-align:right;" onclick="goShowUserPhrase()"><b><%=userID %></b></p>
<hr>
</div>
<form action="showsearch.jsp" method="post" name="MainPage">
<div id="wrap">
	<%
		request.setCharacterEncoding("euc-kr");
	
		String selectedsearch = request.getParameter("search");
		session.setAttribute("selectedsearch",selectedsearch);
	
		if(selectedsearch.equals("문구")){
	%>
	<h4>DB 검색하기</h4> 
		<input type = "radio" name = "category" value = "사랑">사랑
		<input type = "radio" name = "category" value = "이별">이별
		<input type = "radio" name = "category" value = "노력">노력
		<input type = "radio" name = "category" value = "유머">유머
		<input type = "radio" name = "category" value = "감동">감동
		<input type = "radio" name = "category" value = "기타">기타
		<br><br>
		<select name = "phrasesearch">
			<option value="문구">문구</option><option value="키워드">키워드</option>
			<option value="설명">설명</option><option value="메모">메모</option>
		</select>
		<input type="text" name="phrasefind" placeholder="특수문자는 사용할수 없습니다.">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="submit">검색</button>
	<%
		}else if(selectedsearch.equals("출처")){
	%>
	<h4>출처 검색하기</h4> 
		<input type = "radio" name = "sourcegenre" value = "노래">노래
		<input type = "radio" name = "sourcegenre" value = "책">책	
		<input type = "radio" name = "sourcegenre" value = "영화">영화
		<input type = "radio" name = "sourcegenre" value = "인터넷">인터넷
		<input type = "radio" name = "sourcegenre" value = "속담">속담
		<input type = "radio" name = "sourcegenre" value = "인터뷰">인터뷰
		<br><br>
		<b>제목</b>&nbsp;
		<input type='text' name='sourcefind' placeholder="특수문자는 사용할수 없습니다.">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="submit">검색</button>
		<br>
		세부 검색:
		<input type = "radio" name = "searchdetail" value = "checkon" checked>O
		<input type = "radio" name = "searchdetail" value = "checkoff">X
	<%
		}else if(selectedsearch.equals("인물")){
	%>
	<h4>인물 검색하기</h4> 
		<select name = "personsearch">
			<option value="이름">이름</option><option value="국적">국적</option>
			<option value="직업">직업</option><option value="출생년도">출생년도</option>
		</select>
		<input type='text' name='personfind' placeholder="특수문자는 사용할수 없습니다.">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="submit">검색</button>
	<%
						}
	%>
</div>
</form>
</body>
</html>