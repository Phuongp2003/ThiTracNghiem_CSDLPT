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
		<div class="col-md-3 col-sm-12 col-lg-3">
			<form role="search" action="department-class.htm" target="formSubmitFrame">
				<input name="searchInput" class="form-control" type="search" placeholder="Tìm mã, tên, khoa..." 
					aria-label="Search" style="width: 80%;" onchange="searchClasses(this.value)">
			</form>
		</div>
		<div class="khoa-select col-md-2">
			<form action="department-class.htm" target="formSubmitFrame">
				<select class="form-select chon-khoa" id="khoa" name="makh" onchange="loadClasses(this.value)">
					<jsp:include page="./khoa_rf_list.jsp" />
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
						<form id="addClassForm" method="POST" action="department-class/add-class.htm" class="form-control" target="formSubmitFrame">
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
										${k.MAKH} (${k.TENKH})</option>
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
	<div class="lop-list mb-4">
		<jsp:include page="./lop_list.jsp" />
	</div>
	<div class="filter-wrapper d-flex justify-content-between mt-4 mb-2">
		<div></div>
		<div class="">
			<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-department">
				Thêm khoa
			</button>
			<div class="modal fade" id="add-department" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<form id="addDepartForm" method="POST" action="department-class/add-department.htm" class="form-control" target="formSubmitFrame">
							<div class="mb-3">
								<label>Mã khoa: </label>
								<input name="makh" class="form-control" required />
							</div>
							<div class="mb-3">
								<label>Tên khoa: </label>
								<input name="tenkh" class="form-control" />
							</div>
							<button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal">Save</button>
							<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
						</form>
					</div>
				</div>
			</div>
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
		currentKhoa = value;
		console.log("🚀 ~ loadLops ~ currentKhoa:", currentKhoa)
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
		fetch('department-class/load-rf-khoa.htm', {
				method: 'POST',
				body: JSON.stringify({})
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
		fetch('department-class/load-khoa.htm', {
				method: 'POST',
				body: JSON.stringify({})
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
		if (!currentKhoa) currentKhoa = "all";
		loadActionButton();
		loadClasses(window.currentKhoa);
		loadDepartments();
		if(currentSearch) searchClasses(currentSearch);
	}
	
	var addClassModal = document.getElementById('add-class');
	addClassModal.addEventListener('hidden.bs.modal', function() {
		document.getElementById('addClassForm').reset();
	});
	var addDepartModal = document.getElementById('add-department');
	addDepartModal.addEventListener('hidden.bs.modal', function() {
		document.getElementById('addDepartForm').reset();
	});
</script>
