<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,admin.member.*,admin.product.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id[]=request.getParameterValues("chk");
	
	boolean result=new AdminMemberMgr().ynUpdateMember(id);
	if(result){
	%>
		<script>
		alert("변경이 완료되었습니다.");
		location.href="memberMng.jsp";
		</script>
	<%
	}else{
	%>
		<script>
		alert("변경에 실패했습니다.");
		location.href="memberMng.jsp";
		</script>
	<%
	}
%>

</body>
</html>