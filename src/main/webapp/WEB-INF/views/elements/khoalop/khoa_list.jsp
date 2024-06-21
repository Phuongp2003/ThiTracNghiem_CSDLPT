<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<table class="table">
    <thead>
        <tr>
            <th scope="col">Mã khoa</th>
            <th scope="col">Tên khoa</th>
            <th scope="col">Mã cơ sở</th>
            <th scope="col">Thao tác</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="k" items="${khoas}">
            <tr class="is-action sl-${k.MAKH}" onclick="toggleAndLoad('${k.MAKH}')">
                <td>${k.MAKH}</td>
                <td>${k.TENKH}</td>
                <td>${k.MACS}</td>
                <td>
                    <form class="d-inline" action="department-class/delete-department/${k.MAKH.trim()}.htm" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa khoa ${k.MAKH}?')" target="formSubmitFrame">
                        <button type="submit" class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button>
                    </form>

                    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-department-${k.MAKH.trim()}">
                        <i class="bi bi-pencil-square"></i>
                    </button>
                    <div class="modal fade" id="edit-department-${k.MAKH.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form method="POST" action="department-class/edit-department.htm" class="form-control" target="formSubmitFrame">
                                    <div class="mb-3">
                                        <label>Mã khoa: </label>
                                        <input name="makh" value="${k.MAKH}" class="form-control" disabled />
                                        <input type="hidden" name="makh" value="${k.MAKH}" />
                                    </div>
                                    <div class="mb-3">
                                        <label>Tên khoa: </label>
                                        <input name="tenkh" value="${k.TENKH}" class="form-control" />
                                    </div>
                                    <button class="btn btn-primary mt-2" type="submit">Save</button>
                                    <button class="btn btn-secondary mt-2" type="submit" data-bs-dismiss="modal">Close</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>