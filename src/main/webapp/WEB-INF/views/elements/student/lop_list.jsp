<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<table class="table lop-table">
    <thead>
        <tr>
            <th scope="col">Mã lớp</th>
            <th scope="col">Tên lớp</th>
            <th scope="col">Khoa</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="l" items="${lops}">
            <tr class="is-action sl-${l.MALOP}" onclick="toggleAndLoad('${l.MALOP}')">
                <td>${l.MALOP}</td>
                <td>${l.TENLOP}</td>
                <td>${khoaMap.get(l.MAKH)}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>