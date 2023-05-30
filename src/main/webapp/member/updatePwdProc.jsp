<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String phone=(String)session.getAttribute("phoneKey");
String id=(String)session.getAttribute("idKey");

System.out.println("uPP "+phone);
System.out.println("uPP "+id);
%>
<html>
<head>
    <link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
    <link rel="stylesheet" href="../resource/css/login_naver.css?v=<%=System.currentTimeMillis()%>">
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
	 	.input_row{width:300px}
	 	.long{width:150px}
	 	.logintitle{margin:20px}
	 	form{
	 		display:flex;
	 		align-items: center;
    		flex-direction: column;
	 		}
	 	.button{margin:20px 5px}
	</style>
</head>
<body>

    <form name="pwdfrm" method="post" action="updatePwd.jsp" >
        <div class="logintitle">비밀번호 바꾸기</div>
        <div class="lgnbox">
            <div class="input_row">
                <span class="blind">바꿀 비밀번호</span>
                <input type="password" name="pwd" placeholder="바꿀 비밀번호를 입력하세요" class="input_text" required>
            </div>
        </div>
        <div class="btn">
            <input class="button long"  type="submit" value="비밀번호 바꾸기"">
        </div>
    </form>

</body>
</html>