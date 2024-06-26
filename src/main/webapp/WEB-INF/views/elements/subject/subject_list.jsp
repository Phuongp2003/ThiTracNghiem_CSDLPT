<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<table class="table">
    <thead>
        <tr>
            <th scope="col">Mã môn học</th>
            <th scope="col">Tên môn học</th>
            <c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}"><th scope="col">Thao tác</th></c:if>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="s" items="${monHocs}">
            <tr>
                <td>${s.MAMH}</td>
                <td>${s.TENMH}</td>
                <c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}">
                    <td>
                        <form class="d-inline" action="subject/delete-subject/${s.MAMH.trim()}.htm" method="post">
                            <button type="button" onclick="if (confirm('Bạn có chắc muốn xóa môn ${s.TENMH}?')) submitClosestForm(this, () => refreshData())" class="btn btn-outline-primary" data-bs-dismiss="modal"><i class="bi bi-trash3-fill"></i></button>
                        </form>
    
                        <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-subject-${s.MAMH.trim()}">
                            <i class="bi bi-pencil-square"></i>
                        </button>
                        <div class="modal fade" id="edit-subject-${s.MAMH.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form method="POST" action="subject/edit-subject.htm" class="form-control">
                                        <div class="mb-3">
                                            <label>Mã môn học: </label>
                                            <input name="mamh" value="${s.MAMH}" class="form-control" disabled />
                                            <input type="hidden" name="mamh" value="${s.MAMH}" />
                                        </div>
                                        <div class="mb-3">
                                            <label>Tên môn học: </label>
                                            <input name="tenmh" value="${s.TENMH}" class="form-control" />
                                        </div>
                                        <button class="btn btn-primary mt-2" type="button" onclick="submitClosestForm(this, () => refreshData())" data-bs-dismiss="modal">Save</button>
                                        <button class="btn btn-secondary mt-2" type="button" data-bs-dismiss="modal">Close</button>
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
