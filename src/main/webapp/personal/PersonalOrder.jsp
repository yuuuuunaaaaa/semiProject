<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.order.*,view.*" %>    
<!DOCTYPE html>
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
	String procStr=request.getParameter("proc");
	int proc=0;
	String procView="";
	if(procStr!=null){
		proc=Integer.parseInt(procStr);
		switch(proc){
		case 1:procStr="주문 완료"; break;
		case 2:procStr="배송 준비 중"; break;
		case 3:procStr="발송 완료"; break;
		case 4:procStr="배송 중"; break;
		case 5:procStr="배송 완료"; break;
		}
		
	}
	
	ArrayList<OrderBean> alist=new OrderMgr().getOrderById(id);
	ArrayList<OrderBean> procAlist=new ArrayList<OrderBean>();
	if(proc>0){
		for(int i=0;i<alist.size();i++){
			if(alist.get(i).getProccess()==proc ){
				procAlist.add(alist.get(i));
			}
		}
	}else{
		procAlist=new OrderMgr().getOrderById(id);
	}
	
%>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
	<link rel="stylesheet" href="../resource/css/Mypage.css?v=<%=System.currentTimeMillis()%>">
<meta charset="UTF-8">
<title>주문 정보 확인</title>
</head>
<body>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>
<div>
    <div class="infosidemenu">
        <div><a class="button" href="PersonalOrder.jsp" >주문조회</a></div>
        <div><a class="button" href="QnA.jsp" >1:1문의</a></div>
        <div><a href="InfoUpdate.jsp" class="button">정보수정</a></div>
        <div><a href="deleteInfo.jsp" class="button">회원탈퇴</a></div>
    </div>
			<table class="pOrderT" id="pOrderT">
				<tr>
					<td width="100px">주문 번호</td>
					<td width="120px">주문 날짜</td>
					<td width="100px">주문 상태</td>
					<td width="150px">운송장 번호</td>
					<td width="100px">주문 금액</td>
					<td width="120px">주문 완료 날짜</td>
					<td width="100px">적립(예정)<br> 포인트</td>
				</tr>
				<%
					for(int i=0;i<procAlist.size();i++){
						OrderBean oBean=procAlist.get(i);
						switch(oBean.getProccess()){
						case 1:procStr="주문 완료"; break;
						case 2:procStr="배송 준비 중"; break;
						case 3:procStr="발송 완료"; break;
						case 4:procStr="배송 중"; break;
						case 5:procStr="배송 완료"; break;
						}
						String postnum=oBean.getPostnum();
						if(postnum==null){
							postnum="-";
						}
						String enddate=oBean.getFinaldate();
						if(enddate==null){
							enddate="-";
						}
						
				%>
				<tr id="tr<%=i %>">
					<td>
						<%=oBean.getOrdernum() %><input type="hidden" value="<%=oBean.getOrdernum() %>" id="ordernum<%=i %>">
					</td>
					<td><%=oBean.getIndate() %></td>
					<td><%=procStr %></td>
					<td><%=postnum %></td>
					<td><%=oBean.getFinalPrice() %></td>
					<td><%=enddate %></td>
					<td><%=oBean.getPoint() %></td>
				</tr>
				<%
					}
				%>
			</table>
</div>
<%@include file="../Footer.jsp" %>
<style>
		.pOrderT{
		border-collapse:collapse;
		margin: 40px auto;
	}
	.pOrderT td{
		border: solid 1px;
		padding:5px;
	}
	.pOrderT *{
		text-align:center;
	}
	.infosidemenu{
		text-align:center;
	}
</style>
<script>
	$(function(){
<%
	for(int i=0;i<procAlist.size();i++){
		%>
			$("#tr<%=i %>").mouseover(function(){
				$("#tr<%=i %>").css("background-color","#ffffbd3b").css("cursor","pointer");
			})
			$("#tr<%=i %>").mouseout(function(){
				$("#tr<%=i %>").css("background-color","white").css("cursor","default");;
			})
			$("#tr<%=i %>").click(function(){
				let value=$("#ordernum<%=i %>").val();
				location.href="PersonalOrderDetail.jsp?ordernum="+value;
			})
		<%

		}%>
	})
	$(function(){
		<%
		if(procAlist.size()<3){
			%>
			let heg=100*<%=3-procAlist.size() %>+40+"px"
			$("#pOrderT").css("margin-bottom",heg)
			<%
		}
		%>
	})
	
</script>
</body>
</html>