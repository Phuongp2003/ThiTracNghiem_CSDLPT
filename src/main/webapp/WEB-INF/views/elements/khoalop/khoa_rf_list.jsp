<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<option value="all" ${makh=="all" ? 'selected' : '' }>Khoa: Tất cả</option>
<c:forEach var="k" items="${khoas}">
	<option value="${k.MAKH}" ${k.MAKH==makh ? 'selected' : '' }>${k.getFullName()}</option>
</c:forEach>
