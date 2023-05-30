<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,admin.order.*,view.*" %>
<%	
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(!id.equals("admin")){
		%>
		<script>
			alert("관리자만 접근 가능한 페이지입니다.");
			location.href='../../main.jsp';
		</script>
		<%
	}
	if(name==null){name="";}
%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <link rel="shortcut icon" href="../resource/img/puppy.png">
   	<link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
<meta charset="UTF-8">
<title>주문관리</title>
</head>
<style>
	.pTable{
		margin:0 auto;
	}
</style>
<body>
<jsp:include page="../../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../../" name="path"/>
</jsp:include>
<div class="admTable">
	<form action="" name="orderAdmFrm" id="orderAdmFrm" method="post">
		<div class="topbtn">
			<button type="button" onclick="orderDetail();" class="admbtn">주문 자세히 보기</button>
			<button type="button" onclick="procUpdate();"  class="admbtn">주문 상황 수정</button>
			<input type="button" onclick="location.href='../AdminMain.jsp'" value="뒤로가기" class="admbtn">
	   	</div>
		<table class="pTable">
			<thead>
				<tr>
					<td><input type="checkbox" id="allchk"></td>
					<td>주문번호</td>
					<td>주문아이디</td>
					<td width="120px">주문날짜</td>
					<td>처리상황</td>
					<td>운송장번호</td>
					<td>주문금액</td>
					<td width="120px">완료날짜</td>
				</tr>
			</thead>
			<%
			OrderMgr oMgr=new OrderMgr();
			ArrayList<OrderBean> alist=oMgr.getOrdertList();
			int count=alist.size();
				for(int i=0;i<alist.size();i++){
					OrderBean oBean=alist.get(i);
					String enddate=oBean.getFinaldate();
					if(enddate==null){
						enddate="-";
					}
					String postnum=oBean.getPostnum();
					String readonly="";
					if(postnum==null||postnum.equals("-")){
						postnum="-"; readonly="";
					}else{
						readonly="readonly";
					}
				%>
			<tr>
				<td>
					<input type="checkbox" name="chk" class="check" value="<%=oBean.getOrdernum() %>">
				</td>
				<td><%=oBean.getOrdernum() %></td>
				<td><%=oBean.getId() %></td>
				<td><%=oBean.getIndate() %></td>
				<td>
					<input type="hidden" value="<%=oBean.getProccess() %>" name="oldProc<%=oBean.getOrdernum() %>">
					<select id="process<%=i %>" name="process<%=oBean.getOrdernum() %>" >
						<option id="pro1" value="1">주문완료</option>
						<option id="pro2" value="2">배송 준비 중</option>
						<option id="pro3" value="3">발송 완료</option>
						<option id="pro4" value="4">배송 중</option>
						<option id="pro5" value="5">배송 완료</option>
					</select>
				</td>
				<td><input type='text' name="postnum<%=oBean.getOrdernum() %>" value="<%=postnum %>" <%=readonly %> ></td>
				<td><%=oBean.getFinalPrice()%></td>
				<td><%=enddate %></td>
			</tr>
		<% } %>
		</table>
	</form>
</div>
<script>
$(function(){
	$("#allchk").click(function(){
		if($(this).is(":checked")){
			$(".check").prop("checked", true);
		}else{
			$(".check").prop("checked", false);
		}
	});
});

$(function(){
<% 
	for(int i=0;i<alist.size();i++){
		int procnum=alist.get(i).getProccess();
		%>
			$("#process<%=i%>").children("#pro<%=procnum %>").attr("selected",true);
		<%
	}
%>
});
function orderDetail(){
	let chkArray = []
	 
    $('input:checkbox[name=chk]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
        chkArray.push(this.value);
    });
	if(chkArray.length==0){
		alert("수정할 주문을 선택하세요");
		return;
	}else{
		for(let j=0;j<chkArray.length;j++){
			let ordernum=chkArray[j];
			let top=(window.screen.height-500)/2+j*40;
			let left=(window.screen.width-450)/2+j*40;
			window.open("orderDetail.jsp?ordernum="+ordernum,ordernum, "width=450, height=500, left="+left+", top="+top+",resizable = no, scrollbars = no");
		}
	}
}

function procUpdate(){
 	let postArray = [];
	let chkArray = [];
    $('input:checkbox[name=chk]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
        chkArray.push(this.value);
    });
    $('input:checkbox[name=chk]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
        chkArray.push(this.value);
    });
    
    if(chkArray.length==0){
    	alert("수정할 주문을 선택해주세요");
    	return;
    }else{
		$("#orderAdmFrm").attr("action","updateProc.jsp");
		orderAdmFrm.submit();
    }
} 

</script>

<%@include file="../../Footer.jsp" %>
</body>
</html>