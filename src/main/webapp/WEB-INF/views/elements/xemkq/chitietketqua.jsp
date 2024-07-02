<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<style>
	.ketquathi {
		width: 80%;
		margin: 0 auto;
		position: relative;
	}
	
	._2-row-info {
		min-width: 600px;
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
	
	.res {
		position: sticky;
		bottom: 0;
	}
	
	.bg-red {
		background: rgba(255, 0, 0, .4) !important;
	}
	
	.bg-green {
		background: rgba(0, 255, 0, .4) !important;
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
		<div class="row _2-row-info">
			<div class="ngaythi col-6">
				Ngày thi: ${kq.getNgayThiF()}
			</div>
			<div class="lanthi col-6">
				Lần thi: ${kq.LAN}
			</div>
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
		<tbody>
			<c:forEach var="item" items="${kq.chiTietDapAn}" varStatus="status">
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
					<td class="text-uppercase ${(item.DAPANDUNG.equals(item.DAPANSV)) ? 'bg-green' : 'bg-red'}">${item.DAPANDUNG}</td>
					<td class="text-uppercase ${(item.DAPANDUNG.equals(item.DAPANSV)) ? 'bg-green' : 'bg-red'}">${item.DAPANSV}</td>
				</tr>
			</c:forEach>
			<tr class="res">
				<td></td>
				<td></td>
				<td></td>
				<td style="font-weight: 500; font-size: 18px;">Kết quả: ${kq.getSoCauDung()}/${kq.getTongSoCau()}</td>
				<td colspan="2" style="font-weight: 500; font-size: 18px;">Điểm số: ${kq.DIEM}</td>
			</tr>
		</tbody>
	</table>
	
</div>
