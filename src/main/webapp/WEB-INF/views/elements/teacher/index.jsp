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
	<div class="teach-filter d-flex justify-content-between mb-2">
		<jsp:include page="./filter.jsp" />
	</div>
	<div class="teach-list">
		<jsp:include page="./list.jsp" />
	</div>
	<div class="khoa-list mt-4">
		<jsp:include page="./khoa_table.jsp" />
		
	</div>
</div>

<div class="modal fade" id="add-student" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="addStudentForm" method="POST" action="teacher/add.htm" class="form-control needs-validation">
				<div class="mb-3">
					<label>Mã nhân viên: </label>
					<input name="manv" class="form-control" required onblur="checkMagvExist(this)" />
					<div class="valid-feedback">
						Mã giáo viên hợp lệ!
					</div>
					<div class="invalid-feedback">
						Mã giáo viên không hợp lệ hoặc đã tồn tại!
					</div>
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
					<select class="form-select khoa-list-o" id="khoa" name="makhoa">
						<c:forEach var="k" items="${khoas}">
							<option value="${k.MAKH}" ${(k.MAKH==current ? 'selected' : '' )}>
								${k.getFullName()}
							</option>
						</c:forEach>
					</select>
				</div>
				<button class="btn btn-primary mt-2" type="button" onclick="submitClosestForm(this, () => refreshData())"
					data-bs-dismiss="modal" id="submit-form" disabled>Save</button>
				<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
			</form>
		</div>
	</div>
</div>

<script>
	var currentKhoa;
	var currentSearch;

	var isDiffSite = false;
	
	function checkSite(value) {
		if (value == 'diff') isDiffSite = true;
		else isDiffSite = false;
		refreshData();
	}
	
	function loadTeachers(value) {
		var isDiff = isDiffSite ? 'true' : 'false';
		fetch('teacher/get-gv-by-khoa.htm', {
				method: 'POST',
				body: JSON.stringify({
					makhoa: value,
					diff: isDiff
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
	
	function loadKhoa(value) {
		var isDiff = isDiffSite ? 'true' : 'false';
		fetch('teacher/load-khoa-o.htm', {
				method: 'POST',
				body: JSON.stringify({
					current: value,
					diff: isDiff
				})
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
				return response.text();
			})
			.then(data => {
				const userBar = document.querySelector('.chon-khoa');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
		fetch('teacher/load-khoa-t.htm', {
				method: 'POST',
				body: JSON.stringify({
					current: value,
					diff: isDiff
				})
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
				return response.text();
			})
			.then(data => {
				const userBar = document.querySelector('.khoa-list');
				userBar.innerHTML = data;
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
		if (!currentKhoa) currentKhoa = 'all';
		loadTeachers(window.currentKhoa);
		loadActionButton();
		loadKhoa(window.currentKhoa);
	}
	
	// var addStudentModal = document.getElementById('add-teacher');
	// addStudentModal.addEventListener('hidden.bs.modal', function() {
	// 	document.getElementById('addTeacherForm').reset();
	// });
	
	async function checkMagvExist(element) {
		const manv = element.value.trim();
		var submitForm = document.getElementById('submit-form');
		// Convert the string representation of list to an actual array of objects
		try {
			var check = await fetch('teacher/check-magv.htm', {
					method: 'POST',
					body: JSON.stringify({
						manv: manv
					})
				})
				.then(response => {
					if (!response.ok) {
						throw new Error(`HTTP error! status: ${response.status}`);
					}
					return response.text();
				})
				.then(data => {
					return data.includes('true');
				})
				.catch(error => {
					console.error('Error:', error);
				});
			// Check if the provided magv exists in the sinhVienArray by magv
			if (check && (manv !== '')) {
				element.classList.remove('is-invalid')
				element.classList.add('is-valid')
				if (submitForm !== null) {
					submitForm.disabled = false;
				} else {
					// Handle the case where no matching element is found
					console.log("No element found with ID 'submit-form'");
				}
			} else {
				element.classList.remove('is-valid')
				element.classList.add('is-invalid')
				if (submitForm !== null) {
					submitForm.disabled = true;
				} else {
					// Handle the case where no matching element is found
					console.log("No element found with ID 'submit-form'");
				}
			}
		} catch (error) {
			window.alert("Lỗi: ", error)
		}
	}
	
	// Fetch all the forms we want to apply custom Bootstrap validation styles to
	var forms = document.querySelectorAll('.needs-validation')
	
	// Loop over them and prevent submission
	Array.prototype.slice.call(forms)
		.forEach(function(form) {
			form.addEventListener('submit', function(event) {
				// Loop over them and prevent submission
				event.preventDefault(); // Prevent form submission
				
				const invalidElements = form.querySelectorAll('.is-invalid');
				
				if (invalidElements.length === 0) {
					form.submit();
				} else {
					alert('Please fix the errors in the form before submitting.');
				}
			}, false)
		})
</script>
