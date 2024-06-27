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
		<p class="fst-italic">Chọn môn học để xem kết quả</p>
		
		<table class="table table-kqt">
			<thead>
				<tr>
					<th scope="col">Môn học</th>
					<th scope="col">Ngày thi</th>
					<th scope="col">Lần thi</th>
					<th scope="col">Xem</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="mh" items="${monthi}">
					<tr class="">
						<form method="POST" action="kqthi/get.htm" id="f-${mh.maMon}" class="form-thi">
							<td>
								<input class="form-control d-none" id="monhoc" name="mamh" value="${mh.maMon}" readonly>
								${jdbc.getMonHoc(mh.maMon).getTENMH()}
							</td>
							<td>
								<input type="date" name="ngaythi" class="form-control ngay-thi-input d-none" value="${mh.ngayThi}" readonly>${mh.ngayThi}
							</td>
							<td>
								<input type="number" name="lanthi" class="form-control d-none" max="2" min="1" value="${mh.lanThi}" readonly>${mh.lanThi}
							</td>
							<td>
								<button type="submit" class="btn btn-primary submit-form2">Xem kết quả</button>
							</td>
						</form>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		
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
