<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="member.PMemberMgr" />
<%
	request.setCharacterEncoding("utf-8");
	String id=request.getParameter("id");
	boolean result=mMgr.checkId(id);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ID중복확인</title>
	<link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
<style>
@font-face {
            font-family: 'IBMPlexSansKR-Regular';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
    * {font-family: 'IBMPlexSansKR-Regular';}

</style>
</head>
<body>
<%
	if(result){
		out.print(id +"은(는) 이미 존재하는 ID입니다.<p/>");
	}else{
		out.print(id+"은(는) 사용 가능한 ID입니다.<p/>");
	}
%>
<div style="text-align: center;"><button onclick="self.close();" class="button">닫기</button></div>
</body>
</html>