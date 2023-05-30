<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,admin.product.*,view.*,java.text.*,member.*" %>
<!DOCTYPE html>
<html>
<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="../resource/css/order.css?v=<%=System.currentTimeMillis() %>">
<script>
	function findAddr(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	let roadAddr=data.roadAddress;
                let extraAddr='';

                document.getElementById("zipcode").value=data.zonecode;
                
                if(roadAddr != ''){
                    if(data.bname != ''){
                        extraAddr += data.bname;
                	}
                	if(data.buildingName != ''){
                        extraAddr += extraAddr != ''? ', '+data.buildingName : data.buildingName; 
                	}
                	roadAddr += extraAddr != '' ? '('+extraAddr+')' : ''; 
                    document.getElementById("address").value=roadAddr;
                }
	        }
	    }).open();
	};
</script>
<meta charset="UTF-8">
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){
	%>
		<script>
		alert("로그인한 회원만 사용할 수 있는 기능입니다.");
		history.back();
		</script>
	<%
	}
	if(name==null){name="";}
	
	
	PMemberBean mBean=new PMemberMgr().getMember(id);
	
	ArrayList<ProductBean> productAlist=new ArrayList<>();
	ArrayList<OrderBean> orderAlist=new ArrayList<>();
	
	String pronameArr[]=request.getParameterValues("proname");
	
	String thumbArr[]=request.getParameterValues("thumb");
	
	String priceTmp[]=request.getParameterValues("price");
	String pointTmp[]=request.getParameterValues("point");
	String qttTmp[]=request.getParameterValues("quantity");
	String saleTmp[]=request.getParameterValues("sale");
	String pronumTem[]=request.getParameterValues("pronum");
	String cartnumTem=request.getParameter("cartnum");
	int cartnum=0;
	if(cartnumTem!=null){
		cartnum=Integer.parseInt(request.getParameter("cartnum"));
	}
	
	
	int priceArr[]=new int[priceTmp.length];
	int pointArr[]=new int[pointTmp.length];
	int qttArr[]=new int[qttTmp.length];
	int saleArr[]=new int[saleTmp.length];
	int pronumArr[]=new int[pronumTem.length];
	
	for(int i=0;i<priceArr.length;i++){
		priceArr[i]=Integer.parseInt(priceTmp[i]);
		pointArr[i]=Integer.parseInt(pointTmp[i]);
		qttArr[i]=Integer.parseInt(qttTmp[i]);
		saleArr[i]=Integer.parseInt(saleTmp[i]);
		pronumArr[i]=Integer.parseInt(pronumTem[i]);
	}
	
	
	for(int i=0;i<pronameArr.length;i++){
		ProductBean pBean=new ProductBean();
		OrderBean oBean=new OrderBean();
		
		pBean.setPronum(pronumArr[i]);
		pBean.setProname(pronameArr[i]);
		pBean.setThumb(thumbArr[i]);
		pBean.setPrice(priceArr[i]);
		pBean.setSale(saleArr[i]);
		oBean.setPoint(pointArr[i]);
		oBean.setQuantity(qttArr[i]);
		productAlist.add(pBean);
		orderAlist.add(oBean);
	}
	DecimalFormat df=new DecimalFormat("###,###");
	
%>
<title>주문하기</title>
</head>
<body>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>
<div class="INBODY">
   	<div class="orderTitle">
   		주문하기
   	</div>
   	<form action="Purchase.jsp" method="get" name="orderconFrm">
<%
	int totalPrice=0;
	int totalSale=0;
	int totalPoint=0;

	for(int i=0; i<productAlist.size();i++){
		String proname=productAlist.get(i).getProname();//
		String thumb=productAlist.get(i).getThumb(); //
		int pronum=productAlist.get(i).getPronum();
		
		int price=productAlist.get(i).getPrice();//
		int sale=productAlist.get(i).getSale();//
		
		int point=orderAlist.get(i).getPoint();//
		int qtt=orderAlist.get(i).getQuantity();
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
	            <div class="proname">상품명: <%=proname %></div>
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
                <input type="hidden" name="sale" value="<%=sale%>">
                <input type="hidden" name="pronum" value="<%=pronum%>">
                <input type="hidden" name="quantity" value="<%=qtt%>">
	            <div class="price">총 가격: <%=saleByProduct %></div>
	        </div>
	    </div>
	<%
	}
%>
                <input type="hidden" name="cartnum" value="<%=cartnum%>">
				<input type="hidden" name="totalPrice" value="<%=totalSale %>" id=totalPrice> 
				<input type="hidden" name="totalPoint" value="<%=totalPoint %>" id="totalPoint"> 
<% 	
	String dfTotalSale=df.format(totalSale); 
	String dfFinalSale=df.format(totalSale+3000);
	String dfTotalPrice=df.format(totalPrice); 
	int point=mBean.getPoint();
	String dfPoint=df.format(point);
%>
		<div class="priceInfo">
			<div>결제 예정 금액<br><%=dfTotalSale %>원</div>
			<div>배송비<br>3,000원</div>
			<div>
				<div>사용 포인트<br><input name="usePoint" id="usePoint" value="0"></div>
				<div class="pointinfo"><%=dfPoint %>p 사용가능</div>
			</div>
		</div>
		<div class="totalprice">최종 결제 금액: <span id="finalPrice"><%=dfFinalSale %></span>원</div>
		<script>
			$(function(){
				$("#usePoint").focusout(function(){
					numchk=/^[0-9]+$/;
					if(numchk.test(this.value)){
						let price=<%=point %>-$("#usePoint").val()*1;
						if(price>=0){
							price=<%=totalSale %>+3000-$("#usePoint").val()*1;
							$("#totalPrice").attr("value",price);
							$("#totalPoint").attr("value",price*0.01);
							let dfPrice=$("#totalPrice").attr("value").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
							$("#finalPrice").text(dfPrice);
						}else{
							$("#usePoint").val('');
							alert("최대 사용 가능한 포인트는 <%=dfPoint %> 포인트 입니다.")
						}
					}else{
						$("#usePoint").val('');
						alert("포인트는 숫자만 입력해주세요");
					}
				})
			})
		</script>
		
		
		
		<hr class="orderHr">
		<div class="infoTitle">수령인 정보 입력</div>
		<div class="getInfo" id="getInfo">내 정보 불러오기</div>
		<table class="orderTable">
			<tr>
				<td width="100px" class="lef">이름</td>
				<td><input type="text" name="name" id="name" required></td>
			</tr>
			<tr>
				<td class="lef">연락처</td>
				<td><input type="text" name="phone" id="phone" required></td>
			</tr>
			<tr>
				<td class="lef">우편 번호</td>
				<td>
                    <input name="zipcode" id="zipcode" readonly>
                    <input class="button long" type="button" value="우편번호 찾기" onclick="findAddr();" required>
                </td>
			</tr>
			<tr>
				<td class="lef">주소</td>
				<td>
					<input name="address" id="address" size="40" readonly required><br>
					<input name="addrdetail" id="detailAddr" placeholder="상세주소" required>
				</td>
			</tr>
		</table>
		<div class="subbtn">
			<input type="submit" value="주문하기" class="button">
			<input type="button" value="돌아가기" class="button" onclick="history.back();">
		</div>
	</form>
</div>


<%@include file="../Footer.jsp" %>


<style>
	.long{
    	width:125px
    }
    .orderTable{
    	border-collapse: collapse;
    	margin:10px auto;
    }
    .priceInfo{
    	display:flex;
    	flex-direction:row;
		justify-content: space-around;
    }
    .pointinfo{
    	font-size:11px;
    	color:gray;
    }
    .priceInfo div{
    	text-align:center
    }
    #usePoint{
    	width:80px;
    	text-align:left;
    }
</style>

<%
	String phone = mBean.getPhone();
	String zipcode = mBean.getZipcode();
	String address = mBean.getAddress();
	String detailAddr = mBean.getAddrdetail();
%>
<script>
$(function() {
    $("#getInfo").click(function() {
        $("#name").attr("value", "<%=name %>");
        $("#phone").attr("value", "<%=phone %>");
        $("#zipcode").attr("value", "<%=zipcode %>");
        $("#address").attr("value", "<%=address %>");
        $("#detailAddr").attr("value", "<%=detailAddr %>");
    });
});
</script>

</body>
</html>