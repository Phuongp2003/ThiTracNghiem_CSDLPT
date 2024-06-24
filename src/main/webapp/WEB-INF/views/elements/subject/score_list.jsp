<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<table class="table-score table">
    <thead>
        <tr>
            <th scope="col">MASV</th>
            <th scope="col">HỌ TÊN</th>
            <th scope="col">ĐIỂM</th>
            <th scope="col">ĐIỂM CHỮ</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="b" items="bangdiems">
            <tr>
                <td>${b.MASV}</td>
                <td>${b.HOTEN}</td>
                <td>${b.DIEM}</td>
                <td></td>
            </tr>
        </c:forEach>
    </tbody>
</table>