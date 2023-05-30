<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,admin.order.*,view.*,admin.product.*,member.*" %>
<%	
	request.setCharacterEncoding("UTF-8");
	String id=(String)session.getAttribute("idKey");
	String name=(String)session.getAttribute("nameKey");
	if(!id.equals("admin")){
		%>
		<script>
			alert("관리자만 접근 가능한 페이지입니다.");
			location.href='../../main.jsp';
		</script>
		<%
	}
	if(name==null){name="";}
	int ordernum=Integer.parseInt(request.getParameter("ordernum"));
	
	OrderBean oBean=new OrderMgr().getOrder(ordernum);
	ArrayList<OrderBean> alist=new OrderMgr().getOrderDetails(ordernum);
	
	int procint=oBean.getProccess();
	String proc="";
	String enddate=oBean.getFinaldate();
	if(enddate==null){
		enddate="진행 중";
	}
	String postnum=oBean.getPostnum();
	String readonly="";
	if(postnum==null){
		postnum="";
	}else{
		readonly="readonly";
	}
	String orderName=new PMemberMgr().getMember(oBean.getId()).getName();
	int currProc=oBean.getProccess();
%>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <link rel="shortcut icon" href="../resource/img/puppy.png">
   	<link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
<meta charset="UTF-8">
<title><%=orderName %>님의 주문 내역</title>
</head>
<body>
<form action="ProcUpdate.jsp" method="post">
<table class="orderD">
	<tr>
		<td>주문번호</td>
		<td><%=oBean.getOrdernum() %>
		<input type="hidden" value="<%=oBean.getOrdernum() %>" name="ordernum">
		</td>
	</tr>
	<tr>
		<td>주문 아이디</td>
		<td><%=oBean.getId() %></td>
	</tr>
	<tr>
		<td>주문일</td>
		<td><%=oBean.getIndate() %></td>
	</tr>
	<tr>
		<td>처리 현황</td>
		<td>
			<select id="process" name="process">
				<option id="pro1" value="1">주문완료</option>
				<option id="pro2" value="2">배송 준비 중</option>
				<option id="pro3" value="3">발송 완료</option>
				<option id="pro4" value="4">배송 중</option>
				<option id="pro5" value="5">배송 완료</option>
			</select>
			<input type="hidden" value="<%=currProc %>" name="currProc">
		</td>
	</tr>
	<tr>
		<td>운송장번호</td>
		<td><input type='text' name="postnum" id="postnum" value="<%=postnum %>" <%=readonly %>></td>
	</tr>
	<tr>
		<td>수령인 이름</td>
		<td><%=oBean.getName() %></td>
	</tr>
	<tr>
		<td>수령인 연락처</td>
		<td><%=oBean.getPhone() %></td>
	</tr>
	<tr>
		<td>수령인 주소</td>
		<td style="text-align:left">
			<%=oBean.getZipcode() %><br>
			<%=oBean.getAddress() %><br>
			<%=oBean.getAddrdetail() %><br>
		</td>
	</tr>
	<tr>
		<td>최종 결제 금액</td>
		<td><%=oBean.getFinalPrice() %></td>
	</tr>
	<tr>
		<td>주문 처리 완료일</td>
		<td><%=enddate %></td>
	</tr>
	<tr>
		<td>주문 내용</td>
		<td>
			<table>
			<tr>
				<td>주문 상품</td>
				<td>주문 수량</td>
			</tr>
			<%
			for(int i=0;i<alist.size();i++){
				OrderBean odBean=alist.get(i);
				ProductMgr pMgr=new ProductMgr();
				String proname=new ProductMgr().getProduct(odBean.getPronum()).getProname();
				%>
				<tr>
					<td width="170px"><%=proname %></td>
					<td><%=odBean.getQuantity() %></td>
				</tr>
				<%
			}
			%>
			</table>
		</td>
	</tr>
</table>
<input type="submit" value="상태 수정하기">
</form>
<style>
	.orderD td{
		padding:3px;
	}
</style>

<script>
<% 
for(int i=0;i<alist.size();i++){
	int procnum=oBean.getProccess();
	%>
		$("#process").children("#pro<%=procnum %>").attr("selected",true);
	<%
}
%>
</script>



</body>
</html>