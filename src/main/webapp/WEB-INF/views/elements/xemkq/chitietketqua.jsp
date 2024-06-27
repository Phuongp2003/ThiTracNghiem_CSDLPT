<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<style>
	.ketquathi {
		width: 80%;
		margin: 0 auto;
		position: relative;
	}
	
	.kqt-title {
		font-size: 18px;
		width: MAX-CONTENT;
		margin: 0 0 15px;
	}
	
	.kqthi-table {
		position: absolute;
		top: 120px;
		left: 0;
		width: 100%;
	}
	
	.ans {
		text-wrap: wrap;
	}
</style>

<div class="ketquathi">
	<div class="kqt-title">
		<div class="lop">
			Lớp: ${kq.LOP}
		</div>
		<div class="hoten">
			Họ và tên: ${kq.HOTEN}
		</div>
		<div class="monhoc">
			Môn thi: ${kq.TENMH}
		</div>
		<div class="ngaythi">
			Ngày thi: ${kq.getNgayThiF()}
		</div>
	</div>
	<table class="table kqthi-table">
		<thead>
			<tr style="position: sticky; top: 0;">
				<th scope="col" style="width: 5%;">STT</th>
				<th scope="col" style="width: 5%;">Câu số</th>
				<th scope="col" style="width: 45%;">Nội dung</th>
				<th scope="col" style="width: 32%;">Chọn lựa</th>
				<th scope="col" style="width: 5%;">Đáp án</th>
				<th scope="col" style="width: 8%;">Đã chọn</th>
			</tr>
		</thead>
		<c:forEach var="item" items="${kq.chiTietDapAn}" varStatus="status">
			<tbody>
				<tr class="">
					<td scope="row">${status.index + 1}</td>
					<td>${item.CAUHOI}</td>
					<td>${item.NOIDUNG}</td>
					<td class="ans">
						A. ${item.getA()} <br>
						B. ${item.getB()} <br>
						C. ${item.getC()} <br>
						D. ${item.getD()}
					</td>
					<td>${item.DAPANDUNG}</td>
					<td>${item.DAPANSV}</td>
				</tr>
			</tbody>
		</c:forEach>
	</table>
	
</div>
