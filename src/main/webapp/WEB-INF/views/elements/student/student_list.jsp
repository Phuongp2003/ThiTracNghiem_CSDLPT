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
			<th scope="col">Lớp</th>
			<th scope="col">Mật khẩu</th>
			<c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}">
				<th scope="col">Thao tác</th>
			</c:if>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="sv" items="${sinhViens}">
			<tr>
				<td>${sv.MASV}</td>
				<td>${sv.HO}</td>
				<td>${sv.TEN}</td>
				<td>${sv.getNGAYSINH()}</td>
				<td>${sv.DIACHI}</td>
				<td>${lopMap.get(sv.MALOP)}</td>
				<td>${sv.MATKHAU}</td>
				<c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}">
					<td>
						<form class="d-inline" action="student/delete-student/${sv.MASV.trim()}.htm" method="post">
							<button type="button" onclick="if(confirm('Bạn có chắc muốn xóa sinh viên ${sv.TEN}?')) submitClosestForm(this, () => refreshData())" class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button>
						</form>
						
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-student-${sv.MASV.trim()}">
							<i class="bi bi-pencil-square"></i>
						</button>
						<div class="modal fade" id="edit-student-${sv.MASV.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form method="POST" action="student/edit-student.htm" class="form-control">
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
												<option value="${sv.MALOP}">${sv.MALOP} (${lopMap.get(sv.MALOP)})</option>
											</select>
										</div>
										<button class="btn btn-primary mt-2" type="button" data-bs-dismiss="modal" onclick="submitClosestForm(this, () => refreshData())">Save</button>
										<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
									</form>
								</div>
							</div>
						</div>
						
						<!-- <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#move-student-${sv.MASV.trim()}">
							Chuyển lớp
						</button>
						<div class="modal fade" id="move-student-${sv.MASV.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form method="POST" action="student/move-student.htm" class="form-control">
										<input type="hidden" name="masv" value="${sv.MASV}" />
										<div class="mb-3">
											<label>Lớp</label>
											<select class="form-select" id="lop" name="malop">
												<c:forEach var="l" items="${lops}">
													<c:if test="${sv.MALOP != l.MALOP}">
														<option value="${l.MALOP}">
															${l.MALOP} (${l.TENLOP})
														</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
										<button class="btn btn-primary mt-2" type="button" data-bs-dismiss="modal" onclick="submitClosestForm(this, () => refreshData())">Save</button>
										<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
									</form>
								</div>
							</div>
						</div> -->
					</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>
<c:if test="${empty sinhViens}">
	<h5>Không có sinh viên nào!</h5>
</c:if>
