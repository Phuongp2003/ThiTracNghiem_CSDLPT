<%@ page pageEncoding="UTF-8" %>
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
	
	.is-action:hover {
		cursor: pointer;
		border: 2px solid rgba(0, 255, 155, 0.2);
	}
	
	tr.selected {
		border: 2px solid green;
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
		<div class="col-md-3">
			<form role="search" action="manage/category/search.htm" target="formSubmitFrame">
				<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
			</form>
		</div>
		<div class="col-md-2">
			<form action="student.htm" target="formSubmitFrame">
				<select class="form-select chon-lop" id="lop" name="malop" onchange="loadStudents(this.value)">
					<option value="all" ${malop=="all" ? 'selected' : '' }>Lớp: Tất cả</option>
					<c:forEach var="l" items="${lops}">
						<option value="${l.MALOP}" ${l.MALOP==malop ? 'selected' : '' }>
							${l.MALOP} (${l.TENLOP})</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="">
			<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-student">
				Thêm sinh viên
			</button>
			<div class="modal fade" id="add-student" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<form id="addStudentForm" method="POST" action="student/add-student.htm" class="form-control" target="formSubmitFrame">
							<div class="mb-3">
								<label>Mã sinh viên: </label>
								<input name="masv" class="form-control" required />
							</div>
							<div class="mb-3">
								<label>Họ: </label>
								<input name="ho" class="form-control" />
							</div>
							<div class="mb-3">
								<label>Tên: </label>
								<input name="ten" class="form-control" />
							</div>
							<div class="mb-3">
								<label>Ngày sinh: </label>
								<input type="date" name="ngaysinh" class="form-control" />
							</div>
							<div class="mb-3">
								<label>Địa chỉ: </label>
								<input name="diachi" class="form-control" />
							</div>
							<select class="form-select" id="lop" name="malop">
								<c:forEach var="l" items="${lops}">
									<option value="${l.MALOP}">
										${l.MALOP} (${l.TENLOP})</option>
								</c:forEach>
							</select>
							<button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal">Save</button>
							<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
						</form>
					</div>
				</div>
			</div>
			<iframe id="message-iframe" name="formSubmitFrame" src="about:blank" style="display: none;" onload="refreshData()"></iframe>
			<div class="action-btn-group d-inline">
				<jsp:include page="./button_action_list.jsp" />
			</div>
			<button type="button" class="btn btn-outline-primary" onclick="refreshData()">Reload</button>
		</div>
	</div>
	<div class="student-list">
		<jsp:include page="./student_list.jsp" />
	</div>
	<div class="class-list mt-4">
		<table class="table lop-table">
			<thead>
				<tr>
					<th scope="col">Mã lớp</th>
					<th scope="col">Tên lớp</th>
					<th scope="col">Mã khoa</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="l" items="${lops}">
					<tr class="is-action sl-${l.MALOP}" onclick="toggleAndLoad('${l.MALOP}')">
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
	var currentLop;
	
	function loadStudents(value) {
		fetch('student/get-sv-by-lop.htm', {
				method: 'POST',
				body: JSON.stringify({
					malop: value
				})
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
				return response.text();
			})
			.then(data => {
				const userBar = document.querySelector('.student-list');
				userBar.innerHTML = data;
				
				const selectElement = document.querySelector('.chon-lop');
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
		currentLop = value;
		console.log("🚀 ~ loadStudents ~ currentLop:", currentLop)
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
	
	function loadActionButton() {
		fetch('student/refresh-action-buttons.htm', {
				method: 'POST',
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
				return response.text();
			})
			.then(data => {
				const userBar = document.querySelector('.action-btn-group');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
	}
	
	function refreshData() {
		if (!currentLop) currentLop = "all";
		loadActionButton();
		loadStudents(window.currentLop);
	}

	var addStudentModal = document.getElementById('add-student');
	addStudentModal.addEventListener('hidden.bs.modal', function () {
        document.getElementById('addStudentForm').reset();
    });
</script>
