
//상품 등록 페이지로 이동
function productAdd(){
	let left=(window.screen.width-450)/2;
	let top=(window.screen.height-500)/2;
	window.open("productAdd.jsp","productAddWindow", "width=450, height=500, left="+left+", top="+top+",resizable = no, scrollbars = no");
}

//상품 등록
function proAdd(){
	let pname=0;
	let pcost=0;
	let pprice=0;
	let pthumb=0;
	let pstock=0;
	
	
	numchk=/^[0-9]+$/;
	if(productinsert.name.value=="" || productinsert.name.value==null){
        alert("상품명을 입력해 주세요");
        return;
    }else{
		pname=1;
	}
	/*원가 숫자만*/
	if(productinsert.cost.value=="" || productinsert.cost.value==null){
        alert("원가를 입력해 주세요");
        return;
    }else{
		if(numchk.test(productinsert.cost.value)){
			pcost=1;
		}else{
	        alert("원가는 숫자만 입력해 주세요");
			return;
		}
	}
	/*소비자가 숫자만*/
	if(productinsert.price.value=="" || productinsert.price.value==null){
        alert("원가를 입력해 주세요");
        return;
    }else{
		if(numchk.test(productinsert.price.value)){
			pprice=1;
		}else{
	        alert("소비자가는 숫자만 입력해 주세요");
			return;
		}
	}
	//썸네일 확인
	if(productinsert.thumb.value=="" || productinsert.thumb.value==null){
        alert("썸네일을 등록해 주세요");
        return;
    }else{
		pthumb=1;
	}
	/*재고수량 숫자만*/
	if(productinsert.stock.value=="" || productinsert.stock.value==null){
        alert("재고수량을 입력해 주세요");
        return;
    }else{
		if(numchk.test(productinsert.stock.value)){
			pstock=1;
		}else{
	        alert("재고는 숫자만 입력해 주세요");
			return;
		}
	}
	
	if(pname==1 && pcost==1 && pprice==1 && pthumb==1 && pstock==1){
		
		//$("#addFrm").attr("action","ProductInsert.post");
		productinsert.submit();
		
	}
}


$(function(){
	$("#price").focusout(function(){
		let pvalue=$('#price').val();
		$("#sale").attr("value",pvalue);
	});
});

function toCategory(){
	let top=(window.screen.height-500)/2;
	let left=(window.screen.width-450)/2;
	
	window.open("categoryMng.jsp","category", "width=450, height=500, left="+left+", top="+top+",resizable = no, scrollbars = no");
}
function mainProduct(){
	let top=(window.screen.height-500)/2;
	let left=(window.screen.width-450)/2;
	
	window.open("mainProductMng.jsp","mainProduct", "width=450, height=500, left="+left+", top="+top+",resizable = no, scrollbars = no");
}

$(function(){
	$("#allchk").click(function(){
		if($(this).is(":checked")){
			$(".check").prop("checked", true);
		}else{
			$(".check").prop("checked", false);
		}
	});
});




function productUpdate(){
	let chkArray = new Array(); // 배열 선언
	 
    $('input:checkbox[name=chk]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
        chkArray.push(this.value);
    });
	for(let i=0;i<chkArray.length;i++){
		let cnum=chkArray[i];
		let top=(window.screen.height-500)/2+i*30;
		let left=(window.screen.width-450)/2+i*30;
		window.open("productUpdate.jsp?cnum="+cnum,cnum, "width=450, height=500, left="+left+", top="+top+",resizable = no, scrollbars = no");
	}
}
	
function productDelete(){
	
	let chkArray = new Array(); // 배열 선언
 
    $('input:checkbox[name=chk]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
        chkArray.push(this.id);
	});
	if(chkArray.length==0){
		alert("삭제할 상품을 선택하세요");
		return;
	}else{
		if(confirm(chkArray+"상품을 삭제하시겠습니까?")){
			$("#mgnFrm").attr("action","productDelete.jsp");
			mgnFrm.submit();
		}else{
			return;
		}
	}
}

function changuse(){
	$("#mgnFrm").attr("action","prodyn.jsp");
	mgnFrm.submit();
}

function addsubmit(){
	if(categoryadd.catname.value==null || categoryadd.catname.value==""){
		alert("추가할 카테고리 명을 입력해주세요.")
		return;
	}else{
		categoryadd.submit();
	}
};

function updateCate(){
	$("#updatetype").attr("value",'1');
	categoryupdate.submit();
	
}
/*삭제하기 클릭*/
function deletCate(){
	$("#updatetype").attr("value",'2');
	categoryupdate.submit();
	
}
