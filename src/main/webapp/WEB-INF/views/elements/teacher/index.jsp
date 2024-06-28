<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
	.is-action:hover {
		cursor: pointer;
		border: 2px solid rgba(0, 255, 155, 0.2);
	}
	
	tr.selected {
		border: 2px solid green;
	}
</style>
<div class="teacher container-fluid" style="width:85%;">
	<div class="teach-filter row mb-2">
		<jsp:include page="./filter.jsp" />
	</div>
	<div class="teach-list">
		<jsp:include page="./list.jsp" />
	</div>
	<div class="khoa-list mt-4">
		<table class="table khoa-table">
			<thead>
				<tr>
					<th scope="col">Mã khoa</th>
            		<th scope="col">Tên khoa</th>
            		<th scope="col">Cơ sở</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="k" items="${khoas}">
					<tr class="is-action sl-${k.MAKH}" onclick="toggleAndLoad('${k.MAKH}')">
						<td>${k.MAKH}</td>
						<td>${k.TENKH}</td>
						<td>${k.MACS}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<div class="modal fade" id="add-student" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="addStudentForm" method="POST" action="teacher/add.htm" class="form-control" target="formSubmitFrame">
				<div class="mb-3">
					<label>Mã nhân viên: </label>
					<input name="manv" class="form-control" required />
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
					<label>Địa chỉ: </label>
					<input name="diachi" class="form-control" />
				</div>
				<div class="mb-3">
					<label>Khoa: </label>
					<select class="form-select" id="khoa" name="makhoa">
						<c:forEach var="k" items="${khoas}">
							<option value="${k.MAKH}">
								${k.getFullName()}
							</option>
						</c:forEach>
					</select>
				</div>
				<button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal">Save</button>
				<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
			</form>
		</div>
	</div>
</div>

<script>
	var currentKhoa;
	var currentSearch;

	function loadTeachers(value) {
		fetch('teacher/get-gv-by-khoa.htm', {
				method: 'POST',
				body: JSON.stringify({
					makhoa: value
				})
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
				return response.text();
			})
			.then(data => {
				const userBar = document.querySelector('.teach-list');
				userBar.innerHTML = data;
				
				const selectElement = document.querySelector('.chon-khoa');
				if (selectElement.value != value) selectElement.value = value;
			})
			.catch(error => {
				console.error('Error:', error);
			});
		currentKhoa = value;
	}

	function searchTeachers(value) {
		fetch('teacher/search.htm', {
				method: 'POST',
				body: JSON.stringify({
					searchInput: value
				})
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
				return response.text();
			})
			.then(data => {
				const userBar = document.querySelector('.teach-list');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
		currentSearch = value;
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
			loadTeachers(value);
		} else {
			const selectedRows = document.querySelectorAll('.is-action.selected');
			if (selectedRows.length === 0) {
				loadTeachers('all');
			}
		}
	}
	
	function loadActionButton() {
		fetch('teacher/refresh-action-buttons.htm', {
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
		if (!currentKhoa) currentKhoa = "all";
		loadActionButton();
		loadTeachers(window.currentKhoa);
		if(currentSearch) searchTeachers(currentSearch);
	}
	
	var addStudentModal = document.getElementById('add-teacher');
	addStudentModal.addEventListener('hidden.bs.modal', function() {
		document.getElementById('addTeacherForm').reset();
	});
</script>
