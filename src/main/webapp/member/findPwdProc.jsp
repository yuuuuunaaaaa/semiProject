<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="mMgr" class="member.PMemberMgr"/>    
<%
	request.setCharacterEncoding("UTF-8");
	String phone=request.getParameter("phone");
	String id=request.getParameter("id");
	
	session.setAttribute("idKey", id);
	session.setAttribute("phoneKey", phone);
	
	boolean result=mMgr.pwdFind(phone, id);
	String msg="입력한 정보와 일치하는 계정이 없습니다.";
	String url="findinfo.jsp";
	if(result){
		msg="";
		url="updatePwdProc.jsp";
	}
	
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
<%
		if(msg.equals("")){
%>
		location.href="<%=url%>";
<%
		}else{
%>
			alert("<%=msg%>");
			location.href="<%=url%>";
<%
		}
%>
	</script>
</body>
</html>