<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,member.*,admin.order.*,view.*,boards.*" %>
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
	int qnanum=Integer.parseInt(request.getParameter("qnanum"));
	int ref=new BoardMgr().getQna(qnanum).getRef();
	ArrayList<QnaBean> alist=new BoardMgr().getQnaDblChk(ref);
	if(alist.size()>1){
		%>
		<script>
			alert("이미 답변이 등록된 문의입니다.");
			location.href='AdminQnA.jsp';
		</script>
		<%
		
	}
	
	
	QnaBean qBean=new BoardMgr().getQna(qnanum);
	String qid=qBean.getId();
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
</head>

<body>
<jsp:include page="../../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../../" name="path"/>
</jsp:include>
    <div class="bigbody">
        <form action="QnAUAnswerpload.jsp" method="post" class="qnaobody">
        	<table class="qnaT">
        		<tr>
        			
        			<td width="100px" height="35px">제목</td>
        			<td><input name="title" class="qnatitle" required value="답변: <%=qBean.getTitle() %>"></td>
        			<td>문의분류</td>
        			<td><%=cate %></td>
        		</tr>
        		<tr class="contBody">
        			<td colspan="4"><pre><textarea name="content" >
<%=qBean.getContent() %>
------------------------------------------------------
</textarea></pre></td>
        		</tr>
        	</table>
        	<input type="submit" value="작성하기">
        	<input type="button" value="뒤로가기" onclick="history.back()">
        	
        	<input type="hidden" name="qnanum" value="<%=qnanum %>">
        	<input type="hidden" name="category" value="<%=category %>">
        	</form>
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
	.qnaT textarea{
		width:600px;
		height:250px;
		resize:none;
		border:none;
		text-align:left;
		padding:10px;
	}
		.totop>img{
		width:40px;
		position:fixed;
		right:30px;
		bottom:30px;
	}
	.qnatitle{
		width:200px;
		text-align:left;
	}
	.contBody *{
		text-align:left;
	}
</style>
</body>
</html>