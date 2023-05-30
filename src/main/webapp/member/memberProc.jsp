<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mgr" class="member.PMemberMgr"/>
<jsp:useBean id="bean" class="member.PMemberBean"/> <!-- bean에 직접 값 넣어줘야돼서 연결 -->
<jsp:setProperty property="*" name="bean"/>
<%
	boolean result = mgr.insertMember(bean); //잘 들어갔으면 true
	String msg = "회원가입에 실패하였습니다";
	String location = "member.jsp";
	if(result){
		msg="회원가입이 완료되었습니다.\n회원가입 이벤트 2000포인트 당첨!";
		location="../main.jsp";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert("<%=msg%>");
	location.href="<%=location%>";
</script>
</head>
<body>
	입력처리
</body>
</html>