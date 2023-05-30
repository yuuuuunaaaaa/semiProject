<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,member.*,view.*,boards.*" %>
<html>
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(!id.equals("admin")){
		%>
		<script>
			alert("관리자만 접근 가능한 페이지입니다.");
			location.href='../../main.jsp';
		</script>
		<%
	
	}
	if(name==null){name="";}
	PMemberBean mBean=new PMemberMgr().getMember(id);
	int qnanum=Integer.parseInt(request.getParameter("qnanum"));
	
	QnaBean qBean=new BoardMgr().getQna(qnanum);
	int dep=qBean.getDepth();
	int category=qBean.getCategory();
	String cate="";
	switch(category){
	case 1: cate="상품관련"; break;
	case 2: cate="배송관련"; break;
	case 3: cate="회원 정보 관련"; break;
	}
%>
<head>
<meta charset="UTF-8">
<title>1:1 문의</title>
	<link rel="stylesheet" href="../../resource/css/Mypage.css?v=<%=System.currentTimeMillis()%>">
	   	<link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
</head>

<body>
<jsp:include page="../../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../../" name="path"/>
</jsp:include>
    <div class="bigbody">
        	<table class="qnaT">
        		<tr>
        			<td width="100px" height="35px">제목</td>
        			<td width="200px" ><%=qBean.getTitle() %></td>
        			<td width="100px">작성자</td>
        			<td width="100px"><%=qBean.getId() %></td>
        			<td width="100px">문의분류</td>
        			<td width="100px"><%=cate %></td>
        		</tr>
        		<tr class="contBody">
        			<td colspan="6" class="content"><pre><%=qBean.getContent() %></pre></td>
        		</tr>
        	</table>
        	<%
        	if(dep==1){
        		%>
        	<div class="postbtn">
	        	<input type="button" value="뒤로가기" onclick="history.back();">
        	</div>
        		<%
        	}else{
        		%>
        	<div class="postbtn">
	        	<input type="button" value="뒤로가기" onclick="history.back();">
	        	<input type="button" value="답변 쓰기" onclick="location.href='AnswerQnA.jsp?qnanum=<%=qnanum %>'">
        	</div>
        		<%
        	}
        	%>
	</div>

<%@include file="../../Footer.jsp" %>
<a href="#top" class="totop"><img alt="" src="../resource/img/totop.png"> </a>
<style>
	.post{
		margin:5px auto;
	}
	.qnaT{
		border-collapse:collapse;
	}
	.qnaT td{
		border:solid 1px;
	}
	.content{
		text-align:left;
		padding:15px;
	}
	.qnatitle{
		width:200px;
		text-align:left;
	}
	.contBody *{
		text-align:left;
	}
	.bigbody{
		flex-direction: column;
		align-items: center;
	}
	.postbtn{
		display:flex;
	}
	.postbtn *{
		margin:10px;
	}
		.totop>img{
		width:40px;
		position:fixed;
		right:30px;
		bottom:30px;
	}
</style>
</body>
</html>