<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.product.*,admin.order.*,java.text.*,view.*" %>    
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
	
	int ordernum=Integer.parseInt(request.getParameter("ordernum"));
	int pronum=Integer.parseInt(request.getParameter("pronum"));
	String proname=new ProductMgr().getProduct(pronum).getProname();
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
            <div><a class="button">1:1문의</a></div>
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
        				<input type="hidden" value="<%=pronum %>" name="pronum">
       				</td>
        		</tr>
        		<tr>
        			<td colspan="2">제목: <input type="text" name="title" class="title"></td>
        			<td class="starRate">
        				<span class="star">
						<input type="range" oninput="drawStar(this)" value="100" step="1" min="1" max="1000">
        					★★★★★
							<span>★★★★★</span>
						</span>
						<input type="hidden" name="rate" id="rate" value="5">
					</td>
        		</tr>
        		<tr>
        			<td colspan="3" class="botborder"><pre><textarea name="content"></textarea></pre></td>
        		</tr>
        		<tr>
        			<td colspan="3" class="topborder"><input type="file" accept="image/jpeg, image/png, image/jpg" name="img"></td>
        		</tr>
        	</table>
        <div class="goBack"><input type="submit" class="button" value="리뷰 등록"></div>
        </form>
        </div>
	</div>
<script>
let drawStar = (target) => {
	let val=Math.ceil(target.value/200);
	let wid=val * 20+"%";
    document.querySelector(".star span").style.width = wid;
    $("#rate").attr("value",val);
  }
</script>
</body>
</html>