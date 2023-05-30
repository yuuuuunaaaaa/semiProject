<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*,admin.product.*,admin.order.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id=(String)session.getAttribute("idKey");
	String name=(String)session.getAttribute("nameKey");
	int pronum=Integer.parseInt(request.getParameter("pronum"));
	if(id==null){
		%>
		<script>
			alert("로그인한 회원만 사용할 수 있는 기능입니다.");
			location.href="../saleView/CustomSale.jsp?pronum=<%=pronum %>";
		</script>
		<%
	}
	
	PMemberBean mBean=new PMemberMgr().getMember(id);
	int cartnum=mBean.getCartnum();
	int qtt=Integer.parseInt(request.getParameter("qtt"));
	CartBean cBean=new CartBean();
	cBean.setCartnum(cartnum);
	cBean.setId(id);
	cBean.setPronum(pronum);
	cBean.setQuantity(qtt);
	OrderMgr oMgr=new OrderMgr();
	boolean result=false;
	
	int type=Integer.parseInt(request.getParameter("chk"));//0은 중복 없음 1은 중복 있음
	if(type==0){
		result=oMgr.addCart(cBean);
	}else if(type==1){
		result=oMgr.updateCart(cBean);
	}
	if(result){
		%>
		<script>
		location.href="Cart.jsp";
		</script>
		<%
	}else{
		%>
		<script>
		alert("상품이 카트에 정상적으로 추가되지 않았습니다.");
		location.href="Cart.jsp";
		</script>
		<%
	}
%>
</body>
</html>