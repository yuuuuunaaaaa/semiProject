<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="../resource/css/button.css?v=<%=System.currentTimeMillis()%>">
    <link rel="stylesheet" href="../resource/css/login_naver.css?v=<%=System.currentTimeMillis()%>">
    <style>
    	.long{width:150px;margin-top:10px}
    	body>div{
    		display:flex;
    		align-items: center;
    		flex-direction: column;
    	}
    	form{margin-top:20px;margin-bottom:10px}
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
    </style>
</head>
<body>
<div class="back"><button class="button back" onclick="history.back();">뒤로가기</button></div>
<div>
    <form name="findIdFrm" method="post" action="findresult.jsp" >
        <div class="logintitle">아이디 찾기</div>
        <div class="lgnbox">
            <div class="id_pw_wrap">
                <div class="input_row" id="id_line">
                    <input type="text" name="email" placeholder="메일주소" class="input_text" required>
                </div>
                <div class="input_row" id="pw_line">
                    <input type="text" name="name" placeholder="이름" class="input_text" required>
                </div>
            </div>
        </div>
        <div class="btn">
            <input class="button long"  type="submit" value="아이디 찾기"">
        </div>
    </form>

    <form name="findPwdFrm" method="post" action="findPwdProc.jsp">
        <div class="logintitle">비밀번호 찾기</div>
        <div class="lgnbox">
            <div class="id_pw_wrap">
                <div class="input_row" id="id_line">
                    <input type="text" name="phone" placeholder="핸드폰번호" class="input_text" required>
                </div>
                <div class="input_row" id="pw_line">
                    <input type="text" name="id" placeholder="아이디" class="input_text" required>
                </div>
            </div>
        </div>
        <div class="btn">
            <input class="button long" type="submit" value="비밀번호 찾기"">
        </div>
    </form>
</div>



</body>
</html>