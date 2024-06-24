<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="teacher container-fluid" style="width:85%;">
	<table class="teacher-list table">
		<div class="filter-wrapper row mb-2">
			<div class="col-md-6 col-sm-12 col-lg-6">
				<form role="search" action="manage/category/search.htm">
					<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
				</form>
			</div>
			<div class="col-md-6 col-sm-6 col-lg-6">
				<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Thêm giáo viên</button></a>
				<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Undo</button></a>
			</div>
		</div>
		<thead>
			<tr>
				<th scope="col">Mã GV</th>
				<th scope="col">Họ</th>
				<th scope="col">Tên</th>
				<th scope="col">Địa chỉ</th>
				<th scope="col">Khoa</th>
				<th scope="col">Thao tác</th>
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
					<td>
						<a href="manage/category/${category.MATL}/delete" onclick="return confirm('Bạn có chắc muốn xóa thể loại ${category.TENTL}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
						<a href="manage/category/${category.MATL}/update"><button class="btn btn-outline-primary"><i class="bi bi-pencil-square"></i></button></a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
