<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,admin.product.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>사용여부 변경</title>
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
	int result=pMgr.updateProdUse(pronum);
	if(result==1){
	%>
		<script>
		alert("변경이 완료되었습니다.");
		location.href="productMng.jsp";
		</script>
	<%
	}else if(result==-1){
	%>
		<script>
		alert("미사용으로 변경하려는 상품 중 메인에 표시되는 상품이 있습니다.");
		location.href="productMng.jsp";
		</script>
	<%
	}else{
	%>
		<script>
		alert("변경에 실패했습니다.");
		location.href="productMng.jsp";
		</script>
	<%
	}
	
%>
</body>
</html>