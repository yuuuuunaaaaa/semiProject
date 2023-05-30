<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="member.PMemberMgr"/>    
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	int result = mMgr.loginMember(id, pwd);
	String name=mMgr.getMember(id).getName();
	
	String msg = "로그인 실패";
	String act="opener.parent.location.reload(); window.close();";
	if(result==1){
		session.setAttribute("idKey", id);
		session.setAttribute("nameKey", name);
		msg = name+"님 환영합니다🎉";
	}else if(result==2){
		msg="이미 탈퇴한 회원입니다.";
	}else{
		msg="아이디 또는 비밀번호를 잘못 입력했습니다.입력하신 내용을 다시 확인해주세요.";
		act="history.back();";
	}
%>
	
<script type="text/javascript">
	alert("<%=msg%>");
	//부모창 새로고침 후 종료
	
	<%=act %>
	/* window.close(); */
	/* location.href="login.jsp"; */
</script>
</body>
</html>