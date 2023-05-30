<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="../resource/js/member_script.js?v=<%=System.currentTimeMillis() %>" type="text/javascript" charset="utf-8"></script>
	<link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
	<link rel="stylesheet" href="../resource/css/joinin.css?v=<%=System.currentTimeMillis()%>">

<script>
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
<title>회원가입</title>
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
    <table align="center" class="memtable">
        <form method="post" name="regFrm" action="memberProc.jsp">
            <tr>
                <th colspan="2" class="top"> 회원가입</th>
            </tr>
            <tr>
                <td rowspan="2" class="title">아이디</td>
                <td>
                    <input name="id" placeholder="아이디를 입력하세요" onkeyup="inputIdChk();">
                    <input class="button inner" type="button" value="중복확인" onclick="idCheck(this.form.id.value);">
                    <input type="hidden" name="idbtncheck" value="idUncheck">
                </td>
            </tr>
            <tr>
                <td class="guide" id="idresult">아이디를 적어주세요.(20자 이내로 영어, 숫자만)</td>
            </tr>
            <tr>
                <td rowspan="2" class="title">비밀번호</td>
                <td class="eye">
                    <input type="password" id="pwd" name="pwd" placeholder="비밀번호를 입력하세요" onkeyup="pwdChk0();">
                    <span id="openeye"> <i class="fa-solid fa-eye pwview"></i>
                        <i class="fa-solid fa-eye-slash pwhide" style="display: none;"></i></span>
                </td>
            </tr>
            <tr>
                <td class="guide" id="pwdresult">비밀번호를 적어주세요.(문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요)</td>
            </tr>
            <tr>
                <td rowspan="2" class="title">비밀번호확인</td>
                <td><input type="password" name="repwd" placeholder="비밀번호를 입력하세요" id="pwdchkinput" onkeyup="pwdChk();"
                        onclick="pwdChk();"></td>
            </tr>
            <tr>
                <td class="guide" id="pwdchk">위에 입력한 비밀번호와 동일한 비밀번호를 입력하세요</td>
            </tr>
            <tr>
                <td rowspan="2" class="title">이름</td>
                <td><input name="name" id="name" placeholder="이름을 입력하세요" onkeyup="nameChk();"></td>
            </tr>
            <tr>
                <td class="guide" id="nameresult">한글로 입력하세요</td>
            </tr>
            <tr>
                <td rowspan="2" class="title">휴대폰 번호</td>
                <td>
               		<div><input type="text" name="phone" class="phone" onkeyup="numberChk();"></div>
                </td>
            </tr>
            <tr>
                <td class="guide" id="phoneresult">숫자만 입력하세요</td>
            </tr>

            <tr>
                <td rowspan="2" class="title">이메일</td>
                <td><input type="email" name="email" placeholder="이메일을 입력하세요" id="email"></td>
            </tr>
            <tr>
                <td class="guide" id="emailchk">ex) email@example.com</td>
            </tr>
            <tr>
                <td rowspan="2" class="title">우편번호</td>
                <td>
                    <input name="zipcode" id="postcode" readonly>
                    <input class="button zcdbtn" type="button" value="우편번호 찾기" onclick="findAddr();">
                </td>
            </tr>
            <tr>
                <td class="guide">우편번호를 검색하세요</td>
            </tr>
            <tr>
                <td rowspan="" class="title">주소</td>
                <td><input name="address" id="addr" size="40" readonly><br><input name="addrdetail" id="detailAddr"
                        placeholder="상세주소"></td>
            </tr>
            <tr class="btn">
                <td colspan="2" class="foot">
                    <input class="button" type="button" value="회원가입" id="sub" onclick="inputCheck();">
                    <input class="button" type="reset" value="다시쓰기">
                </td>
            </tr>
        </form>
    </table>
<%@include file="../Footer.jsp" %>
</body>
</html>