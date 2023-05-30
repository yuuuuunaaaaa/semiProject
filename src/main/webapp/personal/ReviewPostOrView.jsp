<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.product.*,admin.order.*,personal.*,view.*" %>    
<%
request.setCharacterEncoding("UTF-8");
String id=(String)session.getAttribute("idKey");
int pronum=Integer.parseInt(request.getParameter("pronum"));
int ordernum=Integer.parseInt(request.getParameter("ordernum"));

ArrayList<OrderBean> alist=new PersonalMgr().getAbleReviewList(id);
OrderBean odBean=new OrderBean();
for(int i=0;i<alist.size();i++) {
	if(alist.get(i).getPronum()==pronum && alist.get(i).getOrdernum()==ordernum) {
		odBean=alist.get(i);
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int proc=new OrderMgr().getOrder(ordernum).getProccess();
if(proc<5){
	%>
	<script>
		alert("아직 배송이 완료되지 않아 리뷰를 작성할 수 없습니다.");
	history.back();
	</script>
	<%
}else if(odBean.getPronum()==0){
	int reviewnum=new PersonalMgr().getReviewNum(pronum, ordernum);
	%>
	<script>
		location.href='ViewReview.jsp?reviewnum=<%=reviewnum %>';
	</script>
	<%
}else{
	%>
	<script>
		location.href='PostReview.jsp?ordernum='+<%=ordernum %>+'&pronum='+<%=pronum %>;
	</script>
	<%
}
%>

</body>
</html>