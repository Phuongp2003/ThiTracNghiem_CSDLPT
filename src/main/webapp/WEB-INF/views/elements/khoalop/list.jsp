<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
	.khoa-lop .lop-list{
		height: 35vh;
		overflow-y: scroll;
	}
</style>
<div class="khoa-lop container-fluid" style="width:85%;">
	<div class="filter-wrapper d-flex justify-content-between mb-2">
		<div class="d-flex col-md-2">
			<select class="form-select" id="site" name="site">
				<option value="1">Cơ sở 1</option>
				<option value="2">Cơ sở 2</option>
			</select>
		</div>
		<div class="col-md-4 col-sm-12 col-lg-4">
			<form role="search" action="manage/category/search.htm">
				<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
			</form>
		</div>
		<div class="col-md-2">
			<form id="khoaLop" action="department-class.htm">
				<select class="form-select" id="khoa" name="makh" onchange="submitForm()">
					<option value="all" ${mkh=="all" ? 'selected' : '' }>Khoa: Tất cả</option>
					<c:forEach var="k" items="${khoas}">
						<option value="${k.MAKH}" ${k.MAKH==makh ? 'selected' : '' }
						>Mã khoa: ${k.MAKH} (${k.TENKH})</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="">
			<a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Thêm lớp</button></a>
			<a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Undo</button></a>
			<a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">In danh sách lớp</button></a>
		</div>
	</div>
    <div class="lop-list mb-4">
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
							<a href="manage/category/${category.MATL}/delete.htm" onclick="return confirm('Bạn có chắc muốn xóa thể loại ${category.TENTL}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
							<a href="manage/category/${category.MATL}/update.htm"><button class="btn btn-outline-primary"><i class="bi bi-pencil-square"></i></button></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

    <table class="khoa-list table">
		<div class="filter-wrapper row mt-4 mb-2">
			<div class="col-md-6 col-sm-12 col-lg-6">
				<form role="search" action="manage/category/search.htm">
					<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
				</form>
			</div>
			<div class="col-md-6 col-sm-6 col-lg-6">
				<a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Thêm khoa</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Undo</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">In danh sách khoa</button></a>
            </div>
		</div>
		<thead>
			<tr>
				<th scope="col">Mã khoa</th>
				<th scope="col">Tên khoa</th>
				<th scope="col">Mã cơ sở</th>
				<th scope="col">Thao tác</th>
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
<script>
	function submitForm() {
		document.getElementById("khoaLop").submit();
	}
</script>