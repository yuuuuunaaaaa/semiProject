<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,java.text.*,view.*,admin.product.ProductBean" %>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<meta charset="UTF-8">
	<title>상품 전체보기</title>
	<link rel="shortcut icon" href="../resource/img/puppy.png">
	<link rel="stylesheet" href="../resource/css/main_style.css?v=<%=System.currentTimeMillis()%>">
	<style>
		.mainarticle *{
			font-family: Roboto, 'Segoe UI',Arial,'Malgun Gothic',Gulim,sans-serif;
			font-size:14px;
		}
		.allimg{
			width:240px;
			height:240px;
			padding:5px;
		}
		.stock3 *:hover{
			cursor:pointer;
		}
	</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){id="";}
	if(name==null){name="";}
%>
<jsp:include page="../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../" name="path"/>
</jsp:include>

<%
	String num[]=request.getParameterValues("keyword");

	ArrayList<ProductBean> alistv;
	ProductViewMgr vMgr=new ProductViewMgr();
	String order="regdate";
	String cate=request.getParameter("category");
	int category=0;
	if(cate !=null){
		category=Integer.parseInt(cate);
	}
	if(cate!=null){
		alistv=vMgr.getProductYListByType(category);
	}else if(num==null){
		alistv=vMgr.getProductYList(order);
	}else{
		int pronum[]=new int[num.length];
		for(int i=0;i<num.length;i++){
			pronum[i]=Integer.parseInt(num[i]);
		}
		alistv=vMgr.searchProductY(pronum);
	}
	
	DecimalFormat df=new DecimalFormat("###,###");
	
%>

<article class="mainarticle">
    <div >
    <%
    int mod= alistv.size()%4;
    if(mod!=0){
    	mod=1;
    }
    for(int i=0;i<(alistv.size()/4+mod);i++){
    %>
    <div class="stock">
    <%
    	for(int j=i*4;j<4*(i+1);j++){
    			String link="";
    			String url="";
    			String productName="";
    			String dfSale="";
    			String img="";
    		if(j<alistv.size()){
	    		link="location.href='CustomSale.jsp?pronum="+alistv.get(j).getPronum()+"'";
	    		url="'../resource/fileupload/"+alistv.get(j).getThumb()+"'";
				img="<img src="+url+" class='allimg'>";
	    		productName=alistv.get(j).getProname();
	    		dfSale=df.format(alistv.get(j).getSale());
    		}
    %>
        <div class="stock2" onclick="<%=link %>">
            <div class="stock3">
                <div class="imgdiv"><%=img %></div>
            </div>
            <div class="stock3">
                <div class="namediv">
                	<div><%=productName %></div>
	                <div><%=dfSale %></div>
                </div>
            </div>
        </div>
    <%
    	}%>
	</div>
    	<%
    }
    %>
    </div>    
   
</article>



<%@include file="../Footer.jsp" %>
<a href="#top" class="totop"><img alt="" src="../resource/img/totop.png"> </a>
<style>
	.totop>img{
		width:40px;
		position:fixed;
		right:30px;
		bottom:30px;
	}
</style>
</body>
</html>