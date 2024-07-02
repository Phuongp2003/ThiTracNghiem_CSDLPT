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
	<div class="mt-4">
		<div class="mt-4">
			<p class="fst-italic">Chọn lớp, môn học và lần thi để bắt đầu thi thử</p>
			<div class="mb-3">
				<label>Môn học</label>
				<select class="form-select" id="monhoc" name="mamh" onchange="chonMonThi('f-'+this.value)">
					<option value="">--- Hãy chọn môn thi ---</option>
					<c:forEach var="mh" items="${monthi}">
						<option value="${mh.maMon.trim()}-${mh.lanThi}">
							${jdbc.getMonHoc(mh.maMon).getTENMH()} | ${jdbc2.getLop(mh.lop).getTENLOP()} | Lần ${mh.lanThi}
						</option>
					</c:forEach>
				</select>
			</div>
			<c:forEach var="mh" items="${monthi}">
				<form method="POST" action="thithu/start.htm" id="f-${mh.maMon.trim()}-${mh.lanThi}" class="form-thi">
					<input type="text" value="${mh.maMon}" name="mamh" class="d-none">
					<div class="mb-3">
						<label>Ngày thi</label>
						<input type="date" name="ngaythi" class="form-control ngay-thi-input" value="${mh.ngayThi}" readonly>
					</div>
					<div class="mb-3">
						<label>Lớp</label>
						<input type="tẽt" name="lop" class="form-control" value="${mh.lop}" readonly>
					</div>
					<div class="mb-3">
						<label>Lần thi</label>
						<input type="number" name="lanthi" class="form-control" max="2" min="1" value="${mh.lanThi}" readonly>
					</div>
					<button type="submit" class="btn btn-primary submit-form">Bắt đầu thi</button>
				</form>
			</c:forEach>
		</div>
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
</script>
