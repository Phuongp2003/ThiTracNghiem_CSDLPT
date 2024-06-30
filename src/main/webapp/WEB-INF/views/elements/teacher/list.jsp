<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<table class="table">
	<thead>
		<tr>
			<th scope="col">Mã GV</th>
			<th scope="col">Họ</th>
			<th scope="col">Tên</th>
			<th scope="col">Địa chỉ</th>
			<th scope="col">Khoa</th>
			<c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}"><th scope="col">Thao tác</th></c:if>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="gv" items="${giaoViens}">
			<tr>
				<td>${gv.MAGV}</td>
				<td>${gv.HO}</td>
				<td>${gv.TEN}</td>
				<td>${gv.DIACHI}</td>
				<td>${khoa.get(idFix.fix(gv.MAKH, 8))}</td>
				<c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}">
					<td>
						<form class="d-inline" action="teacher/delete/${gv.MAGV.trim()}.htm" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa sinh viên ${sv.MASV}?')" target="formSubmitFrame">
							<button type="submit" class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button>
						</form>
						
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-teacher-${gv.MAGV.trim()}">
							<i class="bi bi-pencil-square"></i>
						</button>
						<div class="modal fade" id="edit-teacher-${gv.MAGV.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form method="POST" action="teacher/edit.htm" class="form-control" target="formSubmitFrame">
										<div class="mb-3">
											<label>Mã nhân viên: </label>
											<input name="manv" value="${gv.MAGV}" class="form-control" disabled />
											<input type="hidden" name="manv" value="${gv.MAGV}" />
										</div>
										<div class="mb-3">
											<label>Họ: </label>
											<input name="ho" value="${gv.HO}" class="form-control" />
										</div>
										<div class="mb-3">
											<label>Tên: </label>
											<input name="ten" value="${gv.TEN}" class="form-control" />
										</div>
										<div class="mb-3">
											<label>Địa chỉ: </label>
											<input name="diachi" value="${gv.DIACHI}" class="form-control" />
										</div>
										<div class="mb-3">
											<label>Khoa</label>
											<select class="form-select" id="khoa" name="makhoa" disabled>
												<option value="${gv.MAKH}">${gv.MAKH} (${khoa.get(idFix.fix(gv.MAKH, 8))})</option>
											</select>
										</div>
										<button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal">Save</button>
										<button type=" button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
									</form>
								</div>
							</div>
						</div>
	
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#move-teacher-${gv.MAGV.trim()}">
							Chuyển khoa
						</button>
						<div class="modal fade" id="move-teacher-${gv.MAGV.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form method="POST" action="teacher/move-teacher.htm" class="form-control" target="formSubmitFrame">
										<input type="hidden" name="magv" value="${gv.MAGV}" />
										<div class="mb-3">
											<label>Khoa</label>
											<select class="form-select" name="makh">
												<c:forEach var="k" items="${khoas}">
													<c:if test="${gv.MAKH != k.MAKH}">
														<option value="${k.MAKH}">
															${k.MAKH} (${k.TENKH})
														</option>
													</c:if>
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
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>
<c:if test="${empty giaoViens}"><h5>Không có giáo viên nào!</h5></c:if>
