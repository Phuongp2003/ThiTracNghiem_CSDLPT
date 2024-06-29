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
		<c:if test="${role_al == 'TRUONG'}">
			<div class="d-flex col-md-2">
				<select class="form-select" id="site" name="site" onchange="checkSite(this.value)">
					<c:forEach var="cs" items="${sites}">
						<option value="${currentSite==cs.tenServer ? 'current' : 'diff' }" ${currentSite==cs.tenServer ? 'selected' : '' }>${cs.tenCS}</option>
					</c:forEach>
				</select>
			</div>
		</c:if>
		<div class="col-md-3">
			<input name="searchInput" class="form-control" type="search" placeholder="Tìm mã, tên, lớp..." aria-label="Search" style="width: 80%;" onchange="searchStudents(this.value)">
		</div>
		<div class="col-md-2">
			<form action="student.htm" target="formSubmitFrame">
				<select class="form-select chon-lop" id="lop" name="malop" onchange="loadStudents(this.value)">
					<jsp:include page="./lop_option.jsp" />
				</select>
			</form>
		</div>
		<div class="">
			<c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}">
				<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-student">
					Thêm sinh viên
				</button>
				<div class="modal fade" id="add-student" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<form id="addStudentForm" method="POST" action="student/add-student.htm" class="form-control needs-validation" target="formSubmitFrame">
								<div class="mb-3">
									<label>Mã sinh viên: </label>
									<input name="masv" class="form-control" required onblur="checkMasvExist(this)" />
									<div class="valid-feedback">
										Mã sinh viên hợp lệ!
									</div>
									<div class="invalid-feedback">
										Mã sinh viên không hợp lệ!
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
								<button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal" id="submit-form">Save</button>
								<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
							</form>
						</div>
					</div>
				</div>
				<div class="action-btn-group d-inline">
					<jsp:include page="./button_action_list.jsp" />
				</div>
			</c:if>
			<iframe id="message-iframe" name="formSubmitFrame" src="about:blank" style="display: none;" onload="refreshData()"></iframe>
			<button type="button" class="btn btn-outline-primary" onclick="refreshData()">Reload</button>
		</div>
	</div>
	<div class="student-list">
		<jsp:include page="./student_list.jsp" />
	</div>
	<div class="lop-list mt-4">
		<jsp:include page="./lop_list.jsp" />
	</div>
</div>
<script>
	var currentLop;
	var currentSearch;
	var isDiffSite = false;
	
	function checkSite(value) {
		if (value == 'diff') isDiffSite = true;
		else isDiffSite = false;
		refreshData();
	}
	
	function loadStudents(value) {
		var isDiff = isDiffSite ? 'true' : 'false';
		fetch('student/get-sv-by-lop.htm', {
				method: 'POST',
				body: JSON.stringify({
					malop: value,
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
	}

	function loadLop(value) {
		var isDiff = isDiffSite ? 'true' : 'false';
		fetch('student/load-lop-o.htm', {
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
				const userBar = document.querySelector('.chon-lop');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
		fetch('student/load-lop-t.htm', {
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
				const userBar = document.querySelector('.lop-list');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
	}
	
	function searchStudents(value) {
		fetch('student/search.htm', {
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
				const userBar = document.querySelector('.student-list');
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
		loadLop(currentLop);
	}
	
	var addStudentModal = document.getElementById('add-student');
	addStudentModal.addEventListener('hidden.bs.modal', function() {
		document.getElementById('addStudentForm').reset();
	});
	
	function parseSinhVienList(listStr) {
		const trimmedListStr = listStr.substring(1, listStr.length - 1); // Remove leading and trailing square brackets
		const sinhVienStrs = trimmedListStr.split('}, ');
		const sinhVienObjects = sinhVienStrs.map(sinhVienStr => {
			const propertiesStr = sinhVienStr.replace('SinhVien{', '').replace('}', '');
			const properties = propertiesStr.split(', ');
			const sinhVienObj = {};
			properties.forEach(property => {
				const [key, value] = property.split('=');
				sinhVienObj[key.trim()] = value.trim().replace(/'/g, ''); // Remove single quotes from values
			});
			return sinhVienObj;
		});
		return sinhVienObjects;
	}
	
	async function checkMasvExist(element) {
		const masv = element.value;
		var submitForm = document.getElementById('submit-form');
		// Convert the string representation of list to an actual array of objects
		try {
			var check = await fetch('student/check-masv.htm', {
					method: 'POST',
					body: JSON.stringify({
						masv: masv
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
			// Check if the provided masv exists in the sinhVienArray by MASV
			if (check) {
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
