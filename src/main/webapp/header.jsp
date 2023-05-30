<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%
	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	String id=request.getParameter("id");
	String path=request.getParameter("path");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   	<link rel="stylesheet" href="<%=path %>resource/css/button.css?v=<%=System.currentTimeMillis()%>">
   	<link rel="stylesheet" href="<%=path %>resource/css/header.css?v=<%=System.currentTimeMillis()%>">
    <link rel="shortcut icon" href="<%=path %>resource/img/puppy.png">
    <style>
	    .button{
			margin:7px;
		}
	    input:focus{
    		outline: none;
    	}
    </style>
</head>
<body>
	<header class="mainheader">
        <img src="<%=path %>resource/img/headlogo.jpg" alt="tohome" onclick="location.href='<%=path %>main.jsp'">
    </header>
    <nav class="mainnav">
        <div class="hidden"></div>
        <img src="<%=path %>resource/img/1_menu.PNG" alt="menu" id="menu" class="menu div-close">
        <img src="<%=path %>resource/img/2_about.PNG" alt="about" onclick="about();">
        <img src="<%=path %>resource/img/3_sale.PNG" alt="sale" onclick="sale();">
        <img src="<%=path %>resource/img/4_new.PNG" alt="new" onclick="newarrival();">
	<%
	if(id.equals("admin")){
	%>
		<img src="<%=path %>resource/img/puppy.png" alt="admin" onclick="location.href='<%=path %>admin/AdminMain.jsp'">
	<%
	}
	%>        
        <div class="hidden"></div>
    </nav>
    <div class="sidebar">
   		<div class="serchdiv">
	   			<input type="text" class="search" placeholder="상품검색" id="keyWord" onkeyup="if(window.event.keyCode==13){search()}">
	   			<img src="<%=path %>resource/img/search.png" class="searchicon" onclick="search();">
 		</div>
    	<div class="sidebarBtn">
	    	<div><input type="button" class="button" value="ALL"  onclick="viewall();"></div>
	    	<div><input type="button" class="button" value="STICKER"  onclick="sticker();"></div>
	    	<div><input type="button" class="button" value="GRIPTOK" onclick="griptok();"></div>
	    	<div><input type="button" class="button" value="CASE" onclick="phonecase();"></div>
	    	<div><input type="button" class="button" value="ETC" onclick="etc();"></div>
	    </div>
    </div>
    
    	    <div class="btnplace">
	  <%
	  if(name.equals("")){
	  %>
	    	<input type="button" class="button" value="join in" onclick="location.href='<%=path %>member/member.jsp'">
	    	<input type="button" class="button" value="log in" onclick="member();">
	  <%
	  }else{
	  %>
	  		<div class="personal">
	  			<img alt="" src="<%=path %>resource/img/cart.png" class="iconbtn" onclick="location.href='<%=path %>personal/Cart.jsp'">
	  			<img alt="" src="<%=path %>resource/img/mypage.png" class="iconbtn" onclick="location.href='<%=path %>personal/Mypage.jsp'">
	  		</div>
	  		<input type="button" class="button" value="log out" onclick="location.href='<%=path %>member/logout.jsp'">
	  <%
	  }
	  %>
	    </div>
    <a href="#top" class="totop"><img alt="" src="<%=path %>resource/img/totop.png"> </a>
<style>
	.totop>img{
		width:40px;
		position:fixed;
		right:30px;
		bottom:30px;
		opacity:0.4;
	}
</style>
    <script>
	function member(){
		let top=(window.screen.height-350)/2;
		let left=(window.screen.width-570)/2;
		
		window.open("<%=path %>member/login.jsp","login", "width=570, height=350, left="+left+", top="+top+",resizable = no, scrollbars = no");

	}
	
    $("#menu").click(function(){
    	$("#menu").toggleClass("div-close");
    	  
    	if($("#menu").hasClass("div-close")) {
    	    $(".sidebar").animate({ left: "-200px"}, 700);
    	}else{
    	    $(".sidebar").animate({ left: "0px"}, 700);  
    	}
    }); 
    
    function about(){
    	location.href="<%=path %>saleView/about.jsp";
    }
    function sale(){
    	location.href="<%=path %>saleView/ViewSale.jsp";
    }
    function newarrival(){
    	location.href="<%=path %>saleView/ViewNew.jsp";
    }
    
    function viewall(){
    	location.href="<%=path %>saleView/ViewAll.jsp";
    }
    function sticker(){
    	location.href="<%=path %>saleView/Type.jsp?type=sticker";
    }
    function griptok(){
    	location.href="<%=path %>saleView/Type.jsp?type=griptok";
    }

    function phonecase(){
    	location.href="<%=path %>saleView/Type.jsp?type=case";
    }
    function etc(){
    	location.href="<%=path %>saleView/Type.jsp?type=etc";
    }
    function search(){
   		$.ajax({
   			url: "<%=path%>SearchKeyWord.me",
   			data:{keyWord:$("#keyWord").val()},
   			type:"post",
   			success:function(arr){
   				if(arr==-1){
   					alert("검색 결과가 없습니다.")
   				}else{
    				let str="";
    				for(let i=0;i<arr.length;i++){
    					str+="keyword="+arr[i]+"&";
    				}
	    				location.href='<%=path %>saleView/ViewAll.jsp?'+str;
   				}
   			},
   			error:function() {
				console.log("ajax 통신 실패");
			}
   			
   		}) 
    }
    </script>
</body>
</html>