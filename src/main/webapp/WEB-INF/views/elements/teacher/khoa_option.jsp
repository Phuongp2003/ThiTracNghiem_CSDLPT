<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<c:forEach var="k" items="${khoas}">
	<option value="${k.MAKH}" ${(k.MAKH==current ? 'selected' : '' )}>
		${k.getFullName()}
	</option>
</c:forEach>
