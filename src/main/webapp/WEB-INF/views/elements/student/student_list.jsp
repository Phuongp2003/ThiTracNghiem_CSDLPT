<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>


<table class="table sinhvien-table">
	<thead>
		<tr>
			<th scope="col">Mã SV</th>
			<th scope="col">Họ</th>
			<th scope="col">Tên</th>
			<th scope="col">Ngày sinh</th>
			<th scope="col">Địa chỉ</th>
			<th scope="col">Mã lớp</th>
			<th scope="col">Mật khẩu</th>
			<th scope="col">Thao tác</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="sv" items="${sinhViens}">
			<tr>
				<td>${sv.MASV}</td>
				<td>${sv.HO}</td>
				<td>${sv.TEN}</td>
				<td>${sv.NGAYSINH}</td>
				<td>${sv.DIACHI}</td>
				<td>${sv.MALOP}</td>
				<td>${sv.MATKHAU}</td>
				<td>
					<form class="d-inline" action="student/delete-student/${sv.MASV.trim()}.htm" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa sinh viên ${sv.MASV}?')" target="formSubmitFrame">
						<button type="submit" class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button>
					</form>
					
					<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-student-${sv.MASV.trim()}">
						<i class="bi bi-pencil-square"></i>
					</button>
					<div class="modal fade" id="edit-student-${sv.MASV.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<form method="POST" action="student/edit-student.htm" class="form-control" target="formSubmitFrame">
									<div class="mb-3">
										<label>Mã sinh viên: </label>
										<input name="masv" value="${sv.MASV}" class="form-control" disabled />
										<input type="hidden" name="masv" value="${sv.MASV}" />
									</div>
									<div class="mb-3">
										<label>Họ: </label>
										<input name="ho" value="${sv.HO}" class="form-control" />
									</div>
									<div class="mb-3">
										<label>Tên: </label>
										<input name="ten" value="${sv.TEN}" class="form-control" />
									</div>
									<div class="mb-3">
										<label>Ngày sinh: </label>
										<input type="date" name="ngaysinh" value="${sv.NGAYSINH}" class="form-control" />
									</div>
									<div class="mb-3">
										<label>Địa chỉ: </label>
										<input name="diachi" value="${sv.DIACHI}" class="form-control" />
									</div>
									<div class="mb-3">
										<label>Lớp</label>
										<select class="form-select" id="lop" name="malop" disabled>
											<option value="${sv.MALOP}">${sv.MALOP}</option>
										</select>
									</div>
									<button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal">Save</button>
									<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
								</form>
							</div>
						</div>
					</div>

					<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#move-student-${sv.MASV.trim()}">
						Chuyển lớp
					</button>
					<div class="modal fade" id="move-student-${sv.MASV.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<form method="POST" action="student/move-student.htm" class="form-control" target="formSubmitFrame">
									<input type="hidden" name="masv" value="${sv.MASV}" />
									<div class="mb-3">
										<label>Lớp</label>
										<select class="form-select" id="lop" name="malop">
											<c:forEach var="l" items="${lops}">
												<option value="${l.MALOP}">
													${l.MALOP} (${l.TENLOP})</option>
											</c:forEach>
										</select>
									</div>
									<button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal">Save</button>
									<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
								</form>
							</div>
						</div>
					</div>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
