<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="mMgr" class="member.PMemberMgr"/>    
<%
	request.setCharacterEncoding("UTF-8");
	String email=request.getParameter("email");
	String name=request.getParameter("name");
	String id=mMgr.findinfo(email, name);
	String msg="아이디는 "+id+"입니다.";
	if(id==""){
		msg="입력한 정보와 일치하는 아이디가 없습니다"+id;
	}
	
%>
<html>
<head>
    <link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<%=msg %>
	<button class="button" onclick="history.back();">뒤로가기</button>
	<button class="button" onclick="window.close();">닫기</button>
	
</body>
</html>