let idresult=false;
let pwdresult=false;
let pwdchresult=false;
let nameresult=false;
let emailresult=false;
let phoneresult=false;

function idCheck(id){
    regFrm.idbtncheck.value = "idCheck";
    if(id == ""){
        alert("아이디를 입력해 주세요")
        regFrm.id.focus();
        return;
    }
    url="idCheck.jsp?id="+id; //파일명?넘겨줄파라미터이름=파라미터값 띄어쓰기(공백) 하나라도 들어가면 안됨!!!!!
    window.open(url, "IDCheck","width=300, height=150"); //window.open(주소, 창이름,크기);
}
function inputIdChk(){
    regFrm.idbtncheck.value = "idUncheck";

    idCfm = /^[a-z0-9]+$/;
    // /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*.])[a-zA-Z0-9!@#$%^&*.]{8,}$/;
    if(regFrm.id.value != ""){
        if(idCfm.test(regFrm.id.value) && regFrm.id.value.length<=20){
            document.getElementById("idresult").innerHTML="아이디를 적어주세요.(20자 이내로 영어, 숫자만)";
            document.getElementById("idresult").style.color="rgb(77, 77, 77)";
            idresult=true;
        }else{
            document.getElementById("idresult").innerHTML="20자 이내로 영어, 숫자만";
            document.getElementById("idresult").style.color="red";
            idresult=false;
        }
    }else{
        document.getElementById("idresult").innerHTML="아이디를 적어주세요.(20자 이내로 영어, 숫자만)";
        document.getElementById("idresult").style.color="red";
    }
}
//전화번호체크
function numberChk(){
	numchk=/^[0-9]+$/;
	if(regFrm.phone.value != ""){
		if(numchk.test(regFrm.phone.value)){
			document.getElementById("phoneresult").innerHTML="숫자만 입력하세요";
	        document.getElementById("phoneresult").style.color="rgb(77, 77, 77)";
	        phoneresult=true;
		}else{
			document.getElementById("phoneresult").innerHTML="숫자만 입력하세요";
	        document.getElementById("phoneresult").style.color="red";
	        phoneresult=false;
		}
	}else{
		document.getElementById("phoneresult").innerHTML="전화번호를 입력하세요";
        document.getElementById("phoneresult").style.color="red";
        phoneresult=false;
	}
}

function inputCheck(){
    if(regFrm.id.value==""){
        alert("아이디를 입력해 주세요");
        regFrm.id.focus();
        return;
    }
    if(regFrm.idbtncheck.value != "idCheck"){
        alert("아이디 중복체크를 해주세요");
        return;
    }
    if(regFrm.pwd.value==""){
        alert("비밀번호를 입력해 주세요");
        regFrm.pwd.focus();
        return;
    }
    if(regFrm.repwd.value==""){
        alert("비밀번호를 다시 한 번 입력해 주세요");
        regFrm.repwd.focus();
        return;
    }
    if(regFrm.name.value==""){
        alert("이름을 입력해 주세요");
        regFrm.name.focus();
        return;
    }
    if(regFrm.phone.value == ""){
        alert("전화번호를 입력해 주세요");
        regFrm.phone1.focus();
        return;
	}
    if(idresult && pwdresult && pwdchresult &&nameresult && emailresult && phoneresult){
        regFrm.submit();
	}else{
		if(!idresult){
	        document.getElementById("idresult").innerHTML="아이디를 적어주세요.(20자 이내로 영어, 숫자만)";
	        document.getElementById("idresult").style.color="red";
		}
		if(!pwdresult){
			document.getElementById("pwdresult").innerHTML="비밀번호를 적어주세요.(문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요)";
        	document.getElementById("pwdresult").style.color="red";
		}
		if(!pwdchresult){
			document.getElementById("pwdchk").innerHTML="위에 입력한 비밀번호와 동일한 비밀번호를 입력하세요";
        	document.getElementById("pwdchk").style.color="red";
		}
		if(!nameresult){
			document.getElementById("nameresult").innerHTML="한글로 입력하세요";
        	document.getElementById("nameresult").style.color="red";
		}
		if(!emailresult){
			document.getElementById("emailchk").innerHTML="이메일을 입력해주세요";
        	document.getElementById("nameresult").style.color="red";
		}
		if(!phoneresult){
			document.getElementById("phoneresult").innerHTML="전화번호를 입력하세요";
        	document.getElementById("phoneresult").style.color="red";
		}
		
        return;
    }
};

//비밀번호 체크
function pwdChk0(){
    pwdCfm = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*.])[a-zA-Z0-9!@#$%^&*.]{8,20}$/;
    
    if(regFrm.pwd.value != ""){
        if(pwdCfm.test(regFrm.pwd.value)){
            document.getElementById("pwdresult").innerHTML="비밀번호를 적어주세요.(문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요)";
            document.getElementById("pwdresult").style.color="rgb(77, 77, 77)";
            pwdresult=true;
        }else{
            document.getElementById("pwdresult").innerHTML="문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요";
            document.getElementById("pwdresult").style.color="red";
            pwdresult=false;
        }
    }else{
        document.getElementById("pwdresult").innerHTML="비밀번호를 적어주세요.(문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요)";
        document.getElementById("pwdresult").style.color="rgb(77, 77, 77)";
    }  
}



//비밀번호 확인 실시간으로
function pwdChk(){
   if(regFrm.repwd.value != ""){
        if(regFrm.pwd.value == regFrm.repwd.value){
            document.getElementById("pwdchk").innerHTML="비밀번호 확인이 완료되었습니다.";
            document.getElementById("pwdchk").style.color="blue";
            pwdchresult=true;
        }else{
            document.getElementById("pwdchk").innerHTML="비밀번호가 일치하지 않습니다.";
            document.getElementById("pwdchk").style.color="red";
            pwdchresult=false;
        }
    }else{
        document.getElementById("pwdchk").innerHTML="위에 입력한 비밀번호와 동일한 비밀번호를 입력하세요";
        document.getElementById("pwdchk").style.color="rgb(77, 77, 77)";
    } 
}

//이름 체크
function nameChk(){
    nameCfm = /^[ㄱ-ㅎㅏ-ㅣ가-힣]+$/;
    
    if(regFrm.name.value != ""){
        if(nameCfm.test(regFrm.name.value)){
            document.getElementById("nameresult").innerHTML="한글로 입력하세요";
            document.getElementById("nameresult").style.color="rgb(77, 77, 77)";
            nameresult=true;
        }else{
            document.getElementById("nameresult").innerHTML="한글만 입력하세요";
            document.getElementById("nameresult").style.color="red";
            nameresult=false;
        }
    }else{
        document.getElementById("nameresult").innerHTML="한글로 입력하세요";
        document.getElementById("nameresult").style.color="rgb(77, 77, 77)";
    }  
}

//이메일체크
$(function(){
    $("#email").focusout(function(){
        if($("#email").val()==""){
            emailresult=false;
            $("#emailchk").text("이메일을 입력해주세요.");
            $("#emailchk").css("color","red");
        }else{
            $("#emailchk").text("x) email@example.com");
            $("#emailchk").css("color","rgb(77, 77, 77)");
            emailresult=true;
        }
    });
    $("#sub").click(function(){
        if($("#email").val()==""){
            emailresult=false;
            $("#emailchk").text("이메일을 입력해주세요.");
            $("#emailchk").css("color","red");
        }else{
            $("#emailchk").text("ex) email@example.com");
            $("#emailchk").css("color","rgb(77, 77, 77)");
            emailresult=true;
        }
    });
});

$(function(){
    $("#openeye").click(function(){
        if($("#pwd").attr("type")=="password"){
            $("#pwd").attr("type","text");
            $(".pwview").css("display","none");
            $(".pwhide").css("display","inline");
            
        }else{
            $("#pwd").attr("type","password");
            $(".pwhide").css("display","none");
            $(".pwview").css("display","inline");
        }
    });
});

