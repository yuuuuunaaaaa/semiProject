<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,admin.product.*,member.*" %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<meta charset="UTF-8">
	<jsp:useBean id="mMgr" class="member.PMemberMgr"/>
	<title>회원 수정</title>
	<link rel="stylesheet" href="../../resource/css/admin.css?v=<%=System.currentTimeMillis() %>">
	<script src="../../resource/js/product.js?v=<%=System.currentTimeMillis() %>"></script>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String id=request.getParameter("id");
	
	PMemberBean mBean=mMgr.getMember(id);
	String enddate=mBean.getEnddate();
	if(enddate==null){
		enddate="-";
	}
	String orginId=id;
%>
</head>
<body>
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
	<form method="post" name="memberupdate" action="MemberUpdate.post">
	<input type="hidden" name="originId" value="<%=orginId %>">
	<table>
		<tr>
			<td>아이디: </td>
			<td>
				<input type="text" name="id" value="<%=mBean.getId() %>" class="read" id="id">
			</td>
		</tr>
		<tr>
			<td>비밀번호: </td>
			<td>
				<input type="text" name="pwd" value="<%=mBean.getPwd() %>">
			</td>
		</tr>
		<tr>
			<td>이름: </td>
			<td>
				<input type="text" name="name" value="<%=mBean.getName() %>" class="read">
			</td>
		</tr>
		<tr>
			<td>핸드폰번호: </td>
			<td>
				<input type="text" name="phone" id="phone" value="<%=mBean.getPhone() %>">
			</td>
		</tr>
		<tr>
			<td>우편번호: </td>
			<td>
		        <input name="zipcode" id="postcode" value="<%=mBean.getZipcode() %>" readonly>
		        <input class="button zcdbtn" width="200px" type="button" value="우편번호 찾기" onclick="findAddr();">
		    </td>
		</tr>
		<tr>
		    <td>주소: </td>
		    <td>
		    	<input name="address" id="addr" size="40"  value="<%=mBean.getAddress() %>" readonly>
		    </td>
		</tr>
		<tr>
			<td>상세주소: </td>
			<td>
				<input type="text" name="addrdetail" id="addrdetail" value="<%=mBean.getAddrdetail() %>">
			</td>
		</tr>
		<tr>
			<td>가입일: </td>
			<td>
				<input type="text" name="regdate" readonly value="<%=mBean.getRegdate() %>"  class="read">
			</td>
		</tr>
		<tr>
			<td>탈퇴일: </td>
			<td>
				<input type="text" name="enddate" readonly value="<%=enddate %>"  class="read">
			</td>
		</tr>
		<tr>
			<td>탈퇴여부: </td>
			<td>
				<select name="useyn" class="read">
					<option value="1" id="1">회원</option>
					<option value="2" id="2">탈퇴회원</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>포인트: </td>
			<td>
				<input type="text" name="point" value="<%=mBean.getPoint() %>">
			</td>
		</tr>
	</table> 
				<input type="submit" value="회원 정보 수정">
	</form>
		<script>
		$(function(){
			$("#<%=mBean.getUseyn() %>").attr("selected",true);
		})
		$(function(){
			const idatt=$("#id").attr("value");
			if(idatt=="admin"){
				$(".read").attr("readonly",true)
			}
		})
	</script>
</body>
</html>