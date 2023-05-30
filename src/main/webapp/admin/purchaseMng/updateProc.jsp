<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<html>
<head>
    <link rel="shortcut icon" href="../resource/img/puppy.png">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String chkStr[]=request.getParameterValues("chk");
	
	String postnum[]=new String[chkStr.length];
	int ordernum[]=new int[chkStr.length];
	int proccess[]=new int[chkStr.length];
	int oldProc[]=new int[chkStr.length];
	for(int i=0;i<postnum.length;i++){
		ordernum[i]=Integer.parseInt(chkStr[i]);
		postnum[i]=request.getParameter("postnum"+chkStr[i]);
		proccess[i]=Integer.parseInt(request.getParameter("process"+chkStr[i]));
		oldProc[i]=Integer.parseInt(request.getParameter("oldProc"+chkStr[i]));
	}
	
	int count=0;
	for(int i=0;i<chkStr.length;i++){
		if(oldProc[i]>proccess[i]){
			%>
			<script>
			alert("전 단계로는 변경할 수 없습니다.");
			location.href="PurchaseMng.jsp";
			</script>
			<%
		}else{
			int result=new OrderMgr().procUpdate(ordernum[i], proccess[i], postnum[i]);
			if(result==5){
				count++;
			}else if(result==3){
				%>
				<script>
				alert("운송장 번호를 입력해주세요.");
				location.href="PurchaseMng.jsp";
				</script>
				<%
			}
			else{
				%>
				<script>
				alert("업데이트에 실패했습니다.");
				location.href="PurchaseMng.jsp";
				</script>
			<%
			}
		}
	}
		if(count==chkStr.length){
			%>
			<script>
			alert("업데이트를 완료했습니다.");
			location.href="PurchaseMng.jsp";
			</script>
		<%
		}else{
			%>
			<script>
			alert("업데이트에 실패했습니다.");
			location.href="PurchaseMng.jsp";
			</script>
		<%
		}
%>

</body>
</html>