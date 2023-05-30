<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,member.*,view.*,boards.*" %>
<html>
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){
		%>
		<script>
			alert("로그인한 회원만 사용할 수 있는 기능입니다.");
			location.href="../main.jsp";
		</script>
		<%
	}
	if(name==null){name="";}
	PMemberBean mBean=new PMemberMgr().getMember(id);
	int qnanum=Integer.parseInt(request.getParameter("qnanum"));
	
	QnaBean qBean=new BoardMgr().getQna(qnanum);
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
	<link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
	<link rel="stylesheet" href="../resource/css/Mypage.css?v=<%=System.currentTimeMillis()%>">
</head>

<body>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>
    <div class="bigbody">
        <div class="infosidemenu">
            <div><a class="button" href="PersonalOrder.jsp" >주문조회</a></div>
            <div><a class="button" href="QnA.jsp" >1:1문의</a></div>
            <div><a href="InfoUpdate.jsp" class="button">정보수정</a></div>
            <div><a href="deleteInfo.jsp" class="button">회원탈퇴</a></div>
        </div>
        	<table class="qnaT">
        		<tr>
        			<td width="100px" height="35px">제목</td>
        			<td class="qnatitle"><%=qBean.getTitle() %></td>
        			<td width="100px">문의분류</td>
        			<td width="100px"><%=cate %></td>
        		</tr>
        		<tr class="contBody">
        			<td colspan="4" class="content"><pre><%=qBean.getContent() %></pre></td>
        		</tr>
        	</table>
        	<input type="button" value="뒤로가기" class="button post" onclick="history.back();">
	</div>

<%@include file="../Footer.jsp" %><a href="#top" class="totop"><img alt="" src="../resource/img/totop.png"> </a>
<style>
	.totop>img{
		width:40px;
		position:fixed;
		right:30px;
		bottom:30px;
	}
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
	.qnaT .qnatitle{
		width: 300px;
		text-align:left;
		padding-left:5px;
	}
</style>
</body>
</html>