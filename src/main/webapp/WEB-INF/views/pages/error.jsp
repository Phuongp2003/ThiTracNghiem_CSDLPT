<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<jsp:include page="${initParam.viewsPath}/path.jsp" />
	
	<head>
		<jsp:include page="${partial}/head.jsp" />
	</head>
	
	<body>
		<jsp:include page="${elements}/navbar.jsp" />
		<style>
			.message {
				width: 100%;
				height: 300px;
				border: 1px solid red;
				color: red;
			}
		</style>
		
		<div class="message">
			ERROR: No page found!
			Redirect to <a href="">Home</a> in 5 seconds!
		</div>
	</body>
	
	<jsp:include page="${partial}/footer.jsp" />
	
	<script>
		setTimeout(function() {
			window.location.href = ``;
		}, 500000);
	</script>
	
</html>
