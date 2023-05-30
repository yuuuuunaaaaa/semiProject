<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,admin.product.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<jsp:useBean id="pMgr" class="admin.product.ProductMgr"/>
	<title>상품 관리</title>
	
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script src="../../resource/js/product.js?v=<%=System.currentTimeMillis() %>"></script>
    <link rel="shortcut icon" href="../../resource/img/puppy.png">
	<link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){id="";}
	if(name==null){name="";}
%>
<jsp:include page="../../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../../" name="path"/>
</jsp:include>

    <div class="admTable">
    	<div class="topbtn">
			<button onclick="productAdd();"title="클릭하면 상품을 등록할 수 있는 창이 생성됩니다." class="admbtn">상품 등록</button>
			<button onclick="productUpdate();" title="수정할 상품을 한 개 선택한 후 클릭하세요" class="admbtn">상품 수정</button>
			<button onclick="productDelete();" title="삭제할 상품들을 선택하고 클릭하세요" class="admbtn">상품 삭제</button>
			<button onclick="changuse();" title="사용 여부를 변경할 상품들을 선택한 후 클릭하세요" class="admbtn">사용여부 변경</button>
			<button onclick="toCategory();" title="카테고리를 생성, 수정, 삭제할 수 있는 창이 생성됩니다." class="admbtn">카테고리 관리</button>
			<button onclick="mainProduct();" title="메인에 표시될 상품을 관리할 수 있는 창이 생성됩니다." class="admbtn">메인 상품 관리</button>
			<input type="button" onclick="location.href='../AdminMain.jsp'" value="뒤로가기" class="admbtn">
    	</div>
		<table>
			<tr>
				<td><input type="checkbox" id="allchk"></td>
				<th width="200px">상품명</th>
				<th width="65px">상품타입</th>
				<th width="65px">카테고리</th>
				<th width="55px">원가</th>
				<th width="55px">소비자가</th>
				<th width="55px">판매가</th>
				<th width="55px">판매수량</th>
				<th width="55px" title="(판매가격-원가)*판매수량">판매수익</th>
				<th width="55px">재고수량</th>
				<th width="55px">사용여부</th>
			</tr>
			<form method="post" name="mngFrm" action="" id="mgnFrm">
			<%
				ArrayList<ProductBean> alist=new ArrayList<>();
				alist=pMgr.getProductList();
				for(int i=0;i<alist.size();i++){
					ProductBean pBean=new ProductBean();
					pBean=alist.get(i);
		%>
			<tr>
				<td><input type="checkbox" name="chk" id="<%=pBean.getProname() %>" class="check" value="<%=pBean.getPronum() %>"></td>
				<td class="proname"><%=pBean.getProname() %></td>
				<td><%=pBean.getType() %></td>
				<td><%=pMgr.getCategoryName(pBean.getCategory()) %></td>
				<td><%=pBean.getCost() %></td>
				<td><%=pBean.getPrice() %></td>
				<td><%=pBean.getSale() %></td>
				<td><%=pBean.getSaleqtt() %></td>
				<td><%=pBean.getProfit()*pBean.getSaleqtt() %></td>
				<td><%=pBean.getStock() %></td>
				<td><%=pBean.getUseyn() %></td>
				
			</tr>
		<%
				}
			%>
			</form>
		</table>
	</div>
	<form action="useyorn.jsp">
		<input type="hidden" name="yn">
	</form>
<%@include file="../../Footer.jsp" %>
</body>
</html>