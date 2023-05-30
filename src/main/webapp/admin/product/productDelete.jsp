<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,admin.product.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>상품 삭제</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String str[]=request.getParameterValues("chk");
	int pronum[]=new int[str.length];
	for(int i=0;i<str.length;i++){
		pronum[i]=Integer.parseInt(str[i]);
	}
	ProductMgr pMgr=new ProductMgr();
	boolean result=pMgr.deleteProduct(pronum);
	if(result){
	%>
		<script>
		alert("상품 삭제가 완료되었습니다.");
		location.href="productMng.jsp";
		</script>
	<%
	}else{
	%>
		<script>
		alert("상품 삭제에 실패했습니다.");
		location.href="productMng.jsp";
		</script>
	<%
	}
	
%>
</body>
</html>