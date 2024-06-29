<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
	.bode-table {
    	table-layout: fixed;
    	word-wrap: break-word;
	}
</style>
<table class="table bode-table">
	<thead>
		<tr>
			<th style="width: 5%">ID</th>
			<th style="width: 15%">Môn học</th>
			<th style="width: 7%">Trình độ</th>
			<th style="width: 28%">Nội dung</th>
			<th style="width: 15%">A</th>
			<th style="width: 15%">B</th>
			<th style="width: 15%">C</th>
			<th style="width: 15%">D</th>
            <th style="width: 7%">Đáp án</th>
			<c:if test="${role_al == 'TRUONG' || role_al == 'COSO'}"><th style="width: 12%">Giáo viên</th></c:if>
			<c:if test="${role_al == 'COSO' || role_al == 'GIANGVIEN'}">
				<th style="width: 12%">Thao tác</th>
			</c:if>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="bd" items="${bodes}">
			<tr>
				<td>${bd.CAUHOI}</td>
                <td>${monhocMap.get(bd.MAMH)}</td>
                <td>${bd.TRINHDO}</td>
                <td>${bd.NOIDUNG}</td>
                <td>${bd.getA()}</td>
                <td>${bd.getB()}</td>
                <td>${bd.getC()}</td>
                <td>${bd.getD()}</td>
                <td>${bd.DAP_AN}</td>
				<c:if test="${role_al == 'TRUONG' || role_al == 'COSO'}"><td>${giaovienMap.get(bd.MAGV)}</td></c:if>
				<c:if test="${role_al == 'COSO' || role_al == 'GIANGVIEN'}">
					<td>
						<a href="bode/delete-bode/${bd.CAUHOI}.htm" onclick="return confirm('Bạn có chắc muốn xóa câu ${bd.CAUHOI}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
						
						<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#edit-bode-${bd.CAUHOI}">
							<i class="bi bi-pencil-square"></i>
						</button>
						<div class="modal fade" id="edit-bode-${bd.CAUHOI}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form method="POST" action="bode/edit-bode.htm" class="form-control" target="formSubmitFrame">
										<input type="hidden" name="cauhoi" value="${bd.CAUHOI}" />
										<div class="mb-3">
											<label >Môn học</label>
											<select class="form-select" id="monhoc" name="mamh">
												<option value="${bd.MAMH}" ${mamh=='${bd.MAMH}' ? 'selected' : '' }>${monhocMap.get(bd.MAMH)}</option>
												<c:forEach var="mh" items="${monhocs}">
													<c:if test="${mh.MAMH != bd.MAMH}">
														<option value="${mh.MAMH}" ${mh.MAMH == '${bd.MAMH}' ? 'hidden' : '' }>${mh.TENMH}</option>
													</c:if>
												</c:forEach>
											</select>
										</div>
										<div class="mb-3">
											<label>Trình độ</label>
											<select class="form-select" name="trinhdo">
												<option value="${bd.TRINHDO}">
													<c:choose>
														<c:when test="${bd.TRINHDO == 'A'}">
															A (Đại học, chuyên ngành)
														</c:when>
														<c:when test="${bd.TRINHDO == 'B'}">
															B (Đại học, không chuyên ngành)
														</c:when>
														<c:otherwise>
															C (Cao đẳng)
														</c:otherwise>
													</c:choose>
												</option>
												
												<c:if test="${bd.TRINHDO != 'A'}">
													<option value="A">A (Đại học, chuyên ngành)</option>
												</c:if>
												<c:if test="${bd.TRINHDO != 'B'}">
													<option value="B">B (Đại học, không chuyên ngành)</option>
												</c:if>
												<c:if test="${bd.TRINHDO != 'C'}">
													<option value="C">C (Cao đẳng)</option>
												</c:if>
											</select>
										</div>
										<div class="mb-3">
											<label>Nội dung: </label>
											<textarea name="noidung" value="${bd.NOIDUNG}" class="form-control" placeholder="Nội dung câu hỏi"  style="height: 70px">${bd.NOIDUNG}</textarea>
										</div>
										<div class="mb-3">
											<label>A: </label>
											<textarea name="A" value="${bd.getA()}" class="form-control" placeholder="Nội dung đáp án A"  style="height: 70px">${bd.getA()}</textarea>
										</div>
										<div class="mb-3">
											<label>B: </label>
											<textarea name="B" value="${bd.getB()}" class="form-control" placeholder="Nội dung đáp án B"  style="height: 70px">${bd.getB()}</textarea>
										</div>
										<div class="mb-3">
											<label>C: </label>
											<textarea name="C" value="${bd.getC()}" class="form-control" placeholder="Nội dung đáp án C"  style="height: 70px">${bd.getC()}</textarea>
										</div>
										<div class="mb-3">
											<label>D: </label>
											<textarea name="D" value="${bd.getD()}" class="form-control" placeholder="Nội dung đáp án D"  style="height: 70px">${bd.getD()}</textarea>
										</div>
										<div class="mb-3">
											<label>Đáp án</label>
											<select class="form-select" name="dapan">
												<option value="${bd.DAP_AN}" selected>${bd.DAP_AN}</option>
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
					</td>
				</c:if>
			</tr>
		</c:forEach>
	</tbody>
</table>
