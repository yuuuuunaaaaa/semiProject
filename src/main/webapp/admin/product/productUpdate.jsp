<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,admin.product.*" %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<meta charset="UTF-8">
	<jsp:useBean id="pMgr" class="admin.product.ProductMgr"/>
	<title>상품 수정</title>
	<link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
	<script src="../../resource/js/product.js?v=<%=System.currentTimeMillis() %>"></script>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	int pronum=Integer.parseInt(request.getParameter("cnum"));
	ProductBean pBean=pMgr.getProduct(pronum);
	pBean.setPronum(pronum);
%>
</head>
<body>
	<form method="post" name="productupdate" action="${pageContext.request.contextPath}/admin/ProductUpdate.post" enctype="multipart/form-data">
	<table>
		<tr>
			<td>상품명: </td>
			<td>
				<input type="hidden" name="pronum" value="<%=pBean.getPronum() %>">
				<input type="text" name="name" value="<%=pBean.getProname() %>">
			</td>
		</tr>
		<tr>
			<td>카테고리: </td>
			<td>
				<select name="category">
			<%
				ArrayList<CategoryBean> alist=pMgr.getCategory();
				for(int i=0;i<alist.size();i++){
					int cnum=alist.get(i).getCatnum();
					String cname=alist.get(i).getCatname();
			%>
					<option value="<%=cnum %>" id="<%=cnum %>"><%=cname %></option>
			<%
				}
			%>
				</select>
			</td>
		</tr>
		<tr>
			<td>상품유형: </td>
			<td>
				<select name="type">
					<option value="sticker" id="sticker">스티커</option>
					<option value="griptock" id="griptock">그립톡</option>
					<option value="case" id="case">케이스</option>
					<option value="etc" id="etc">기타</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>원가: </td>
			<td>
				<input type="text" name="cost" value="<%=pBean.getCost() %>">
			</td>
		</tr>
		<tr>
			<td>소비자가격: </td>
			<td>
				<input type="text" name="price" id="price" value="<%=pBean.getPrice() %>">
			</td>
		</tr>
		<tr>
			<td>판매가격: </td>
			<td>
				<input type="text" name="sale" id="sale" value="<%=pBean.getSale() %>">
			</td>
		</tr>
		<tr>
			<td>썸네일: </td>
			<td>
				<input type="file" name="thumb" accept="image/jpeg, image/png, image/jpg">
			</td>
		</tr>
		<tr>
			<td>이미지: </td>
			<td>
				<input type="file" name="img" accept="image/jpeg, image/png, image/jpg">
			</td>
		</tr>
		<tr>
			<td>상품설명: </td>
			<td>
				<pre class="pre"><textarea rows="" cols="" name="content" class="content"></textarea></pre>
			</td>
		</tr>
		<tr>
			<td>재고수량: </td>
			<td>
				<input type="text" name="stock" value="<%=pBean.getStock() %>">
			</td>
		</tr>
	</table> 
				<input type="submit" value="상품 수정">
	</form>
	<script>
		$(function(){
			$("#<%=pBean.getCategory() %>").attr("selected",true);
		})
		$(function(){
			$("#<%=pBean.getType() %>").attr("selected",true);
		})
	</script>
	
</body>
</html>