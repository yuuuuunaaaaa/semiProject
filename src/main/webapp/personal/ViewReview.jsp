<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.product.*,admin.order.*,personal.*,view.*" %>    
<!DOCTYPE html>
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
	int reviewnum=Integer.parseInt(request.getParameter("reviewnum"));
	
	ReviewBean rBean=new PersonalMgr().getReview(reviewnum);
	
	int ordernum=rBean.getOrdernum();
	int pronum=rBean.getPronum();
	String proname=new ProductMgr().getProduct(pronum).getProname();
	String img=rBean.getImg();
	if(img==null){
		img="<br>";
	}else{
		img="<img src='../resource/fileupload/"+rBean.getImg()+"' class='revImg'><br>";
	}
%>
<head>
<meta charset="UTF-8">
<title>리뷰 작성하기</title>
	<link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
	<link rel="stylesheet" href="../resource/css/Mypage.css?v=<%=System.currentTimeMillis()%>">
	<link rel="stylesheet" href="../resource/css/Review.css?v=<%=System.currentTimeMillis()%>">
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
        <div class="revfobody">
        <form action="../PostReview.post" name="postReviewFrm" method="post" enctype="multipart/form-data">
        	<table class="rev">
        		<tr class="toptr">
        			<td>주문번호: <input value="<%=ordernum %>" name="ordernum" readonly></td>
        			<td>상품명: <input value="<%=proname %>" name="proname" id="proname" readonly></td>
        			<td>
        				아이디: <input value="<%=id %>" name="id" readonly>
       				</td>
        		</tr>
        		<tr>
        			<td colspan="2">제목: <%=rBean.getTitle() %></td>
        			<td class="starRate">
        				<span class="star">
        					★★★★★
							<span>★★★★★</span>
						</span>
					</td>
        		</tr>
        		<tr>
        			<td colspan="3" class="botborder">
        				<%=img %>
        				<%=rBean.getContent() %>
        			</td>
        		</tr>
        		<tr>
        			<td colspan="3" class="topborder"></td>
        		</tr>
        	</table>
        </form>
        </div>
	</div>
<style>
	.revImg{
	width:400px;
	}
</style>
<script>
let drawStar = (target) => {
	let wid=<%=rBean.getRate() %> * 20+"%";
    document.querySelector(".star span").style.width = wid;
  }
</script>
</body>
</html>