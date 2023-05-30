<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*" %>
<jsp:useBean id="cMgr" class="admin.product.ProductMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	int type=Integer.parseInt(request.getParameter("updatetype"));

		String chk[]=request.getParameterValues("chkYN");
		String upname[]=request.getParameterValues("catname");
		String upcnum[]=request.getParameterValues("cnum");
		
		int num[]=new int[chk.length];
		for(int i=0;i<chk.length;i++){
			num[i]=Integer.parseInt(chk[i]);
		}
		ArrayList<String[]> alist=new ArrayList<String[]>();
		for(int i=0;i<num.length;i++){
			String update[]={upcnum[num[i]],upname[num[i]]};
			alist.add(i, update);
		}
	if(type==1){
		boolean result=cMgr.categoryUpdate(alist);
		if(result){
			%>
			<script>
				alert("카테고리명 변경 완료");
				location.href='categoryMng.jsp';
			</script>
			<%
		}else{
			%>
			<script>
				alert("카테고리명 변경 실패");
				location.href='categoryMng.jsp';
			</script>
			<%
		}
	}else if(type==2){
		boolean result=cMgr.categoryDelete(alist);
		if(result){
			%>
			<script>
				alert("카테고리명 삭제 완료");
				location.href='categoryMng.jsp';
			</script>
			<%
		}else{
			%>
			<script>
				alert("카테고리명 삭제 실패");
				location.href='categoryMng.jsp';
			</script>
			<%
		}
	}
	
%>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리중</title>
</head>
<body>

</body>
</html>