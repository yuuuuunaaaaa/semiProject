<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
	<style>
		body {
			margin: 0;
		}
		img:hover {cursor:pointer;}
		
		.wrapper {
			display: flex;
			justify-content: center;
			align-items: center;
			min-height: 100vh;
		}
		.item {
			width:200px;
		}
	</style>
</head>
<body>
	<div class="wrapper">
		<img class="item" alt="" src="resource/img/door.jpg">
	</div>
	<script>
	
	$(function(){
	    $(".item").click(function(){
		    $(".item").fadeOut(1000);
			setTimeout(function() {
		        location.href = 'main.jsp';
		    }, 1050);
			
	    });
	})
	
	</script>
</body>
</html>