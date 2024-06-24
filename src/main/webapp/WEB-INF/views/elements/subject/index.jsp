<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div class="subject container-fluid" style="width:85%;">
	<div class="filter-wrapper d-flex justify-content-between mb-2">
		<div class="d-flex col-md-2">
			<select class="form-select" id="site" name="site">
				<option value="1">Cơ sở 1</option>
				<option value="2">Cơ sở 2</option>
			</select>
		</div>
		<div class="col-md-6 col-sm-12 col-lg-6">
			<form role="search" action="manage/category/search.htm">
				<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
			</form>
		</div>
		<div class="">
			<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-subject">
				Thêm môn học
			</button>
			<div class="modal fade" id="add-subject" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<form id="addSubjectForm" method="POST" action="subject/add-subject.htm" class="form-control" target="formSubmitFrame">
							<div class="mb-3">
								<label>Mã môn học: </label>
								<input name="mamh" class="form-control" required />
							</div>
							<div class="mb-3">
								<label>Tên môn học: </label>
								<input name="tenmh" class="form-control" />
							</div>
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
	<div class="subject-list">
		<jsp:include page="./subject_list.jsp" />
	</div>
	
	<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#score-subject">
		Xem bảng điểm môn học
	</button>
	<div class="modal fade" id="score-subject" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form method="POST" action="score-list.htm" class="form-control">
					<div class="mb-3">
						<label>Lớp</label>
						<select class="form-select" id="lop" name="malop">
							<c:forEach var="l" items="${lops}">
								<option value="${l.MALOP}">
									${l.MALOP} (${l.TENLOP})</option>
							</c:forEach>
						</select>
					</div>
					<div class="mb-3">
						<label>Môn học</label>
						<select class="form-select" id="monhoc" name="mamh">
							<c:forEach var="mh" items="${monHocs}">
								<option value="${mh.MAMH}">
									${mh.MAMH} (${mh.TENMH})</option>
							</c:forEach>
						</select>
					</div>
					<div class="mb-3">
						<label>Lần thi</label>
						<input type="number" name="lanthi" class="form-control" max="2" min="1">
					</div>
					<button type="submit" class="btn btn-primary">In bảng điểm</button>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	function loadSubjects() {
		fetch('subject/load-subject.htm', {
				method: 'POST',
				body: JSON.stringify({})
			})
			.then(response => response.text())
			.then(data => {
				const userBar = document.querySelector('.subject-list');
				userBar.innerHTML = data;
			})
			.catch(error => {
				console.error('Error:', error);
			});
	}
	
	function loadActionButton() {
		fetch('subject/refresh-action-buttons.htm', {
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
		loadActionButton();
		loadSubjects();
	}
</script>
