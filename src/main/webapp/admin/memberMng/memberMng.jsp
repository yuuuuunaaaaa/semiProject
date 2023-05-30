<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="aMgr" class="admin.member.AdminMemberMgr" />    
<%@ page import="java.util.*,member.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 조회</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script src="../../resource/js/product.js?v=<%=System.currentTimeMillis() %>"></script>
    <link rel="shortcut icon" href="../../resource/img/puppy.png">
	<link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String name=(String)session.getAttribute("nameKey");
	String id=(String)session.getAttribute("idKey");
	if(id==null){id="";}
	if(name==null){name="";}
%>
<jsp:include page="../../header.jsp">
	<jsp:param value="<%=name %>" name="name"/>
	<jsp:param value="<%=id %>" name="id"/>
	<jsp:param value="../../" name="path"/>
</jsp:include>

   	<div class="admTable">
       	<div class="topbtn">
				<input type="button" value="회원정보 수정" class="admbtn" onclick="updateMem();" title="회원 한 명을 수정할 수 있는 창이 생성됩니다.">
				<input type="button" value="회원정보 삭제" class="admbtn" onclick="deleteMem();">
				<input type="button" value="회원 탈퇴 전환" class="admbtn" onclick="ynMem();" title="탈퇴 여부를 전환할 회원들을 선택하고 버튼을 클릭하세요">
				<input type="button" onclick="location.href='../AdminMain.jsp'" value="뒤로가기" class="admbtn">
    	</div>
		<table>
			<tr>
				<th><input type="checkbox" id="allchk"></th>
				<th>no</th>
				<th>회원 아이디</th>
				<th>비밀번호</th>
				<th>회원 이름</th>
				<th>회원 전화번호</th>
				<th>회원 이메일</th>
				<th>회원 우편번호</th>
				<th>회원 주소</th>
				<th>회원 상세주소</th>
				<th>회원 가입일</th>
				<th>회원 탈퇴일</th>
				<th>회원 탈퇴여부</th>
				<th>포인트</th>
			</tr>
			<form method="post" name="memMngFrm" id="memMngFrm" action="">
		<%
			ArrayList<PMemberBean> alist=new ArrayList<>();
			alist=aMgr.getAllMember();
			for(int i=0;i<alist.size();i++){
				PMemberBean pBean=alist.get(i);
				String yn="";
				if(pBean.getUseyn()==1){
					yn="회원";
				}else{
					yn="탈퇴";
				}
				String enddate=pBean.getEnddate();
				if(enddate==null){
					enddate="-";
				}
			%>
				<tr>
					<td><input type="checkbox" class="check" value="<%=pBean.getId() %>" name="chk"></td>
					<td><%=i+1 %></td>
					<td><%=pBean.getId() %></td>
					<td><input type="password" value="<%=pBean.getPwd() %>" disabled class="pwd"></td>
					<td><%=pBean.getName() %></td>
					<td><%=pBean.getPhone() %></td>
					<td><%=pBean.getEmail() %></td>
					<td><%=pBean.getZipcode() %></td>
					<td><%=pBean.getAddress() %></td>
					<td><%=pBean.getAddrdetail() %></td>
					<td><%=pBean.getRegdate() %></td>
					<td><%=enddate %></td>
					<td><%=yn %></td>
					<td><%=pBean.getPoint() %></td>
				</tr>	
			<%
			}
		%>
			</form>
		</table>
	</div>
<%@include file="../../Footer.jsp" %>
	<script>
	$(function(){
		$("#allchk").click(function(){
			if($(this).is(":checked")){
				$(".check").prop("checked", true);
			}else{
				$(".check").prop("checked", false);
			}
		});
	});
	function deleteMem(){
	
		let chkArray = new Array(); // 배열 선언
		let flag=true;
		 
	    $('input:checkbox[name=chk]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
	        chkArray.push($(this).attr('value'));
	    	if(flag){
		    	if(chkArray.includes('admin')){
		    		alert('관리자 계정은 삭제할 수 없습니다.');
		    		flag=false;
		    		return;
		    	}
	    	}
		});
	    
		if(flag){
			if(confirm(chkArray+"회원정보를 삭제하시겠습니까?")){
				$("#memMngFrm").attr("action","memberDelete.jsp");
				memMngFrm.submit();
			}
		}
	}
	
	function ynMem(){
		let chkArray = new Array(); // 배열 선언
		let flag=true;
		 
	    $('input:checkbox[name=chk]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
	        chkArray.push($(this).attr('value'));
	    	if(flag){
		    	if(chkArray.includes('admin')){
		    		alert('관리자 계정은 탈퇴처리할 수 없습니다.');
		    		flag=false;
		    		return;
		    	}
	    	}
		});
	    
		if(flag){
			$("#memMngFrm").attr("action","ynUpdateMember.jsp");
			memMngFrm.submit();
		}
	}
	
	function updateMem(){
		let chkArray = new Array(); // 배열 선언
		 
	    $('input:checkbox[name=chk]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
	        chkArray.push(this.value);
	    });
		if(chkArray.length==1){
			let id=chkArray[0];
			let top=(window.screen.height-500)/2;
			let left=(window.screen.width-450)/2;
			window.open("memberUpdate.jsp?id="+id,"productUpdate", "width=450, height=500, left="+left+", top="+top+",resizable = no, scrollbars = no");
		}else{
			alert("수정할 회원을 한 명만 선택하세요");
			return;
		}
	}
	</script>
</body>
</html>