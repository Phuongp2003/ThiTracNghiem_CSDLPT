<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="teacher container-fluid" style="width:85%;">
	<div class="teach-filter row mb-2">
		<jsp:include page="./filter.jsp" />
	</div>
	<div class="teach-list">
		<jsp:include page="./list.jsp" />
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
	}
	
	var addStudentModal = document.getElementById('add-teacher');
	addStudentModal.addEventListener('hidden.bs.modal', function() {
		document.getElementById('addTeacherForm').reset();
	});
</script>
