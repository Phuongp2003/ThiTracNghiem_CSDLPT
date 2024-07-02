<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<c:if test="${role_al == 'TRUONG'}">
	<div class="container d-flex justify-content-center align-items-center m-auto">
		<form method="POST" action="dkthi/dsdkthi.htm">
			<input type="hidden" id="startdate" name="startdate" />
			<input type="hidden" id="enddate" name="enddate" />
			<button type="submit" class="btn btn-primary mt-4 p-3">Xem danh sách đăng ký thi</button>
		</form>
	</div>
</c:if>
<div class="dkthi container-fluid d-flex gap-1" style="width:75%;">
	<div class="col-md-3 d-flex flex-column gap-2 fs-5">
		<c:if test="${role_al != 'TRUONG'}"><a href="dkthi.htm">Tạo lịch thi</a></c:if>
		<c:if test="${role_al != 'TRUONG'}">
			<form method="POST" action="dkthi/dsdkthi.htm">
				<input type="hidden" id="startdate" name="startdate" />
				<input type="hidden" id="enddate" name="enddate" />
				<button type="submit" class="btn btn-primary">Danh sách đăng ký thi</button>
			</form>
		</c:if>
	</div>
	<c:if test="${role_al != 'TRUONG'}">
		<div class="col-md-6">
			<div id="create-dkthi">
				<form method="POST" action="dkthi/add-dkthi.htm" id="add-form">
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
							<c:forEach var="mh" items="${monhocs}">
								<option value="${mh.MAMH}">
									${mh.TENMH}</option>
							</c:forEach>
						</select>
					</div>
					<div class="mb-3">
						<label>Trình độ</label>
						<select class="form-select" name="trinhdo">
							<option value="A">A (Đại học, chuyên ngành)</option>
							<option value="B">B (Đại học, không chuyên ngành)</option>
							<option value="C">C (Cao đẳng)</option>
						</select>
					</div>
					<div class="mb-3">
						<label>Lần thi</label>
						<select class="form-select" name="lanthi">
							<option value="1">1</option>
							<option value="2">2</option>
						</select>
					</div>
					<div class="mb-3">
						<label>Số câu thi</label>
						<input type="number" name="socauthi" class="form-control" min="1" required>
					</div>
					<div class="mb-3">
						<label>Ngày thi</label>
						<input type="date" name="ngaythi" class="form-control" id="date-val-h-tomorow" required>
					</div>
					<div class="mb-3">
						<label>Thời gian thi</label>
						<input type="number" name="thoigianthi" max="60" min="2" class="form-control" required>
					</div>
					<button type="button" onclick="submitClosestForm(this)" class="btn btn-primary">Đăng ký</button>
				</form>
			</div>
		</div>
	</c:if>
</div>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		var today = new Date();
		var dd = String(today.getDate()).padStart(2, '0');
		var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		var yyyy = today.getFullYear();
		today = yyyy + '-' + mm + '-' + dd;
		document.getElementById('startdate').value = today;
		document.getElementById('enddate').value = today;
		
	});
</script>
