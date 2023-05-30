<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="mMgr" class="member.PMemberMgr"/>    
<%
request.setCharacterEncoding("UTF-8");

String phone=(String)session.getAttribute("phoneKey");
String id=(String)session.getAttribute("idKey");
String pwd=request.getParameter("pwd");
boolean result=mMgr.pwdUpdate(pwd, id, phone);
String msg="비밀번호 변경에 실패했습니다!";
String url="'findinfo.jsp'";
if(result){
	msg="비밀번호가 변경되었습니다.";
	url="'login.jsp'";
}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href=<%=url %>;
</script>
</body>
</html>