<%@ page pageEncoding="UTF-8"%>
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
</style>
<div class="student container-fluid" style="width:85%;">
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
			<form id="lopForm" action="student.htm">
				<select class="form-select" id="lop" name="malop" onchange="loadStudents()">
					<option value="all" ${malop=="all" ? 'selected' : '' }>Lớp: Tất cả</option>
					<c:forEach var="l" items="${lops}">
						<option value="${l.MALOP}" ${l.MALOP==malop ? 'selected' : '' }>
							Mã lớp: ${l.MALOP} (${l.TENLOP})</option>
					</c:forEach>
				</select>
			</form>
		</div>
		<div class="">
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Thêm sinh viên</button></a>
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">Undo</button></a>
			<a href="manage/category/add-category"><button type="button" class="btn btn-outline-primary">In danh sách sinh viên</button></a>
		</div>
	</div>
	<jsp:include page="./student_list.jsp" />
	<div class="class-list mt-4">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Mã lớp</th>
					<th scope="col">Tên lớp</th>
					<th scope="col">Mã khoa</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="l" items="${lops}">
					<tr>
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
	function submitForm() {
		document.getElementById("lopForm").submit();
	}
	function loadStudents() {
	fetch('student/get-sv-by-lop.htm', {
			method: 'POST',
			body: JSON.stringify({
				malop: 'TH06'
			})
		})
		.then(response => response.text())
		.then(data => {
			const userBar = document.querySelector('.student-list');
			userBar.innerHTML = data;
		})
		.catch(error => {
			console.error('Error:', error);
		});}
</script>
