<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="container-fluid" style="width: 80%;">
	<table class="table-score table">
		<h5 class="text-center fw-bold text-uppercase">BẢNG ĐIỂM MÔN ${monhoc.TENMH} CỦA LỚP ${lop.TENLOP}</h5>
		<thead>
			<tr>
				<th scope="col">MASV</th>
				<th scope="col">HỌ TÊN</th>
				<th scope="col">ĐIỂM</th>
				<th scope="col">ĐIỂM CHỮ</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="b" items="${bangdiems}">
				<tr>
					<td>${b[0]}</td>
					<td>${b[1]}</td>
					<td>${b[2]}</td>
					<td>${b[3]}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<c:if test="${empty bangdiems}">
		<h5 class="text-center">Chưa lên lịch thi!</h5>
	</c:if>
</div>
