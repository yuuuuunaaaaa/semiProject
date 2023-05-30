<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){id="";}
	if(name==null){name="";}
%>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
   	<link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
   	<link rel="stylesheet" href="../resource/css/header.css?v=<%=System.currentTimeMillis()%>">
    <link rel="shortcut icon" href="../resource/img/puppy.png">
</head>
<body>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>
공지사항.............


<%@include file="../Footer.jsp" %>
<a href="#top" class="totop"><img alt="" src="../resource/img/totop.png"> </a>
<style>
	.totop>img{
		width:40px;
		position:fixed;
		right:30px;
		bottom:30px;
	}
</style>
</body>
</html>