<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
	.khoa-lop .lop-list {
		height: 35vh;
		overflow-y: scroll;
	}
	
	.is-action:hover {
		cursor: pointer;
		border: 2px solid rgba(0, 255, 155, 0.2);
	}
	
	tr.selected {
		border: 2px solid green;
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
			<form action="department-class.htm">
				<select class="form-select chon-khoa" id="khoa" name="makh" onchange="loadClasses(this.value)">
					<option value="all" ${makh=="all" ? 'selected' : '' }>Khoa: Tất cả</option>
					<c:forEach var="k" items="${khoas}">
						<option value="${k.MAKH}" ${k.MAKH==makh ? 'selected' : '' }>Mã khoa: ${k.MAKH} (${k.TENKH})</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="">
			<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-class">
				Thêm lớp
			</button>
			<div class="modal fade" id="add-class" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<form method="POST" action="department-class/add-class.htm" class="form-control">
							<div class="mb-3">
								<label>Mã lớp: </label>
								<input name="malop" class="form-control" required />
							</div>
							<div class="mb-3">
								<label>Tên lớp: </label>
								<input name="tenlop" class="form-control" />
							</div>
							<select class="form-select" id="khoa" name="makh">
								<c:forEach var="k" items="${khoas}">
									<option value="${k.MAKH}">
										Mã khoa: ${k.MAKH} (${k.TENKH})</option>
								</c:forEach>
							</select>
							<button class="btn btn-primary mt-2" type="submit">Save</button>
						</form>
					</div>
				</div>
			</div>
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Undo</button></a>
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">In danh sách lớp</button></a>
		</div>
	</div>
	<div class="lop-list mb-4">
		<jsp:include page="./lop_list.jsp" />
	</div>
	
	<table class="khoa-list table">
		<div class="filter-wrapper d-flex justify-content-between mt-4 mb-2">
			<div class="col-md-6 col-sm-12 col-lg-6">
				<form role="search" action="manage/category/search.htm">
					<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
				</form>
			</div>
			<div class="">
				<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-department">
					Thêm khoa
				</button>
				<div class="modal fade" id="add-department" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<form method="POST" action="department-class/add-department.htm" class="form-control">
								<div class="mb-3">
									<label>Mã khoa: </label>
									<input name="makh" class="form-control" required />
								</div>
								<div class="mb-3">
									<label>Tên khoa: </label>
									<input name="tenkh" class="form-control" />
								</div>
								<button class="btn btn-primary mt-2" type="submit">Save</button>
							</form>
						</div>
					</div>
				</div>
				<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Undo</button></a>
				<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">In danh sách khoa</button></a>
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
				<tr class="is-action sl-${k.MAKH}" onclick="toggleAndLoad('${k.MAKH}')">
					<td>${k.MAKH}</td>
					<td>${k.TENKH}</td>
					<td>${k.MACS}</td>
					<td>
						<a href="department-class/delete-department/${k.MAKH.trim()}.htm" onclick="return confirm('Bạn có chắc muốn xóa khoa ${k.MAKH}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-department-${k.MAKH.trim()}">
							<i class="bi bi-pencil-square"></i>
						</button>
						<div class="modal fade" id="edit-department-${k.MAKH.trim()}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form method="POST" action="department-class/edit-department.htm" class="form-control">
										<div class="mb-3">
											<label>Mã khoa: </label>
											<input name="makh" value="${k.MAKH}" class="form-control" disabled />
											<input type="hidden" name="makh" value="${k.MAKH}" />
										</div>
										<div class="mb-3">
											<label>Tên khoa: </label>
											<input name="tenkh" value="${k.TENKH}" class="form-control" />
										</div>
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
</div>
<script>
	function loadClasses(value) {
		fetch('department-class/get-lop-by-khoa.htm', {
				method: 'POST',
				body: JSON.stringify({
					makh: value
				})
			})
			.then(response => response.text())
			.then(data => {
				const userBar = document.querySelector('.lop-list');
				userBar.innerHTML = data;
				
				const selectElement = document.querySelector('.chon-khoa');
				if (selectElement.value != value) selectElement.value = value;
				
				const rows = document.querySelectorAll('.is-action');
				
				rows.forEach(row => {
					row.classList.remove('selected');
				});
				
				const selectTableElement = document.querySelector('.sl-' + value);
				if (selectTableElement && !selectTableElement.classList.contains('selected')) {
					selectTableElement.classList.add('selected');
				}
				
			})
			.catch(error => {
				console.error('Error:', error);
			});
	}
	
	function toggleAndLoad(value) {
		const element = event.target.closest('.is-action');
		element.classList.toggle('selected');
		const rows = document.querySelectorAll('.is-action');
		
		// Remove 'selected' class from other elements
		rows.forEach(row => {
			if (row !== element) {
				row.classList.remove('selected');
			}
		});
		
		// Load slected value, if no, load all
		if (element.classList.contains('selected')) {
			loadStudents(value);
		} else {
			const selectedRows = document.querySelectorAll('.is-action.selected');
			if (selectedRows.length === 0) {
				loadStudents('all');
			}
		}
	}
</script>
