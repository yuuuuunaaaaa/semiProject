<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,admin.product.*,view.*,member.*" %>    
<!DOCTYPE html>
<html>
<head>
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){
	%>
		<script>
		alert("로그인한 회원만 사용할 수 있는 기능입니다.");
		history.back();
		</script>
	<%
	}
	if(name==null){name="";}

	ProductBean pBean=new ProductBean();
	
	OrderBean oBean=new OrderBean();

	ArrayList<OrderBean> alist=new ArrayList<>();
	
	int finalPrice=Integer.parseInt(request.getParameter("totalPrice"));
	int totalPoint=Integer.parseInt(request.getParameter("totalPoint"));
	String oName=request.getParameter("name");
	String phone=request.getParameter("phone");
	String zipcode=request.getParameter("zipcode");
	String address=request.getParameter("address");
	String addrdetail=request.getParameter("addrdetail");
	String cartnumTem=request.getParameter("cartnum");
	String tmpUse=request.getParameter("usePoint");
	int usePoint=0;
	if(tmpUse != null){
		usePoint=Integer.parseInt(tmpUse);
	}
	int cartnum=0;
	if(cartnumTem!=null){
		cartnum=Integer.parseInt(request.getParameter("cartnum"));
	}
	
	String pronumTem[]=request.getParameterValues("pronum");
	String qttTmp[]=request.getParameterValues("quantity");
	
	int qttArr[]=new int[qttTmp.length];
	int pronumArr[]=new int[pronumTem.length];
	for(int i=0;i<pronumArr.length;i++){
		qttArr[i]=Integer.parseInt(qttTmp[i]);
		pronumArr[i]=Integer.parseInt(pronumTem[i]);
	}
	oBean.setId(id);
	oBean.setName(oName);
	oBean.setPoint(totalPoint);
	oBean.setFinalPrice(finalPrice);
	oBean.setZipcode(zipcode);
	oBean.setAddress(address);
	oBean.setAddrdetail(addrdetail);
	oBean.setPhone(phone);
	
	for(int i=0;i<pronumArr.length;i++){
		OrderBean odBean=new OrderBean();
		odBean.setPronum(pronumArr[i]);
		odBean.setQuantity(qttArr[i]);
		alist.add(i, odBean);
	}
	String msg="주문실패";
	boolean result=new ProductViewMgr().purchaseIn(alist, oBean, cartnum);
	boolean resultYN=false;
	if(cartnum>0){
		int count=0;
		for(int i=0;i<pronumArr.length;i++){
			resultYN=new ProductViewMgr().updateCartYN(cartnum, pronumArr[i]);
			if(resultYN){
				count++;
			}
		}
		if(count==pronumArr.length){
			resultYN=true;
		}
	}
	boolean pointResult=false;
	if(usePoint>0){
		pointResult=new PMemberMgr().usePoint(id, usePoint);
	}
	if(result){
		msg="<script> location.href='OrderSuccess.jsp'</script>";
	}else{
		msg="<script> "+
		"alert('주문을 완료하지 못했습니다.'); location.href='history.back();'</script>";
	}
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>
	
	<%=msg %>
</body>
</html>