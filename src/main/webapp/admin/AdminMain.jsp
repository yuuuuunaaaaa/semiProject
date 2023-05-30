<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자페이지</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <link rel="shortcut icon" href="../resource/img/puppy.png">
    <style>
    	.MngBtn{
    		padding-top:50px;
    		display:flex;
    		flex-direction: column;
    		align-items: center
    	}
    	.MngBtn input{
    		padding:10px;
    		margin:10px;
    		width: 400px;
    		height:50px;
    	}
    	.MngBtn input:hover{
    		cursor:pointer;
    	}
    </style>
</head>
<body>
<%	
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){id="";}
	if(name==null){name="";}
%>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>
	<div class="MngBtn">
		<input type="button" value="주문관리" onclick="location.href='purchaseMng/PurchaseMng.jsp'">
		<input type="button" value="상품관리" onclick="location.href='product/productMng.jsp'">
		<input type="button" value="회원관리" onclick="location.href='memberMng/memberMng.jsp'">
		<input type="button" value="문의관리" onclick="location.href='boardEtc/AdminQnA.jsp'">
	</div>
<%@include file="../Footer.jsp" %>	
</body>
</html>

