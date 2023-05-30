<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.order.*,view.*,boards.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id=(String)session.getAttribute("idKey");
	QnaBean qBean=new QnaBean(); 	
	qBean.setTitle(request.getParameter("title"));
	qBean.setContent(request.getParameter("content"));
	qBean.setCategory(Integer.parseInt(request.getParameter("category")));
	qBean.setId(id);
	
	boolean result=new BoardMgr().insertQnA(qBean);
	if(result){
		%>
		<script>
			location.href="QnA.jsp";
		</script>
		<%
	}
	
%>
</body>
</html>