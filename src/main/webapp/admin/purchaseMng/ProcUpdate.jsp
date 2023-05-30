<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,admin.order.*,view.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>...주문 상태 업데이트 중</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	int ordernum=Integer.parseInt(request.getParameter("ordernum"));
	int proc=Integer.parseInt(request.getParameter("process"));
	int currProc=Integer.parseInt(request.getParameter("currProc"));
	String postnum=request.getParameter("postnum");
	if(currProc>proc){
		%>
		<script>
		alert("전 단계로는 변경할 수 없습니다.");
		location.href='orderDetail.jsp?ordernum=<%=ordernum%>';
		</script>
		<%
	}else{
		int result=new OrderMgr().procUpdate(ordernum, proc, postnum);
		if(result==5){
			%>
			<script>
			alert("업데이트가 완료되었습니다.");
			location.href='orderDetail.jsp?ordernum=<%=ordernum%>';
			</script>
			<%
		}else if(result==3){
			%>
			<script>
			alert("운송장 번호를 입력해주세요.");
			location.href='orderDetail.jsp?ordernum=<%=ordernum%>';
			</script>
			<%
		}
		else{
			%>
			<script>
			alert("업데이트에 실패했습니다.");
			location.href='orderDetail.jsp?ordernum=<%=ordernum%>';
			</script>
			<%
		}
	}
	
%>
</body>
</html>