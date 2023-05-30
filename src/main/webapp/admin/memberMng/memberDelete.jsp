<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,admin.member.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>멤버 삭제</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id[]=request.getParameterValues("chk"); //id 배열
	AdminMemberMgr aMgr=new AdminMemberMgr();
	boolean result=aMgr.memberDel(id);
	
	if(result){
	%>
		<script>
		alert("상품 삭제가 완료되었습니다.");
		location.href="memberMng.jsp";
		</script>
	<%
	}else{
	%>
		<script>
		alert("상품 삭제에 실패했습니다.");
		location.href="memberMng.jsp";
		</script>
	<%
	}
%>

</body>
</html>