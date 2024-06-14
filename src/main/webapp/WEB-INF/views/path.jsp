<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="viewsPath" value="${initParam.viewsPath}" scope="application" />
<c:set var="elements" value="${initParam.viewsPath}/elements" scope="application" />
<c:set var="partial" value="${initParam.viewsPath}/partial" scope="application" />
<c:set var="pages" value="${initParam.viewsPath}/pages" scope="application" />
<c:set var="basePath" value="${pageContext.request.contextPath}" scope="application" />
