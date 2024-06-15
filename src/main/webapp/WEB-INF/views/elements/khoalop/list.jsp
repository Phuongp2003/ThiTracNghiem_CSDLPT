<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div class="khoa-lop container-fluid" style="width:85%;">
    <table class="lop-list table">
		<div class="filter-wrapper row mb-2">
			<div class="col-md-6 col-sm-12 col-lg-6">
				<form role="search" action="manage/category/search.htm">
					<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
				</form>
			</div>
			<div class="col-md-6 col-sm-6 col-lg-6">
				<a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Thêm giáo viên</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Undo</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">In danh sách giáo viên</button></a>
            </div>
		</div>
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
					<td>
						<a href="manage/category/${category.MATL}/delete.htm" onclick="return confirm('Bạn có chắc muốn xóa thể loại ${category.TENTL}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
						<a href="manage/category/${category.MATL}/update.htm"><button class="btn btn-outline-primary"><i class="bi bi-pencil-square"></i></button></a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

    <table class="khoa-list table">
		<div class="filter-wrapper row mb-2">
			<div class="col-md-6 col-sm-12 col-lg-6">
				<form role="search" action="manage/category/search.htm">
					<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
				</form>
			</div>
			<div class="col-md-6 col-sm-6 col-lg-6">
				<a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Thêm giáo viên</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Undo</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">In danh sách giáo viên</button></a>
            </div>
		</div>
		<thead>
			<tr>
				<th scope="col">Mã khoa</th>
				<th scope="col">Tên khoa</th>
				<th scope="col">Mã cơ sở</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="k" items="${khoas}">
				<tr>
					<td>${k.MAKH}</td>
					<td>${k.TENKH}</td>
					<td>${k.MACS}</td>
					<td>
						<a href="manage/category/${category.MATL}/delete.htm" onclick="return confirm('Bạn có chắc muốn xóa thể loại ${category.TENTL}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
						<a href="manage/category/${category.MATL}/update.htm"><button class="btn btn-outline-primary"><i class="bi bi-pencil-square"></i></button></a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>