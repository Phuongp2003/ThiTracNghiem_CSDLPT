<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<style>
	.ketquathi {
		position: absolute;
		z-index: 1006;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 50%;
	}
	
	.kqt-title {
		font-size: 18px;
		width: MAX-CONTENT;
		margin: 0 auto 15px;
	}
	
	.kqt-title span {
		font-weight: bold;
	}
</style>

<div class="ketquathi">
	<div class="kqt-title">
		Chúc mừng <span>${kq.HOTEN}</span>, lớp <span>${kq.LOP}</span> <br>đã hoàn thành phần thi môn <span>${kq.TENMH}</span>
	</div>
	<table class="table">
		<thead>
			<tr>
				<th scope="col">Mã môn học</th>
				<th scope="col">Ngày thi</th>
				<th scope="col">Lần thi</th>
				<th scope="col">Điểm</th>
			</tr>
		</thead>
		<tbody>
			<tr class="">
				<td scope="row">${kq.MAMH}</td>
				<td>${kq.getNgayThiF()}</td>
				<td>${kq.LAN}</td>
				<td>${kq.DIEM}</td>
			</tr>
		</tbody>
	</table>
</div>
