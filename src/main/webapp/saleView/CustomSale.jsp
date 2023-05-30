<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,admin.product.*,member.*,personal.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	request.setCharacterEncoding("UTF-8");
	String tmp=request.getParameter("pronum");
	if(tmp==null){tmp="1";}
	int pronum=Integer.parseInt(tmp);
	ProductBean pBean=new ProductMgr().getProduct(pronum);
	String proname=pBean.getProname();
	String thumb=pBean.getThumb();
	String img=pBean.getImg();
	String content=pBean.getContent();
	int stock=pBean.getStock();
	if(content==null){content="";}
	int price=pBean.getPrice();
	int sale=pBean.getSale();
	String category=new ProductMgr().getCategoryName(pBean.getCategory());
	int catenum=pBean.getCategory();
	String url="../resource/fileupload/";
	int point=(int)(sale*0.01);
	ArrayList<ReviewBean> alist=new PersonalMgr().getReviewBypronum(pronum);
%>
<title><%=proname %></title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="../resource/css/ProdDetailView.css?v=<%=System.currentTimeMillis() %>">
</head>
<body>
<%
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
<div class="body2">
	<div class="forCate">
		<a class="category" href='ViewAll.jsp?category=<%=catenum %>'><%=category %></a>
		<div class="prodhead">
			<div  class="sideleft"> <!-- 썸네일부분 -->
				<img alt="" src="<%=url %><%=thumb %>" class="thumb">
			</div>
			<form action="Orders.jsp" method="post" name="orderFirm">
				<div class="sideright"> <!-- 오른쪽 내용 -->
						<!-- 상단 제목이랑 가격 -->
					<div class="upper"> 
						<div class="title">
							<div class="proname"><%=proname %></div><input type="hidden" name="proname" value="<%=proname %>">  
							<div class="sale">
								<div><input type="hidden"  id="hidPrice" value="<%=price %>" name="price"></div>
								<div><input type="text" disabled class="price" id="originPrice" ></div>
								<div><input type="text" disabled class="disabled" id="titlePrice" ></div>
								<input type="hidden" name="sale" value="<%=sale %>" >
								<input type="hidden" name="pronum" value="<%=pronum %>" >
							</div>
						</div>
					</div>
						<!-- 배송 내용 부분 -->
					<hr>
					<div>
						<span>
							구매혜택: <%=point %> 포인트 적립<br><input type="hidden" name="point" value="<%=point %>">
							배송 방법: 택배<br>
							배송비: ₩3,000 <br>
						</span>
					</div>
					<hr>
					<div> <!-- 수량선택 -->
						<div class="qtt">수량
							<div class="qttcont">
								<button type="button" onclick="minus();">-</button>
								<input type="text" name="quantity" min="1" readonly value="1" id="qttnum">
								<button type="button" onclick="plus();">+</button>
							</div>
						</div>
						<div class="totalPrice">
							총 가격
							<div><input type="text" disabled class="disabled" id="priceView" ></div>
							<input type="hidden" class="disabled" id="tPrice" value="<%=sale %>" >
						</div>
					</div>
					<hr>
					<div class="paybtn"> <!-- 버튼 -->
						<input type="button" class="button long" value="장바구니 담기" onclick="goCart();">
						<input type="submit" class="button" value="즉시 구매">
					</div>
				</div>
				<input type="hidden" name="thumb" value="<%=thumb %>">
			</form>
		</div>
	</div>	
	<hr class="dhr">
	<div class="revTog">
		<div>
			<button type="button" class="revBtn button" onclick="showProd();">상품 상세설명</button>
		</div>
		<div>
			<button type="button" class="revBtn button" onclick="showReview();">리뷰 보기(<%=alist.size() %>)</button>
		</div>
	</div>
	<div class="prodbody">
		<div>
			<img alt="" src="<%=url %><%=img %>" class="img">
			<div><%=content %></div>
		</div>
	</div>
	<div class="review">
<%

	for(int i=0;i<alist.size();i++){
		ReviewBean rBean=alist.get(i);
		String revid=rBean.getId().substring(0,4)+"****";
		String revimg=rBean.getImg();
		if(revimg==null){
			revimg="<br>";
		}else{
			revimg="<img src='../resource/fileupload/"+rBean.getImg()+"' class='revImg'><br>";
		}
	%>
	<div class="revOutLine">
		<div class="revtitle">
			<div><%=rBean.getTitle() %></div>
			<div>
				<div class="Star<%=i %> Star">
					<span class="st0">★</span>
					<span class="st1">★</span>
					<span class="st2">★</span>
					<span class="st3">★</span>
					<span class="st4">★</span>
				</div>
				<div class="idNdate"><span><%=revid %></span><span><%=rBean.getRegdate() %></span></div>
			</div>
		</div>
		<div class="revcont">
			<%=revimg %>
			<%=rBean.getContent() %>
		</div>
	</div>
	<%
	}
%>	
	</div>
	
		
	</div>
</div>
<%@include file="../Footer.jsp" %>
</body>
<script>		
	$(function(){
		let price=$("#tPrice").attr("value").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		let orginprice=$("#hidPrice").attr("value").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		$("#titlePrice").attr("value",price);
		$("#priceView").attr("value",price);
		$("#originPrice").attr("value",orginprice);
		
		if(<%=sale %> == <%=price %>){
			$("#originPrice").css("visibility","hidden");
		}
	})
	function plus(){
		let qttnum=$("#qttnum").attr("value")*1;
		if($("#qttnum").attr("value")*1+1><%=stock %>){
			alert("최대 구매 가능 수량은 <%=stock%>개입니다.");
		}else{
			$("#qttnum").attr("value",qttnum+1);
			$("#tPrice").attr("value",
					$("#qttnum").attr("value")*<%=sale %>);
			let price=$("#tPrice").attr("value").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			
			$("#priceView").attr("value",price);
		}
		
		
	}
	function minus(){
		const qttnum=$("#qttnum").attr("value")*1;
		if(qttnum=='1'){
			return;
		}else{ 
			$("#qttnum").attr("value",qttnum-1);
			$("#tPrice").attr("value",
					$("#qttnum").attr("value")*<%=sale %>);
			
			let price=$("#tPrice").attr("value").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			
			$("#priceView").attr("value",price);
		 } 
	}
	function showProd(){
		$(".review").css("display","none");
		$(".prodbody").css("display","block");
	}
	function showReview(){
		$(".prodbody").css("display","none");
		$(".review").css("display","block");
	}
	function goCart(){
		let qtt=$("#qttnum").attr("value")*1;
		let pronum=<%=pronum %>;
		let id="<%=id %>";
		$.ajax ({
			url : "../cartSearch",
			data : { qtt : qtt, pronum : pronum, id :id},
			type:"post",
			success:function(result) {
				if(result){
					let confrm=confirm("카트에 이미 해당 상품이 담겨있습니다. 수량을 추가하시겠습니까?");
					if(confrm){
						location.href='../personal/CartProc.jsp?pronum='+pronum+"&qtt="+qtt+"&chk=1"
					}
				}else{
					location.href='../personal/CartProc.jsp?pronum='+pronum+"&qtt="+qtt+"&chk=0"
				}
				
			},
			error:function() {
				console.log("ajax통실 실패");
			}
		});
		
	}
	//별점
	$(function(){
		<%
		for(int i=0;i<alist.size();i++){
			int star=alist.get(i).getRate();
			for(int j=0;j<star;j++){
				%>
			$(".Star<%=i %> .st<%=j %>").css("color","#f4e41c");
				<%
			}
		}
		%>
	})
    $(function(){
        $(".revtitle").click(function(){
            const p1 = $(this).next();
            if(p1.css("display")=="none"){
                p1.slideDown();
            }else{
                p1.slideUp();
            }
        })
    })
</script>

<style>
	.long{
		width:140px;
	}
	input:disabled{
		backgound:none;
	}
	  .Star *{
    font-size: 1.5rem;
    color: #dddddd9c;
    height:35px;
    text-align:center
  }
  .Star{
  	display:flex;
  }

  .revtitle{
  	display:flex;
  	justify-content: space-between;
	align-items: center;
  	width:610px;
  	height:90px;
	padding:10px;
  }
  .revtitle:hover{
  	background-color:#dddddd75;
  }
  .idNdate{
  	width:180px;
  	display:flex;
  	justify-content: space-between;
	align-items: center;
  	
  }
  .revcont{
  	display:none;
  	padding:10px;
  }
  	.revImg{
	width:400px;
	margin:5px
	}
	.revOutLine{
		border:solid 1px #dad9d994;
		margin-bottom:1px
	}
</style>
</html>