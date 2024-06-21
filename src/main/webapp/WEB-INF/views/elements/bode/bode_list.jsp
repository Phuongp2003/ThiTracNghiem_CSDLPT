<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
	.bode-table {
    	table-layout: fixed;
    	word-wrap: break-word;
	}
</style>
<table class="table bode-table">
	<thead>
		<tr>
			<th style="width: 5%">ID</th>
			<th style="width: 10%">Môn học</th>
			<th style="width: 7%">Trình độ</th>
			<th style="width: 30%">Nội dung</th>
			<th style="width: 15%">A</th>
			<th style="width: 15%">B</th>
			<th style="width: 15%">C</th>
			<th style="width: 15%">D</th>
            <th style="width: 5%">Đáp án</th>
            <th style="width: 12%">Thao tác</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="bd" items="${bodes}">
			<tr>
				<td>${bd.CAUHOI}</td>
                <td>${bd.MAMH}</td>
                <td>${bd.TRINHDO}</td>
                <td>${bd.NOIDUNG}</td>
                <td>${bd.getA()}</td>
                <td>${bd.getB()}</td>
                <td>${bd.getC()}</td>
                <td>${bd.getD()}</td>
                <td>${bd.DAP_AN}</td>
				<td>
					<a href="student/delete-student/${sv.MASV.trim()}.htm" onclick="return confirm('Bạn có chắc muốn xóa sinh viên ${sv.MASV}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
					
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
									<select class="form-select" id="lop" name="malop" disabled>
										<option value="${sv.MALOP}">${sv.MALOP}</option>
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
