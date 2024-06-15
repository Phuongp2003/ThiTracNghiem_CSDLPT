<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div class="subject container-fluid" style="width:85%;">
    <table class="subject-list table">
		<div class="filter-wrapper row mb-2">
			<div class="col-md-6 col-sm-12 col-lg-6">
				<form role="search" action="manage/category/search.htm">
					<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
				</form>
			</div>
			<div class="col-md-6 col-sm-6 col-lg-6">
				<a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Thêm môn học</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">Undo</button></a>
                <a href="manage/category/add-category.htm"><button type="button" class="btn btn-outline-primary">In danh sách môn học</button></a>
            </div>
		</div>
		<thead>
			<tr>
				<th scope="col">Mã môn học</th>
				<th scope="col">Tên môn học</th>
				<th scope="col">Thao tác</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="s" items="${subjects}">
				<tr>
					<td>${s.MAMH}</td>
					<td>${s.TENMH}</td>
					<td>
						<a href="manage/category/${category.MATL}/delete.htm" onclick="return confirm('Bạn có chắc muốn xóa thể loại ${category.TENTL}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
						<a href="manage/category/${category.MATL}/update.htm"><button class="btn btn-outline-primary"><i class="bi bi-pencil-square"></i></button></a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>