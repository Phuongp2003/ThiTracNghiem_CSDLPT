<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
	<jsp:include page="${initParam.viewsPath}/path.jsp" />
	
	<head>
		<jsp:include page="${viewsPath}/partial/head.jsp" />
	</head>
	
	<body>
		<jsp:include page="${elements}/navbar.jsp" />
		Hello web
		Account ${account.USERNAME} with id ${account.ID} and password ${account.PASSWORD}
	</body>
	
	<jsp:include page="${partial}/footer.jsp" />
	
</html>
