let pwdresult=true;
let pwdchresult=false;
let nameresult=true;
let emailresult=true;
let phoneresult=true;

//전화번호체크
function numberChk(){
	numchk=/^[0-9]+$/;
	if(memUpdateFrm.phone.value != ""){
		if(numchk.test(memUpdateFrm.phone.value)){
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

//비밀번호 체크
function pwdChk0(){
    pwdCfm = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*.])[a-zA-Z0-9!@#$%^&*.]{8,20}$/;
    
    if(memUpdateFrm.pwd.value != ""){
        if(pwdCfm.test(memUpdateFrm.pwd.value)){
            document.getElementById("pwdresult").innerHTML="비밀번호를 적어주세요.<br>(문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요)";
            document.getElementById("pwdresult").style.color="rgb(77, 77, 77)";
            pwdresult=true;
        }else{
            document.getElementById("pwdresult").innerHTML="문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요";
            document.getElementById("pwdresult").style.color="red";
            pwdresult=false;
        }
    }else{
        document.getElementById("pwdresult").innerHTML="비밀번호를 적어주세요.<br>(문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요)";
        document.getElementById("pwdresult").style.color="rgb(77, 77, 77)";
    }  
}



//비밀번호 확인 실시간으로
function pwdChk(){
   if(memUpdateFrm.repwd.value != ""){
        if(memUpdateFrm.pwd.value == memUpdateFrm.repwd.value){
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
    
    if(memUpdateFrm.name.value != ""){
        if(nameCfm.test(memUpdateFrm.name.value)){
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



function updateCheck(){
    if(memUpdateFrm.pwd.value==""){
        alert("비밀번호를 입력해 주세요");
        memUpdateFrm.pwd.focus();
        return;
    }
    if(memUpdateFrm.repwd.value==""){
        alert("비밀번호를 다시 한 번 입력해 주세요");
        memUpdateFrm.repwd.focus();
        return;
    }
    if(memUpdateFrm.name.value==""){
        alert("이름을 입력해 주세요");
        memUpdateFrm.name.focus();
        return;
    }
    if(memUpdateFrm.phone.value == ""){
        alert("전화번호를 입력해 주세요");
        memUpdateFrm.phone1.focus();
        return;
	}
    if(pwdresult && pwdchresult &&nameresult && emailresult && phoneresult){
        memUpdateFrm.submit();
	}else{
		if(!pwdresult){
			document.getElementById("pwdresult").innerHTML="비밀번호를 적어주세요.<br>(문자, 숫자, 특수기호를 반드시 한개 이상 넣으세요)";
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