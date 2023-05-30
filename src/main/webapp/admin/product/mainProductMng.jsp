<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,admin.product.*,view.*" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
<meta charset="UTF-8">
	<title>Insert title here</title>
<%
	ArrayList<ProductBean> alist=new ProductViewMgr().getProductYList("regdate");
	ArrayList<ProductBean> alistNew=new ProductMgr().getNew();
	ArrayList<ProductBean> alistPop=new ProductMgr().getPopular();
%>
</head>
<body>
	<div>
		<input type="button" value="최신순" onclick="getNew();">
		<input type="button" value="판매순" onclick="getPop();">
	</div>
	<form action="getWhat.prod" method="post">
		<table>
			<tr>
				<th>순서</th>
				<th>상품명</th>
			</tr>
		<%
			for(int i=0;i<8;i++){
			%>
			<tr>
				<td><%=i+1 %></td>
				<td>
					<select name="mainView" id="select<%=i %>">
				<%
					for(int j=0;j<alist.size();j++){
						String proname=alist.get(j).getProname();
						int pronum=alist.get(j).getPronum();
				%>
						<option value="<%=pronum %>" id="prod<%=pronum %>"><%=proname %></option>
				<%
					}
				%>
					</select>
				</td>
			</tr>
			<%
			}
		
		%>
		</table>
		<input type="submit" value="등록하기" >
	</form>
<script>
 	$(function(){
 		<%
 		ProductMgr pMgr=new ProductMgr();
 		int pronum[]=pMgr.getMainProd();
 		for(int i=0;i<8;i++){
		%>
			$("#select<%=i %>").children("#prod<%=pronum[i] %>").attr("selected",true);
		<%
		}
	%>
	});
	
	
	function getNew() {
	<%
		for(int i=0;i<8;i++){
		%>
			$("#select<%=i %>").children().attr("selected",false);
		<%
		}
		for(int i=0;i<alistNew.size();i++){
			int prodnum=alistNew.get(i).getPronum();
		%>
			$("#select<%=i %>").children("#prod<%=prodnum %>").attr("selected",true);
		<%
		}
	%>
	}
	function getPop() {
	<%
		for(int i=0;i<8;i++){
		%>
			$("#select<%=i %>").children().attr("selected",false);
		<%
		}
		for(int i=0;i<alistPop.size();i++){
			int prodnum=alistPop.get(i).getPronum();
		%>
			$("#select<%=i %>").children("#prod<%=prodnum %>").attr("selected",true);
		<%
		}
	%>
	}
</script>
</body>
</html>