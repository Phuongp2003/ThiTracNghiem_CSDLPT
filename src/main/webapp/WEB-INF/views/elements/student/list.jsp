<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
	.student-list {
		height: 35vh;
		overflow-y: scroll;
	}
	
	.class-list {
		height: 100%;
		overflow-y: scroll;
	}
</style>
<div class="student container-fluid" style="width:85%;">
	<div class="filter-wrapper d-flex justify-content-between mb-2">
		<div class="d-flex col-md-2">
			<select class="form-select" id="site" name="site">
				<option value="1">Cơ sở 1</option>
				<option value="2">Cơ sở 2</option>
			</select>
		</div>
		<div class="col-md-4">
			<form role="search" action="manage/category/search.htm">
				<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
			</form>
		</div>
		<div class="col-md-2">
			<form id="lopForm" action="student.htm">
				<select class="form-select" id="lop" name="malop" onchange="submitForm()">
					<option value="all" ${malop=="all" ? 'selected' : '' }>Lớp: Tất cả</option>
					<c:forEach var="l" items="${lops}">
						<option value="${l.MALOP}" ${l.MALOP==malop ? 'selected' : '' }>
							Mã lớp: ${l.MALOP} (${l.TENLOP})</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="">
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Thêm sinh viên</button></a>
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Undo</button></a>
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">In danh sách sinh viên</button></a>
		</div>
	</div>
	<div class="student-list">
		<table class="table">
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
							<a href="manage/category/${category.MATL}/delete" onclick="return confirm('Bạn có chắc muốn xóa thể loại ${category.TENTL}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
							<a href="manage/category/${category.MATL}/update"><button class="btn btn-outline-primary"><i class="bi bi-pencil-square"></i></button></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="class-list mt-4">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Mã lớp</th>
					<th scope="col">Tên lớp</th>
					<th scope="col">Mã khoa</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="l" items="${lops}">
					<tr>
						<td>${l.MALOP}</td>
						<td>${l.TENLOP}</td>
						<td>${l.MAKH}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<script>
	function submitForm() {
		document.getElementById("lopForm").submit();
	}
</script>
