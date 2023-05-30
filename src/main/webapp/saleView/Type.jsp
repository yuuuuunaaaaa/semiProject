<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,java.text.*,admin.product.*,view.*" %>
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
	String type=request.getParameter("type");
	if(type==null){type="sticker";}
	ProductViewMgr pMgr=new ProductViewMgr();
	
	ArrayList<ProductBean> alist=pMgr.getProductYListByType(type,"regdate");
	
	DecimalFormat df=new DecimalFormat("###,###");
	
	
%>

<article class="mainarticle">
    <div >
    <%
    int mod= alist.size()%4;
    if(mod!=0){
    	mod=1;
    }
    for(int i=0;i<(alist.size()/4+mod);i++){
    %>
    <div class="stock">
    <%
    	for(int j=i*4;j<4*(i+1);j++){
    			String link="";
    			String url="";
    			String productName="";
    			String dfSale="";
    			String img="";
    		if(j<alist.size()){
	    		link="location.href='CustomSale.jsp?pronum="+alist.get(j).getPronum()+"'";
	    		url="'../resource/fileupload/"+alist.get(j).getThumb()+"'";
				img="<img src="+url+" class='allimg'>";
	    		productName=alist.get(j).getProname();
	    		dfSale=df.format(alist.get(j).getSale());
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
</body>
</html>