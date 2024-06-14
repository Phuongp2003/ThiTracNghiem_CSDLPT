<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
	<jsp:include page="${initParam.viewsPath}/path.jsp" />
	
	<head>
		<jsp:include page="${viewsPath}/partial/head.jsp" />
	</head>
	<jsp:include page="${elements}/login/index.jsp" />
	<jsp:include page="${elements}/theme.jsp" />
	<jsp:include page="${partial}/script_al.jsp" />
	
</html>
