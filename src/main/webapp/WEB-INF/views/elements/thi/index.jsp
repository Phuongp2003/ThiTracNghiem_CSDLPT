<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<style>
	.form-thi {
		display: none;
	}
	
	.form-thi.active {
		display: block;
	}
</style>

<div class="thi container-fluid" style="width:55%;">
	<div class="info-sv fw-bold d-flex gap-5">
		<h5 class="text-capitalize">Sinh viên: ${sv.HO} ${sv.TEN}</h5>
		<h5>Mã số: ${sv.MASV}</h5>
		<h5>Lớp: ${sv.MALOP} (${lop.TENLOP})</h5>
	</div>
	<div class="mt-4">
		<p class="fst-italic">Chọn môn học, ngày thi và lần thi để bắt đầu</p>
		<div class="mb-3">
			<label>Môn học</label>
			<select class="form-select" id="monhoc" name="mamh" onchange="chonMonThi('f-'+this.value)">
				<option value="">--- Hãy chọn môn thi ---</option>
				<c:forEach var="mh" items="${monthi}">
					<option value="${mh.maMon}">
						${jdbc.getMonHoc(mh.maMon).getTENMH()}
					</option>
				</c:forEach>
			</select>
		</div>
		<c:forEach var="mh" items="${monthi}">
			<form method="POST" action="thi/start-exam.htm" id="f-${mh.maMon}" class="form-thi">
				<input type="text" value="${mh.maMon}" name="mamh" class="d-none">
				<div class="mb-3">
					<label>Ngày thi</label>
					<input type="date" name="ngaythi" class="form-control ngay-thi-input" value="${mh.ngayThi}" readonly>
				</div>
				<div class="mb-3">
					<label>Lần thi</label>
					<input type="number" name="lanthi" class="form-control" max="2" min="1" value="${mh.lanThi}" readonly>
				</div>
				<c:if test="${trangthai.get(mh.maMon.trim()) == 'CHUATHI'}">
					<button type="submit" class="btn btn-primary submit-form">Bắt đầu thi</button>
				</c:if>
				<c:if test="${trangthai.get(mh.maMon.trim()) == 'DANGTHI'}">
					<button type="submit" class="btn btn-primary submit-form">Tiếp tục thi</button>
				</c:if>
				<c:if test="${trangthai.get(mh.maMon.trim()) == 'DATHI'}">
					<button type="submit" class="btn btn-primary submit-form2">Xem kết quả</button>
				</c:if>
			</form>
		</c:forEach>
	</div>
</div>

<script>
	const forms = document.querySelectorAll('.form-thi');
	
	function chonMonThi(value) {
		const form = document.getElementById(value);
		
		forms.forEach(e => {
			e.classList.remove('active');
		})
		form.classList.add('active')
	}
	
	function disabledThiBtn() {
		var today = new Date();
		var dd = String(today.getDate()).padStart(2, '0');
		var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
		var yyyy = today.getFullYear();
		today = yyyy + '-' + mm + '-' + dd;
		forms.forEach(e => {
			var ngayThi = e.querySelector('.ngay-thi-input').value;
			const btn = e.querySelector('.submit-form');
			if (today !== ngayThi)
				btn.disabled = true;
			else
				btn.disabled = false;
		})
	}
	
	setInterval(disabledThiBtn(), 2000);
</script>
