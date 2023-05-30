<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
    <link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
    <link rel="stylesheet" href="../resource/css/member.css?v=<%=System.currentTimeMillis()%>">
    <link rel="stylesheet" href="../resource/css/login_naver.css?v=<%=System.currentTimeMillis()%>">
	<style>
		.btn>.button{margin: 5px auto;}
	</style>
</head>
<body>

    <form name="LoginFrm" method="post" action="LoginProc.jsp" class="out form">
        <div class="logintitle">로그인</div>
        <div class="lgnbox">
            <div class="id_pw_wrap">
                <div class="input_row" id="id_line">
                    <div class="icon_cell" id="id_cell">
                        <span class="icon_id">
                            <span class="blind">아이디</span>
                        </span>
                    </div>
                    <input type="text" id="id" name="id" placeholder="아이디" class="input_text" maxlength="41" required>
                </div>
                <div class="input_row" id="pw_line">
                    <div class="icon_cell" id="pw_cell">
                        <span class="icon_pw">
                            <span class="blind">비밀번호</span>
                        </span>
                    </div>
                    <input type="password" id="pwd" name="pwd" placeholder="비밀번호" class="input_text" maxlength="16" required>
                </div>
            </div>
        </div>
        <div class="btn">
            <input class="button" type="submit" value="로그인"">
            <input class="button" type="button" value="아이디/비밀번호 찾기" id="find" onclick="findinfo();">
        </div>
    </form>
	<script>
	//488 520
	function findinfo(){
		window.resizeTo(570,600);
		location.href='findinfo.jsp';
	}
	</script>
</body>
</html>