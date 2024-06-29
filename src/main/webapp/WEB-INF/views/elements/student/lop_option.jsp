<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<option value="all" ${malop=="all" ? 'selected' : '' }>Lớp: Tất cả</option>
<c:forEach var="l" items="${lops}">
    <option value="${l.MALOP}" ${l.MALOP==malop ? 'selected' : '' }>
        ${l.MALOP} (${l.TENLOP})</option>
</c:forEach>