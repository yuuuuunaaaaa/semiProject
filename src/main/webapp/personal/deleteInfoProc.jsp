<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*,member.*,personal.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴 진행 중</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String pwd=request.getParameter("pwd");
	String id=request.getParameter("id");
	PMemberMgr pMgr=new PMemberMgr();
	String msg="";
	String act="";
	int result=pMgr.loginMember(id, pwd);
	boolean delresult=false;
	if(result==1){
		//삭제하러가자
		delresult=new PersonalMgr().deleteMember(id);
		if(delresult){
			msg="정상적으로 탈퇴되었습니다.";
			session.invalidate();
			act="location.href='../main.jsp'";
		}else{
			msg="시스템 내부 문제로 탈퇴가 이루어지지 않았습니다. 관리자에게 직접 문의하세요";
			act="location.href=deleteInfo.jsp";
		}
	}else{
		msg="비밀번호를 잘못 입력했습니다.입력하신 내용을 다시 확인해주세요.";
		act="history.back();";
	}
%>
<script>
	alert("<%=msg %>");
	<%=act %>;
</script>

</body>
</html>