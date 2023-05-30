<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="member.*,personal.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
PMemberBean mBean=new PMemberBean();
mBean.setId((String)session.getAttribute("idKey"));
mBean.setPwd(request.getParameter("pwd"));
mBean.setName(request.getParameter("name"));
mBean.setPhone(request.getParameter("phone"));
mBean.setEmail(request.getParameter("email"));
mBean.setZipcode(request.getParameter("zipcode"));
mBean.setAddress(request.getParameter("address"));
mBean.setAddrdetail(request.getParameter("addrdetail"));

String result="";
if(new PersonalMgr().updateMember(mBean)) {
	result="회원 정보 변경 성공";
	session.setAttribute("nameKey", mBean.getName());
}else {
	result="회원 정보 변경이 정상적으로 이루어지지 않았습니다.";
}

%>
<script>
	alert("<%=result %>");
	location.href='InfoUpdate.jsp';
</script>
</body>
</html>