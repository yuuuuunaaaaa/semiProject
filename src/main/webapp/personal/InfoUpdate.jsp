<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,member.*" %>
<!DOCTYPE html>
<html>
<head>
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){id="";}
	if(name==null){name="";}
	PMemberBean mBean=new PMemberMgr().getMember(id);
%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="../resource/js/memUpdate_script.js?v=<%=System.currentTimeMillis() %>" type="text/javascript" charset="utf-8"></script>
	<meta charset="UTF-8">
	<title><%=name %>님 회원정보 수정</title>
	<link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
	<link rel="stylesheet" href="../resource/css/joinin.css?v=<%=System.currentTimeMillis()%>">	
	<link rel="stylesheet" href="../resource/css/Mypage.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>

<script>
//주소 다음api
	function findAddr(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	let roadAddr=data.roadAddress;
                let extraAddr='';

                document.getElementById("postcode").value=data.zonecode;
                
                if(roadAddr != ''){
                    if(data.bname != ''){
                        extraAddr += data.bname;
                	}
                	if(data.buildingName != ''){
                        extraAddr += extraAddr != ''? ', '+data.buildingName : data.buildingName; 
                	}
                	roadAddr += extraAddr != '' ? '('+extraAddr+')' : ''; 
                    document.getElementById("addr").value=roadAddr;
                }
	        }
	    }).open();
	};
</script>


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
	
	
        <form method="post" name="memUpdateFrm" action="memberUpdateProc.jsp">
		    <table align="center" class="memtable">
	            <tr>
	                <td class="title">아이디</td>
	                <td>
	                    <input disabled value="<%=mBean.getId() %>" id="id">
	                </td>
	            </tr>
	            <tr>
	                <td rowspan="2" class="title">비밀번호</td>
	                <td class="eye">
	                    <input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요" onkeyup="pwdChk0();" value="<%=mBean.getPwd() %>">
	                </td>
	            </tr>
	            <tr>
	                <td class="guide" id="pwdresult">비밀번호를 적어주세요.<br>(문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요)</td>
	            </tr>
	            <tr>
	                <td rowspan="2" class="title">비밀번호확인</td>
	                <td><input type="password" name="repwd" placeholder="비밀번호를 입력하세요" id="pwdchkinput" onkeyup="pwdChk();" onclick="pwdChk();"></td>
	            </tr>
	            <tr>
	                <td class="guide" id="pwdchk">위에 입력한 비밀번호와 동일한 비밀번호를 입력하세요</td>
	            </tr>
	            <tr>
	                <td rowspan="2" class="title">이름</td>
	                <td><input name="name" id="name" placeholder="이름을 입력하세요" onkeyup="nameChk();" value="<%=mBean.getName() %>"></td>
	            </tr>
	            <tr>
	                <td class="guide" id="nameresult">한글로 입력하세요</td>
	            </tr>
	            <tr>
	                <td rowspan="2" class="title">휴대폰 번호</td>
	                <td>
	               		<input type="text" name="phone" id="phone" class="phone" onkeyup="numberChk();" value="<%=mBean.getPhone() %>" >
	                </td>
	            </tr>
	            <tr>
	                <td class="guide" id="phoneresult">숫자만 입력하세요</td>
	            </tr>
	
	            <tr>
	                <td rowspan="2" class="title">이메일</td>
	                <td><input type="email" name="email" placeholder="이메일을 입력하세요" id="email" value="<%=mBean.getEmail() %>"></td>
	            </tr>
	            <tr>
	                <td class="guide" id="emailchk">ex) email@example.com</td>
	            </tr>
	            <tr>
	                <td rowspan="2" class="title">우편번호</td>
	                <td>
	                    <input name="zipcode" id="postcode" readonly  value="<%=mBean.getZipcode() %>">
	                    <input class="button zcdbtn" type="button" value="우편번호 찾기" onclick="findAddr();" >
	                </td>
	            </tr>
	            <tr>
	                <td class="guide">우편번호를 검색하세요</td>
	            </tr>
	            <tr>
	                <td rowspan="" class="title">주소</td>
	                <td><input name="address" id="addr" size="40" readonly  value="<%=mBean.getAddress() %>" class="addr"><br>
	                	<input name="addrdetail" id="detailAddr" placeholder="상세주소"  value="<%=mBean.getAddrdetail() %>" class="addr"></td>
	            </tr>
	    	</table>
    		<div class="bottom">
                    <input class="button" type="button" value="정보수정" id="sub" onclick="updateCheck();">
                    <input class="button" type="reset" value="다시쓰기">
    		</div>
        </form>
		
	</div>
	<div class="infosidemenu"></div>
</div>
<style>
	.memtable td{
		text-align:left
	}
	.memtable .zcdbtn{
		width:100px;
		padding: 10px;
	}
	.memtable .addr{
		text-aligh:left
	}
	.bottom{
		display:flex;
		flex-direction: row;
		justify-content: center;
	}
</style>
			
<%@include file="../Footer.jsp" %>
</body>
</html>