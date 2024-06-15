<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div class="student container-fluid" style="width:85%;">
    <table class="student-list table">
		<div class="filter-wrapper row mb-2">
			<div class="col-md-6 col-sm-12 col-lg-6">
				<form role="search" action="manage/category/search.htm">
					<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
				</form>
			</div>
			<div class="col-md-6 col-sm-6 col-lg-6">
				<a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Thêm sinh viên</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Undo</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">In danh sách sinh viên</button></a>
            </div>
		</div>
		<thead>
			<tr>
				<th scope="col">Mã SV</th>
				<th scope="col">Họ</th>
				<th scope="col">Tên</th>
                <th scope="col">Ngày sinh</th>
				<th scope="col">Địa chỉ</th>
                <th scope="col">Mã lớp</th>
                <th scope="col">Mật khẩu</th>
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
						<a href="manage/category/${category.MATL}/delete.htm" onclick="return confirm('Bạn có chắc muốn xóa thể loại ${category.TENTL}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
						<a href="manage/category/${category.MATL}/update.htm"><button class="btn btn-outline-primary"><i class="bi bi-pencil-square"></i></button></a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>