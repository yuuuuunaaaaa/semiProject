<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
    <link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
    <link rel="stylesheet" href="../resource/css/login_naver.css?v=<%=System.currentTimeMillis()%>">
    <link rel="stylesheet" href="../resource/css/Mypage.css?v=<%=System.currentTimeMillis()%>">
    <style>
    	
    	body>div{
    		display:flex;
    		align-items: center;
    		flex-direction: column;
    	}
    	form{
    		margin-top:20px;
    		margin-bottom:10px;
    		display:flex;
    		flex-direction: column;
    		align-items: center;
    	}
    	.logintitle{margin-bottom:10px}
    	.btn{
	    	display:flex;
	    	justify-content: center
    	}
    	.back{
    		display:flex;
    		flex-direction: row;
    		justify-content: flex-end;
    	}
    	.btn>.long{width:120px;margin-top:10px}
    	.infobody{width:700px}
    	.id_pw_wrap .input_row .input_text{padding:0}
    	.id_pw_wrap .input_row .input_text:hover{cursor:text}
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
<div class="bigbody">
	<div class="infosidemenu">
		<div><a class="button" href="PersonalOrder.jsp">주문조회</a></div>
		<div><a class="button" href="QnA.jsp" >1:1문의</a></div>
		<div><a href="InfoUpdate.jsp" class="button">정보수정</a></div>
		<div><a href="deleteInfo.jsp" class="button">회원탈퇴</a></div>
	</div>
	<div class="infobody">
	    <form name="deleteFrm" method="post" action="deleteInfoProc.jsp"  class="delFrm">
	        <div class="logintitle">비밀번호 입력</div>
	        <div class="lgnbox">
	            <div class="id_pw_wrap">
	                <div class="input_row" id="id_line">
	                    <input type="password" name="pwd" placeholder="비밀번호" class="input_text" required>
	                    <input type="hidden" name="id" value="<%=id %>">
	                </div>
	            </div>
	        </div>
	        <div class="btn">
	            <input class="button long"  type="button" value="회원 탈퇴" onclick="deleteMem();">
	        </div>
	    </form>
    </div>
    <script>
    	function deleteMem(){
    		let result=confirm("정말로 탈퇴하시겠습니까?");
    		if(result){
    			deleteFrm.submit();
    		}
    		
    	}
    </script>
    <div class="infosidemenu">
    </div>
 </div>
<%@include file="../Footer.jsp" %>
</body>
</html>