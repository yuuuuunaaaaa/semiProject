<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.product.*,admin.order.*,java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
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
	int cartnum=new PMemberMgr().getMember(id).getCartnum();
%>
<meta charset="UTF-8">
<title><%=name %>님의 장바구니</title>
<link rel="stylesheet" href="../resource/css/order.css?v=<%=System.currentTimeMillis() %>">
</head>
<body>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>
	<form class="cartFrm" action="../saleView/Orders.jsp">
<div id="whenEmpty">

<%
	ArrayList<CartBean> alist=new OrderMgr().getCartList(new PMemberMgr().getMember(id).getCartnum());
	DecimalFormat df=new DecimalFormat("###,###");
	int totalPrice=0;
	int totalSale=0;
	int totalPoint=0;
	
	for(int i=0; i<alist.size();i++){
		CartBean cBean=alist.get(i);
		
		int pronum=cBean.getPronum();
		ProductBean pBean=new ProductMgr().getProduct(pronum);
		String proname=pBean.getProname();
		String thumb=pBean.getThumb();
		
		int price=pBean.getPrice();
		int sale=pBean.getSale();//
		int point=(int)(sale*0.01);
		
		int qtt=cBean.getQuantity();
		totalPrice+=price*qtt;
		totalSale+=sale*qtt;
		totalPoint+=point*qtt;
		String saleByProduct=df.format(qtt*sale);
		
		String dfSale=df.format(sale);
		String dfPrice=df.format(price);
		String dfdiscount=df.format(price-sale);
		
	%>
	    <div class="border" id="bo<%=pronum %>">
	        <div>
	            <img alt="" src="../resource/fileupload/<%=thumb %>" class="thumbInTd">
	        </div>
	        <div class="orders">
	            <div class="nameNbin">
	            	<div>상품명: <%=proname %></div>
	            	<img alt="휴지통" src="../resource/img/bin.png" class="bin" onclick="deleteCart(<%=pronum %>);">
	            </div>
	            <div class="detail">
	            <% if(sale<price){	%>
	                <div>가격<br><%=dfPrice %>원</div>
	                <div class="space"></div>
	                <div>개당<br> <%=dfdiscount %>원 할인</div>
	                <div class="space"></div>
	                <div>할인 후 가격<br><%=dfSale %>원</div>
	                <div class="space"></div>
	                <div>구매 수량<br><%=qtt %>개</div>
	                
	      		<% }else{ %>
	                <div>가격<br><%=dfPrice %>원</div>
	                <div class="space"></div>
	                <div>구매 수량<br><%=qtt %>개</div>
			<% }  %>
	            </div>
	            <div class="price">총 가격: <%=saleByProduct %></div>
	        </div>
        <input type="hidden" name="proname" value="<%=proname%>">
        <input type="hidden" name="thumb" value="<%=thumb%>">
        <input type="hidden" name="price" value="<%=price%>">
        <input type="hidden" name="point" value="<%=point%>">
        <input type="hidden" name="quantity" value="<%=qtt%>">
        <input type="hidden" name="sale" value="<%=sale%>">
        <input type="hidden" name="pronum" value="<%=pronum%>">
        <input type="hidden" name="cartnum" value="<%=cartnum %>">
	    </div>
        
        
	<%
	}
%>
<% 	
	String dfTotalSale=df.format(totalSale); 
	String dfTotalPrice=df.format(totalPrice); 
%>
		<div class="totalprice" id="fintp">총 가격: <%=dfTotalSale %></div>
		<input type="hidden" name="totalPrice" id="finp" value="<%=totalSale %>"> 
		<input type="hidden" name="totalPoint" id="totalPoint" value="<%=totalPoint %>"> 
<div class="goOrder"><input type="submit" class="button" value="주문하기"></div>
</div>
</form>

<%@include file="../Footer.jsp" %>
<script>
	function deleteCart(pronum){
		let cartnum=<%=cartnum %>;
		let finPrice=$("#finp").val();
		$.ajax({
			url:"../deleteFromCart",
			data:{pronum : pronum, cartnum : cartnum, totalprice:finPrice},
			type:"post",
			success:function(result){
				if(result>0){
					let divId="#bo"+pronum;
					$(divId).text("");
					$("#finp").attr("value",result);
					dfTPrice=$("#finp").attr("value").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
					$("#fintp").text("총 가격: "+dfTPrice)
					$("#totalPoint").attr("value",result*0.01);
				}else if(result==0){
					$("#whenEmpty").html("<img src='../resource/img/cart.png' class='bincart'><br>  카트가 비었습니다.");
				}else{
					alert("장바구니에서 해당 상품 삭제하는 것을 실패했습니다.");
				}
			},
			error:function(){
				console.log("ajax통신 실패")
			}
		})
	}
	$(function(){
	<%
		if(alist.size()==0){
		%>
	$("#whenEmpty").html("<img src='../resource/img/cart.png' class='bincart'><br>  카트가 비었습니다.")		
		<%
		}
	%>
	})
</script>
</body>
<style>
	.cartFrm{
		width:650px;
		margin:0 auto;
	}
	.goOrder{
		text-align:center;
	}
	.nameNbin{
		display:flex;
		flex-direction: row;
		justify-content: space-between;
       font-size: 17px;
       font-weight: bold;
    }
    .bin{
    	margin-top:-10px;
    	width:15px;
    	height:20px;
    	opacity:0.4;
    }
    .bin:hover{
    	cursor:pointer;
    }
    #whenEmpty{
    	margin: 100px auto;
    	text-align:center;
    }
    .bincart{
    	width:100px;
    	opacity:0.6;
    }
</style>
</html>