<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<table class="table">
    <thead>
        <tr>
            <th scope="col">Mã lớp</th>
            <th scope="col">Tên lớp</th>
            <th scope="col">Mã khoa</th>
            <th scope="col">Thao tác</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="l" items="${lops}">
            <tr>
                <td>${l.MALOP}</td>
                <td>${l.TENLOP}</td>
                <td>${l.MAKH}</td>
                <td>
                    <a href="department-class/delete-class/${l.MALOP.trim()}.htm" onclick="return confirm('Bạn có chắc muốn xóa lớp ${l.MALOP}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
                    
                    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-class-${l.MALOP.trim()}">
						<i class="bi bi-pencil-square"></i>
					</button>
					<div class="modal fade" id="edit-class-${l.MALOP.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<form method="POST" action="department-class/edit-class.htm" class="form-control">
									<div class="mb-3">
                                        <label>Mã lớp: </label>
                                        <input name="malop" value="${l.MALOP}" class="form-control" disabled />
                                        <input type="hidden" name="malop" value="${l.MALOP}" />
                                    </div>
                                    <div class="mb-3">
                                        <label>Tên lớp: </label>
                                        <input name="tenlop" value="${l.TENLOP}" class="form-control" />
                                    </div>
                                    <select class="form-select" id="khoa" name="makh" disabled>
										<option value="${l.MAKH}">${l.MAKH}</option>
									</select>
									<button class="btn btn-primary mt-2" type="submit">Save</button>
								</form>
							</div>
						</div>
					</div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>