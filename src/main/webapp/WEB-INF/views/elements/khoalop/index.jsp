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
		<c:if test="${role_al == 'TRUONG'}">
			<div class="d-flex col-md-2">
				<select class="form-select" id="site" name="site" onchange="checkSite(this.value)">
					<c:forEach var="cs" items="${sites}">
						<option value="${currentSite==cs.tenServer ? 'current' : 'diff' }" ${currentSite==cs.tenServer ? 'selected' : '' }>${cs.tenCS}</option>
					</c:forEach>
				</select>
			</div>
		</c:if>
		<div class="col-md-3 col-sm-12 col-lg-3">
			<input name="searchInput" class="form-control" type="search" placeholder="Tìm mã, tên, khoa..." aria-label="Search" style="width: 80%;" onchange="searchClasses(this.value)">
		</div>
		<div class="khoa-select col-md-2">
			<form action="department-class.htm" target="formSubmitFrame">
				<select class="form-select chon-khoa" id="khoa" name="makh" onchange="loadClasses(this.value)">
					<jsp:include page="./khoa_rf_list.jsp" />
				</select>
			</form>
		</div>
		<div class="">
			<c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}">
				<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-class">
					Thêm lớp
				</button>
				<div class="modal fade" id="add-class" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<form id="addClassForm" method="POST" action="department-class/add-class.htm" class="form-control needs-validation">
								<div class="mb-3">
									<label>Mã lớp: </label>
									<input name="malop" class="malop form-control" onchange="checkMalopExist(this)" required />
									<div class="valid-feedback">
										Mã lớp hợp lệ!
									</div>
									<div class="invalid-feedback">
										Mã lớp không hợp lệ hoặc đã tồn tại!
									</div>
								</div>
								<div class="mb-3">
									<label>Tên lớp: </label>
									<input name="tenlop" id="tenlop" class="tenlop form-control" required onchange="checkMalopExist(this)" />
									<div class="invalid-feedback">
										Tên lớp đã tồn tại!
									</div>
								</div>
								<div class="mb-3">
									<label>Khoa</label>
									<select class="form-select" id="khoa" name="makh">
										<c:forEach var="k" items="${khoas}">
											<option value="${k.MAKH}">
												${k.MAKH} (${k.TENKH})</option>
										</c:forEach>
									</select>
								</div>
								<button class="btn btn-primary mt-2" type="button" onclick="submitClosestForm(this, () => refreshData())" data-bs-dismiss="modal" id="submit-form" disabled>Save</button>
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
	<div class="lop-list mb-4">
		<jsp:include page="./lop_list.jsp" />
	</div>
	<div class="filter-wrapper d-flex justify-content-between mt-4 mb-2">
		<div></div>
		<div class="">
			<c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}">
				<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-department">
					Thêm khoa
				</button>
				<div class="modal fade" id="add-department" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<form id="addDepartForm" method="POST" action="department-class/add-department.htm" class="form-control needs-validation" target="formSubmitFrame">
								<div class="mb-3">
									<label>Mã khoa: </label>
									<input name="makh" class="makh form-control" required onchange="checkMakhExist(this)" />
									<div class="valid-feedback">
										Mã khoa hợp lệ!
									</div>
									<div class="invalid-feedback">
										Mã khoa không hợp lệ hoặc đã tồn tại!
									</div>
								</div>
								<div class="mb-3">
									<label>Tên khoa: </label>
									<input name="tenkh" id="tenkh" class="tenkh form-control" required onchange="checkMakhExist(this)" />
									<div class="invalid-feedback">
										Tên khoa đã tồn tại!
									</div>
								</div>
								<button class="btn btn-primary mt-2" type="button" onclick="submitClosestForm(this, () => refreshData())" data-bs-dismiss="modal" id="submit-form-dp" disabled>Save</button>
								<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
							</form>
						</div>
					</div>
				</div>
			</c:if>
			<iframe id="message-iframe" name="formSubmitFrame" src="about:blank" style="display: none;" onload="refreshData()"></iframe>
		</div>
	</div>
	<div class="khoa-list">
		<jsp:include page="./khoa_list.jsp" />
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
	
	function loadClasses(value) {
		var isDiff = isDiffSite ? 'true' : 'false';
		fetch('department-class/get-lop-by-khoa.htm', {
				method: 'POST',
				body: JSON.stringify({
					makh: value,
					diff: isDiff
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
		currentKhoa = value;
	}
	
	function searchClasses(value) {
		fetch('department-class/search.htm', {
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
				const userBar = document.querySelector('.lop-list');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
		currentSearch = value;
	}
	
	function loadRfDepartments() {
		var isDiff = isDiffSite ? 'true' : 'false';
		fetch('department-class/load-rf-khoa.htm', {
				method: 'POST',
				body: JSON.stringify({
					diff: isDiff
				})
			})
			.then(response => response.text())
			.then(data => {
				const userBar = document.querySelector('.chon-khoa');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
	}
	
	function loadDepartments() {
		var isDiff = isDiffSite ? 'true' : 'false';
		fetch('department-class/load-khoa.htm', {
				method: 'POST',
				body: JSON.stringify({
					diff: isDiff
				})
			})
			.then(response => response.text())
			.then(data => {
				const userBar = document.querySelector('.khoa-list');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
		loadRfDepartments()
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
			loadClasses(value);
			loadDepartments();
		} else {
			const selectedRows = document.querySelectorAll('.is-action.selected');
			if (selectedRows.length === 0) {
				loadClasses('all');
				loadDepartments();
			}
		}
	}
	
	function loadActionButton() {
		fetch('department-class/refresh-action-buttons.htm', {
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
		loadActionButton();
		loadClasses(window.currentKhoa);
		loadDepartments();
	}
	
	// var addClassModal = document.getElementById('add-class');
	// addClassModal.addEventListener('hidden.bs.modal', function() {
	// 	document.getElementById('addClassForm').reset();
	// });
	// var addDepartModal = document.getElementById('add-department');
	// addDepartModal.addEventListener('hidden.bs.modal', function() {
	// 	document.getElementById('addDepartForm').reset();
	// });
	
	async function checkMalopExist(element) {
		var malop, tenlop;
		if (element.classList.contains('malop')) {
			malop = element.value.trim();
			tenlop = element.closest('#addClassForm').querySelector('.tenlop').value.trim();
		} else {
			malop = element.closest('#addClassForm').querySelector('.malop').value.trim();
			tenlop = element.value.trim();
		}
		var submitForm = document.getElementById('submit-form');
		var tenlop_unable = document.getElementById('tenlop');
		
		// Convert the string representation of list to an actual array of objects
		try {
			var check = await fetch('department-class/check-malop.htm', {
					method: 'POST',
					body: JSON.stringify({
						malop: malop,
						tenlop: tenlop
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
			if (check && (malop !== '' || tenlop !== '')) {
				element.classList.remove('is-invalid')
				element.classList.add('is-valid')
				if (submitForm !== null) {
					submitForm.disabled = false;
					tenlop_unable.disabled = false;
				} else {
					// Handle the case where no matching element is found
					console.log("No element found with ID 'submit-form'");
				}
			} else {
				element.classList.remove('is-valid')
				element.classList.add('is-invalid')
				if (submitForm !== null) {
					submitForm.disabled = true;
					if (element.classList.contains('malop')) tenlop_unable.disabled = true;
				} else {
					// Handle the case where no matching element is found
					console.log("No element found with ID 'submit-form'");
				}
			}
		} catch (error) {
			window.alert("Lỗi: ", error)
		}
	}
	
	async function checkMakhExist(element) {
		var makh, tenkh;
		if (element.classList.contains('makh')) {
			makh = element.value.trim();
			tenkh = element.closest('#addDepartForm').querySelector('.tenkh').value.trim();
		} else {
			makh = element.closest('#addDepartForm').querySelector('.makh').value.trim();
			tenkh = element.value.trim();
		}
		var submitForm = document.getElementById('submit-form-dp');
		var tenkh_unable = document.getElementById('tenkh');
		// Convert the string representation of list to an actual array of objects
		try {
			var check = await fetch('department-class/check-makh.htm', {
					method: 'POST',
					body: JSON.stringify({
						makh: makh,
						tenkh: tenkh
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
			if (check && (makh !== '' || tenkh !== '')) {
				element.classList.remove('is-invalid')
				element.classList.add('is-valid')
				if (submitForm !== null) {
					submitForm.disabled = false;
					tenkh_unable.disabled = false;
				} else {
					// Handle the case where no matching element is found
					console.log("No element found with ID 'submit-form'");
				}
			} else {
				element.classList.remove('is-valid')
				element.classList.add('is-invalid')
				if (submitForm !== null) {
					submitForm.disabled = true;
					if (element.classList.contains('makh')) tenkh_unable.disabled = true;
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
