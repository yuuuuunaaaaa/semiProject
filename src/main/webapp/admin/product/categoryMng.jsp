<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,admin.product.*" %>
<jsp:useBean id="cMgr" class="admin.product.ProductMgr"/>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
	<script src="../../resource/js/product.js?v=<%=System.currentTimeMillis() %>"></script>
<meta charset="UTF-8">	<title>카테고리관리</title>
	<%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		int cnum=0;
		String cname="";
	%>
	<style>
		.border input{
			border:none;
			background:white;
		}
	</style>
</head>
<body>
	<button onclick="addsubmit();">카테고리 추가</button>
	<button onclick="updateCate();" title="변경할 카테고리를 선택한 후 수정하고 클릭하세요">카테고리명 변경</button>
	<button onclick="deletCate();">카테고리 삭제</button>
	<table>
		<tr >
			<th><input type="checkbox" id="allchk"></th>
			<th>번호</th>
			<th>카테고리명</th>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td>
				<form method="post" name="categoryadd" action="categoryadd.post" >
				<input type="text" name="catname" placeholder="추가할 카테고리 명"><br>
				</form>
			</td>
		</tr>
		<form method="post" name="categoryupdate" action="cateProc.jsp">
		<%
			ArrayList<CategoryBean> alist=cMgr.getCategory();
			for(int i=0;i<alist.size();i++){
				CategoryBean cBean=new CategoryBean();
				cBean=alist.get(i);
				cnum=cBean.getCatnum();
				cname=cBean.getCatname();
			%>
		<tr class="border">
			<td id="input"><input type="checkbox" name="chkYN" class="check" value="<%=i %>"></td>
			<td><%=i+1 %></td>
			<td>
				<input type="text" name="catname" value="<%=cname %>" required>
				<input type="hidden" value="<%=cnum%>" name="cnum">
			</td>
			 
		</tr>
			<%
			}
		%>
		<input type="hidden" name="updatetype" id="updatetype" value="0">
		</form>
	</table>
	
</body>
</html>