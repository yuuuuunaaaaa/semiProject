<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.product.*,admin.order.*,java.text.*,view.*" %>
<!DOCTYPE html>
<html>
<head>

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
	
	OrderBean oBean=new OrderMgr().getOrder(ordernum);
	ArrayList<OrderBean> odalist=new OrderMgr().getOrderDetails(ordernum);
	DecimalFormat df=new DecimalFormat("###,###");
	int proc=oBean.getProccess();
	String procStr="";
	switch(proc){
	case 1:procStr="주문 완료"; break;
	case 2:procStr="배송 준비 중"; break;
	case 3:procStr="발송 완료"; break;
	case 4:procStr="배송 중"; break;
	case 5:procStr="배송 완료"; break;
	}
	
	String postnum=oBean.getPostnum();
	String poinInfo="포인트<br>적립 완료";
	if(postnum==null){
		postnum="-";
	}
	String enddate=oBean.getFinaldate();
	if(enddate==null){
		enddate="-";
		poinInfo="적립 예정<br>포인트";
	}
	
%>
<meta charset="UTF-8">
<title>주문 상세조회</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="../resource/css/order.css?v=<%=System.currentTimeMillis() %>">
<link rel="stylesheet" href="../resource/css/Mypage.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>
<div class="outbody">
	<div class="infosidemenu">
		<div><a class="button" href="PersonalOrder.jsp">주문조회</a></div>
		<div><a class="button" href="QnA.jsp" >1:1문의</a></div>
		<div><a href="InfoUpdate.jsp" class="button">정보수정</a></div>
		<div><a href="deleteInfo.jsp" class="button">회원탈퇴</a></div>
	</div>
	<div class="infobody">
			<table class="pOrderT">
				<tr>
					<td width="100px">주문 번호</td>
					<td width="120px" >주문 날짜</td>
					<td width="100px">주문 상태</td>
					<td width="150px">운송장 번호</td>
					<td width="100px">주문 금액</td>
					<td width="120px">주문 완료 날짜</td>
					<td width="100px"><%=poinInfo %></td>
				</tr>
				<tr>
					<td>
						<%=oBean.getOrdernum() %>
					</td>
					<td><%=oBean.getIndate() %></td>
					<td><%=procStr %></td>
					<td><%=postnum %></td>
					<td><%=oBean.getFinalPrice() %></td>
					<td><%=enddate %></td>
					<td><%=oBean.getPoint() %></td>
				</tr>
			</table>
		<div class="bigOut">
<%

	int totalPrice=0;
	int totalSale=0;
	int totalPoint=0;
	for(int i=0; i<odalist.size();i++){
		OrderBean odBean=odalist.get(i);
		
		int pronum=odBean.getPronum();
		ProductBean pBean=new ProductMgr().getProduct(pronum);
		String proname=pBean.getProname();
		String thumb=pBean.getThumb();
		
		int price=pBean.getPrice();
		int sale=pBean.getSale();//
		int point=(int)(sale*0.01);
		
		int qtt=odBean.getQuantity();
		totalPrice+=price*qtt;
		totalSale+=sale*qtt;
		totalPoint+=point*qtt;
		String saleByProduct=df.format(qtt*sale);
		
		String dfSale=df.format(sale);
		String dfPrice=df.format(price);
		String dfdiscount=df.format(price-sale);
		
	%>
	    <div class="border">
	        <div>
	            <img alt="" src="../resource/fileupload/<%=thumb %>" class="thumbInTd">
	        </div>
	        <div class="orders">
	            <div class="nameNbin">
	            	<div>상품명: <%=proname %></div>
	            	<div class="goReview" onclick="goReview(<%=ordernum %>,<%=pronum %>);">리뷰 쓰기</div>
	            </div>
	            <div class="detail">
	                <div>개당 결제 금액<br><%=dfSale %>원</div>
	                <div class="space"></div>
	                <div>구매 수량<br><%=qtt %>개</div>
	            </div>
	            <div class="price">총 가격: <%=saleByProduct %></div>
	        </div>
	    </div>
        
	<%
	}
	String dfTotalSale=df.format(totalSale); 
	String dfTotalPrice=df.format(totalPrice); 
%>
		<div class="totalprice">총 가격: <%=dfTotalSale %></div>
<div class="goBack"><input type="button" class="button" value="뒤로가기" onclick="history.back();"></div>
</div>
</div>
</div>


<%@include file="../Footer.jsp" %>
<script>
	function goReview(ordernum,pronum){
		location.href="ReviewPostOrView.jsp?ordernum="+ordernum+"&pronum="+pronum;
/* 		$.ajax({
			url : "../ReviewPostOrView",
			type : "get",
			data : {ordernum : ordernum, pronum : pronum, id : id},
			success : function(result){
				if(result){
					//리뷰 쓰러 고
					console.log("리뷰 쓰러 가자");
				}else{
					//쓴 리뷰 보러 고
					console.log("리뷰 쓴거 함 보자");
				}
				
			},
			error:function(){
				console.log("ajax통신 실패");
			}
		}) */
	}
</script>
</body>
<style>
	.outbody{
        margin-top: 29px;
		display:flex;
		justify-content: center;
		flex-direction: row;
	}
	.pOrderT{
		margin:0 auto;
		border-collapse:collapse;
		margin: 40px auto;
	}
	.bigOut{
		width:650px;
		margin:10px auto;
	}
	.goBack{
		text-align:center;
	}
	.pOrderT td{
		border: solid 1px;
		padding:5px;
	}
	.pOrderT *{
		text-align:center;
	}
	.infosidemenu *{text-align:center}
	.nameNbin{
		display:flex;
		flex-direction: row;
		justify-content: space-between;
       font-size: 17px;
       font-weight: bold;
    }
    .goReview{
    	font-size:14px;
    	font-weight:300;
    	text-decoration:underline;
    }
    .goReview:hover{
    	cursor:pointer;
    }
</style>
</html>