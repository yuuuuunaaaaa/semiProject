<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.order.*,view.*" %>
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
	if(name==null){name="";}
	PMemberBean mBean=new PMemberMgr().getMember(id);
	
	ArrayList<OrderBean> alist=new OrderMgr().getOrderById(id);
	int proc1=0;
	int proc2=0;
	int proc3=0;
	int proc4=0;
	int proc5=0;
	for(int i=0;i<alist.size();i++){
		int proc=alist.get(i).getProccess();
		switch(proc){
		case 1: proc1++; break;
		case 2: proc2++; break;
		case 3: proc3++; break;
		case 4: proc4++; break;
		case 5: proc5++; break;
		}
	}
	
	
%>
	<meta charset="UTF-8">
	<title>회원정보 관리</title>
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
            <div class="sayhello">
                <div class="point"></div>
                <div>
                    🌼<%=name %>🌷님 안녕하세요
                </div>
                <div class="point">
                    포인트: <%=mBean.getPoint() %>
                </div>
            </div>
            <hr class="onorder">
            <div class="orderShort">
          		<a href='PersonalOrder.jsp?proc=1'><img src="../resource/img/주문완료.png"><div>주문 완료</div><div><%=proc1 %></div></a>
          		<a href='PersonalOrder.jsp?proc=2'><img src="../resource/img/준비중.png"><div>배송 준비 중</div><div><%=proc2 %></div></a>
          		<a href='PersonalOrder.jsp?proc=3'><img src="../resource/img/발송.png"><div>발송 완료</div><div><%=proc3 %></div></a>
          		<a href='PersonalOrder.jsp?proc=4'><img src="../resource/img/배송중.png"><div>배송 중</div><div><%=proc4 %></div></a>
          		<a href='PersonalOrder.jsp?proc=5'><img src="../resource/img/배송완료.png"><div>배송 완료</div><div><%=proc5 %></div></a>
            </div>
        </div>
        <div class="infosidemenu"></div>
    </div>
			
<%@include file="../Footer.jsp" %>
<style>
	.orderShort{
		margin: 0 auto;
		display:flex;
		flex-direction: row;
	}
	.orderShort a{
		color:gray;
		font-weight:300;
		display:flex;
		flex-direction: column;
		align-items:center;
		justify-content: flex-end;
		margin:0 25px;
		text-decoration:none;
		font-size:14px;
	}
	.orderShort td{
		width:100px;
		padding:5px;
	}
	.orderShort *{
		text-align:center;
	}
	.procImg a{
		text-decoration:none;
		font-size:13px
	}
</style>
</body>
</html>