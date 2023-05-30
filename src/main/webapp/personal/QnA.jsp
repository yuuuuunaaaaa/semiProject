<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,member.*,admin.order.*,view.*,boards.*" %>
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
	
	
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage")); //파라미터로 오는건 다 String
	}
	
	start=((nowPage*numPerPage)-numPerPage)+1;
	
	end=nowPage*numPerPage;
	
	totalRecord=new BoardMgr().getQnaById(id,start,end).size();
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
        <div class="maininfobody">
        	<table class="qnatable">
        		<tr>
        			<td>no</td>
        			<td>제목</td>
        			<td>문의분류</td>
        			<td>작성일</td>
        		</tr>
        		<tbody>
      		<%
      			System.out.println(id);
      			ArrayList<QnaBean> alist=new BoardMgr().getQnaById(id,start,end);
      			for(int i=0;i<alist.size();i++){
      				QnaBean qBean=alist.get(i);
      				int category=qBean.getCategory();
      				String cate="";
      				switch(category){
      				case 1: cate="상품관련"; break;
      				case 2: cate="배송관련"; break;
      				case 3: cate="회원 정보 관련"; break;
      				}
      				int dep=qBean.getDepth();
      				String jump="";
      				if(dep==1){
      					jump="&emsp;&emsp;ㄴ";
      				}
      				%>
  				<tr onclick="read('<%=qBean.getQnanum() %>')" >
  					<td><%=totalRecord - (nowPage-1)*numPerPage-i %></td>
  					<td class="qnatitle"><%=jump %><%=qBean.getTitle() %></td>
  					<td><%=cate %></td>
  					<td><%=qBean.getRegdate() %></td>
  				</tr>
      				<%
      			}
      		%>
      		</tbody>
      		  <tr>
                <td colspan="4" class="pageparttd">
                    <!-- 페이징처리 시작 -->
                    <div class="pagenum">
                    <%
                    
                    int pageStart=(nowBlock-1)*pagePerBlock+1;
                    int pageEnd=pageStart+pagePerBlock <= totalPage ? pageStart+pagePerBlock : totalPage+1;
                    if(totalPage !=0){
                    	if(nowBlock > 1){
               		%>
                    		<div><a href="javascript:block('<%=nowBlock-1%>')">◀</a></div>
               		<%
                    	}else{
               		%>
                    		<div style="color:white">◀</div>
               		<%
                    	}
	                    for(;pageStart<pageEnd;pageStart++){
	                    	if(nowPage==pageStart){
                   	%>
	                        <div class="page"><a class="nowpage" href="javascript:pageing('<%=pageStart%>')"><%=pageStart %></a></div>
                   	<%
	                    	}else{
                   	%>
	                        <div class="page"><a href="javascript:pageing('<%=pageStart%>')"><%=pageStart %></a></div>
                   	<%
	                    	}
	                    } 
	                    if(totalBlock>nowBlock){
                   	%>
	                    	<div><a href="javascript:block('<%=nowBlock+1%>')">▶</a></div>
                   	<%
	                    }else{
               		%>
                    		<div style="color:white">▶</div>
               		<%
                    	}
                    }
                    %>
                    </div>
                    <!-- 페이징처리 끝 -->
                    
                </td>
                </tr>
                <tr>
                <td colspan="4" class="pageparttd">
                	<div class="pagebtn">
			            <input type="button" value="작성하기" class="button post" onclick="location.href='PostQnA.jsp'">
			            <input type="button" value="처음으로" class="button" onclick="location.href='javascript:list()'"> <!-- list.jsp -->
			        </div>
                </td>
            </tr>
        	</table>
       	<form name="listQnaFrm" method="post">
	       	<input type="hidden" name="reload" value="true">
	       	<input type="hidden" name="nowPage" value="1">
        </form>
         <form name="readQnaFrm" method="get">
        	<input type="hidden" name="qnanum">
        	<input type="hidden" name="nowPage" value="<%=nowPage%>">
        </form>
        </div>
	</div>
<script>
	function read(qnanum){
		readQnaFrm.qnanum.value=qnanum;
		readQnaFrm.action="QnARead.jsp?qnanum="+qnanum;
		readQnaFrm.submit();
	}
	function list(){
		listQnaFrm.action="list.jsp";
		listQnaFrm.submit();
	}
	function block(value){
		readQnaFrm.nowPage.value=<%=pagePerBlock %>*(value-1)+1;
		readQnaFrm.submit();
	}
	function pageing(page){
		readQnaFrm.nowPage.value=page;
		readQnaFrm.submit();
	}
</script>
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
	.qnatable{
		border-collapse:collapse
	}
	.qnatable td{
		border:solid 1px;
		padding:5px;
	}
		.totop>img{
		width:40px;
		position:fixed;
		right:30px;
		bottom:30px;
	}
.qnatable .pageparttd{border: none;padding-top:10px}
.qnatable .pagenum{margin:0 2px;display: flex;justify-content: space-between;justify-content: flex-end;justify-content: space-around;align-items: center}
.qnatable .page *{color:#c0c0c0; font-size:13px}
.qnatable .nowpage{color:rgb(67, 67, 67); font-weight:500;}
.qnatitle{
	text-align:left;	
}
</style>
</body>
</html>