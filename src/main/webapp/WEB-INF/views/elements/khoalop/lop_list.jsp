<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<table class="table">
    <thead>
        <tr>
            <th scope="col">Mã lớp</th>
            <th scope="col">Tên lớp</th>
            <th scope="col">Khoa</th>
            <c:if test="${role_al != 'TRUONG'}"><th scope="col">Thao tác</th></c:if>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="l" items="${lops}">
            <tr>
                <td>${l.MALOP}</td>
                <td>${l.TENLOP}</td>
                <td>${khoaMap.get(l.MAKH)}</td>
                <c:if test="${role_al != 'TRUONG'}">
                    <td>
                        <form class="d-inline" action="department-class/delete-class/${l.MALOP.trim()}.htm" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa lớp ${l.TENLOP}?')" target="formSubmitFrame">
                            <button type="submit" class="btn btn-outline-primary" data-bs-dismiss="modal"><i class="bi bi-trash3-fill"></i></button>
                        </form>
    
                        <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-class-${l.MALOP.trim()}">
                            <i class="bi bi-pencil-square"></i>
                        </button>
                        <div class="modal fade" id="edit-class-${l.MALOP.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form id="editClassForm" method="POST" action="department-class/edit-class.htm" class="form-control" target="formSubmitFrame">
                                        <div class="mb-3">
                                            <label>Mã lớp: </label>
                                            <input name="malop" value="${l.MALOP}" class="form-control" disabled />
                                            <input type="hidden" name="malop" value="${l.MALOP}" />
                                        </div>
                                        <div class="mb-3">
                                            <label>Tên lớp: </label>
                                            <input name="tenlop" value="${l.TENLOP}" class="form-control" />
                                        </div>
                                        <div class="mb-3">
                                            <label>Khoa</label>
                                            <select class="form-select" id="khoa" name="makh" disabled>
                                                <option value="${l.MAKH}">${l.MAKH} (${khoaMap.get(l.MAKH)})</option>
                                            </select>
                                        </div>
                                        <button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal">Save</button>
                                        <button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
    </tbody>
</table>
<c:if test="${empty lops}"><h5>Không có lớp nào!</h5></c:if>
