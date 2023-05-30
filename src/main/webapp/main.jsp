<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,java.text.*,admin.product.*" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>💕💕</title>
    <link rel="stylesheet" href="resource/css/main_style.css?v=<%=System.currentTimeMillis()%>">
    <link rel="shortcut icon" href="resource/img/puppy.png">
</head>
<body class="mainbody">
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){id="";}
	if(name==null){name="";}
%>
<jsp:include page="header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="" name="path"/>
</jsp:include>
<%
	ProductMgr pMgr=new ProductMgr();
	int pronum[]=pMgr.getMainProd();
	String thumName[]=new String[pronum.length];
	String proname[]=new String[pronum.length];
	for(int i=0;i<pronum.length;i++){
		thumName[i]=pMgr.getProduct(pronum[i]).getThumb();
		proname[i]=pMgr.getProduct(pronum[i]).getProname();
	}
	DecimalFormat df=new DecimalFormat("###,###");
	
	String url="resource/fileupload/";
%>

<article class="mainarticle">
    <div class="stock">
    <%
    	for(int i=0;i<4;i++){
    %>
        <div class="stock2" onclick="location.href='saleView/CustomSale.jsp?pronum=<%=pronum[i] %>'">
            <div class="stock3">
                <div class="imgdiv"><img src="<%=url %><%=thumName[i] %>" alt=""></div>
            </div>
            <div class="stock3">
                <div class="namediv">
                	<div><%=proname[i] %></div>
	                <div><%=df.format(pMgr.getProduct(pronum[i]).getSale()) %></div>
                </div>
            </div>
        </div>
    <%
    	}
    %>
    </div>    
    <div class="stock">
        <%
    	for(int i=4;i<8;i++){
    %>
        <div class="stock2" onclick="location.href='saleView/CustomSale.jsp?pronum=<%=pronum[i] %>'">
            <div class="stock3">
                <div class="imgdiv"><img src="<%=url %><%=thumName[i] %>" alt=""></div>
            </div>
            <div class="stock3">
                <div class="namediv">
                	<div><%=proname[i] %></div>
	                <div><%=df.format(pMgr.getProduct(pronum[i]).getSale()) %></div>
                </div>
            </div>
        </div>
    <%
    	}
    %>
    </div>    
</article>
<%@include file="Footer.jsp" %>
</body>
    <script>
   	function member(){
   		let top=(window.screen.height-350)/2;
   		let left=(window.screen.width-570)/2;
   		
   		window.open("member/login.jsp","login", "width=570, height=350, left="+left+", top="+top+",resizable = no, scrollbars = no");

   	}
    	
    </script>

</html>