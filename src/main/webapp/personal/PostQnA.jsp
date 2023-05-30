<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,member.*,admin.order.*,view.*" %>
<html>
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){id="";}
	if(name==null){name="";}
	PMemberBean mBean=new PMemberMgr().getMember(id);
	int totalRecord=0;		//전체 레코드 수
	int numPerPage=10; 		//1페이지당 레코드 수
	int pagePerBlock=5;		//블록당 보여줄 페이지 수 [1][2][3][4][5]...
	
	int totalPage=0;		//전체 페이지 수 ex)글이 55개면 페이지는 [6]까지
	int totalBlock=0;		//전체 블록 수 ex)글이 55개면 페이지는 6개, 블록은 두 개

	int nowPage=1;			//현재 해당하는 페이지
	int nowBlock=1;			//현재 해당하는 블록

	int start=0;			//DB테이블의 select시작번호
	int end=0;				//가져온 레코드중에서 10개씩만 가져오기(마지막 페이지 말고는 다 10)
	int listSize=0;			//현재 읽어온 게시물의 수
	String keyWord="", keyField="";
	if(request.getParameter("keyWord") !=null){
		keyWord=request.getParameter("keyWord");
		keyField=request.getParameter("keyField");
	}
	
	/*[처음으로]를 누를 때*/
	if(request.getParameter("reload") !=null){ //사용자가 실수할까봐?? 몬소리람
		if(request.getParameter("reload").equals("true")){
			keyWord="";
			keyField="";
		}
	}
	
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage")); //파라미터로 오는건 다 String
	}
	
	start=((nowPage*numPerPage)-numPerPage)+1;
	
	end=nowPage*numPerPage;
	
	//totalRecord=bMgr.getTotalCount(keyField, keyWord);
	totalPage=(int)Math.ceil((double)totalRecord/numPerPage);		//전체 페이지수
	nowBlock=(int)Math.ceil((double)nowPage/pagePerBlock);			//현재블럭 계산
	totalBlock=(int)Math.ceil((double)totalPage/pagePerBlock);		//전체블럭 계산
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
        <form action="QnAUpload.jsp" method="post" class="qnaobody">
        	<table class="qnaT">
        		<tr>
        			<td width="100px" height="35px">제목</td>
        			<td><input name="title" class="qnatitle" required></td>
        			<td>문의분류</td>
        			<td>
        				<select name="category">
        					<option value="1">상품 관련</option>
        					<option value="2">배송 관련</option>
        					<option value="3">회원 정보 관련</option>
        				</select>
        			</td>
        		</tr>
        		<tr class="contBody">
        			<td colspan="4"><pre><textarea name="content" ></textarea></pre></td>
        		</tr>
        	</table>
        	<input type="submit" value="작성하기" class="button post">
        	</form>
	</div>

<%@include file="../Footer.jsp" %>
<a href="#top" class="totop"><img alt="" src="../resource/img/totop.png"> </a>
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
	.qnaT textarea{
		width:600px;
		height:250px;
		resize:none;
		border:none;
		text-align:left;
		padding:10px;
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