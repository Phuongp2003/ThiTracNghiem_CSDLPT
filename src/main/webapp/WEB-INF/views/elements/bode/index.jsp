<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
	.bode-list {
		height: 35vh;
		overflow-y: scroll;
	}
	
	.subject-list {
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
<div class="bode container-fluid" style="width:85%;">
	<div class="filter-wrapper d-flex justify-content-between mb-2">
		<div class="d-flex col-md-2">
			<select class="form-select" id="site" name="site">
				<option value="1">Cơ sở 1</option>
				<option value="2">Cơ sở 2</option>
			</select>
		</div>
		<div class="col-md-4">
			<form role="search" action="manage/category/search.htm">
				<input name="searchInput" class="form-control" type="search" placeholder="Tìm " aria-label="Search" style="width: 50%;">
			</form>
		</div>
		<div class="col-md-2">
			<form action="bode.htm">
				<select class="form-select chon-monhoc" id="monhoc" name="mamh" onchange="loadBoDes(this.value)">
					<option value="all" ${mamh=="all" ? 'selected' : '' }>Môn học: Tất cả</option>
					<c:forEach var="mh" items="${monhocs}">
						<option value="${mh.MAMH}" ${mh.MAMH==mamh ? 'selected' : '' }>
							${mh.MAMH} (${mh.TENMH})</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="">
			<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-bode">
				Thêm bộ đề
			</button>
			<div class="modal fade" id="add-bode" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<form method="POST" action="bode/add-bode.htm" class="form-control">
							<div class="mb-3">
								<label >Môn học</label>
								<select class="form-select" id="monhoc" name="mamh">
									<c:forEach var="mh" items="${monhocs}">
										<option value="${mh.MAMH}">
											${mh.MAMH} (${mh.TENMH})</option>
									</c:forEach>
								</select>
							</div>
							<div class="mb-3">
								<label>Trình độ</label>
								<select class="form-select" name="trinhdo">
									<option value="A">Đại học, chuyên ngành</option>
									<option value="B">Đại học, không chuyên ngành</option>
									<option value="C">Cao đẳng</option>
								</select>
							</div>
							<div class="mb-3">
								<label>Nội dung: </label>
								<textarea name="noidung" class="form-control" placeholder="Nội dung câu hỏi"  style="height: 70px"></textarea>
							</div>
							<div class="mb-3">
								<label>A: </label>
								<textarea name="A" class="form-control" placeholder="Nội dung đáp án A"  style="height: 70px"></textarea>
							</div>
							<div class="mb-3">
								<label>B: </label>
								<textarea name="B" class="form-control" placeholder="Nội dung đáp án B"  style="height: 70px"></textarea>
							</div>
							<div class="mb-3">
								<label>C: </label>
								<textarea name="C" class="form-control" placeholder="Nội dung đáp án C"  style="height: 70px"></textarea>
							</div>
							<div class="mb-3">
								<label>D: </label>
								<textarea name="D" class="form-control" placeholder="Nội dung đáp án D"  style="height: 70px"></textarea>
							</div>
							<div class="mb-3">
								<label>Đáp án</label>
								<select class="form-select" name="dapan">
									<option value="A">A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
								</select>
							</div>
							<button class="btn btn-primary mt-2" type="submit" data-bs-dismiss="modal">Save</button>
							<button type="button" class="btn btn-secondary mt-2" data-bs-dismiss="modal">Close</button>
						</form>
					</div>
				</div>
			</div>
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Undo</button></a>
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">In danh
					sách bộ đề</button></a>
		</div>
	</div>
	<div class="note d-flex gap-3">
		<h6 class="fst-italic" style="margin-top: 0.15rem;">Trình độ:</h6>
		<p>A: Đại học, chuyên ngành</p>
		<p>B: Đại học, không chuyên ngành</p>
		<p>C: Cao đẳng</p>
	</div>
	<div class="bode-list">
		<jsp:include page="./bode_list.jsp" />
	</div>
	<div class="subject-list mt-4">
		<table class="table subject-table">
			<thead>
				<tr>
					<th scope="col">Mã môn học</th>
					<th scope="col">Tên môn học</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="mh" items="${monhocs}">
					<tr class="is-action sl-${mh.MAMH}" onclick="toggleAndLoad('${mh.MAMH}')">
						<td>${mh.MAMH}</td>
						<td>${mh.TENMH}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<script>
	function loadBoDes(value) {
		fetch('bode/get-bode-by-monhoc.htm', {
				method: 'POST',
				body: JSON.stringify({
					mamh: value
				})
			})
			.then(response => response.text())
			.then(data => {
				const userBar = document.querySelector('.bode-list');
				userBar.innerHTML = data;
				
				const selectElement = document.querySelector('.chon-monhoc');
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
