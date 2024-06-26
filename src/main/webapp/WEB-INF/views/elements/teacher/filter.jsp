<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<style>

</style>

<c:if test="${role_al == 'TRUONG'}">
	<div class="d-flex col-md-2">
			<select class="form-select" id="site" name="site" onchange="checkSite(this.value)">
				<c:forEach var="cs" items="${sites}">
					<option value="${currentSite==cs.tenServer ? 'current' : 'diff' }" ${currentSite==cs.tenServer ? 'selected' : '' }>${cs.tenCS}</option>
				</c:forEach>
			</select>
	</div>
</c:if>
<div class="col-md-3">
	<input name="searchInput" class="form-control" type="search" placeholder="Tìm mã, tên, khoa..." 
		aria-label="Search" style="width: 80%;" onchange="searchTeachers(this.value)">
</div>
<div class="col-md-2">
	<select class="form-select chon-khoa" id="khoa" name="makhoa" onchange="loadTeachers(this.value)">
		<option value="all" ${makhoa=="all" ? 'selected' : '' }>Khoa: Tất cả</option>
		<c:forEach var="k" items="${khoas}">
			<option value="${k.MAKH}" ${k.MAKH==makhoa ? 'selected' : '' }>
				${k.getFullName()}
			</option>
		</c:forEach>
	</select>
</div>
<div class="d-flex justify-content-end">
	<c:if test="${role_al != 'TRUONG' && role_al != 'GIANGVIEN'}">
		<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#add-student">
			Thêm giáo viên
		</button>
		<div class="action-btn-group d-inline">
			<jsp:include page="./button_action_list.jsp" />
		</div>
	</c:if>
	<iframe id="message-iframe" name="formSubmitFrame" src="about:blank" style="display: none;" onload="refreshData()"></iframe>
	<button type="button" class="btn btn-outline-primary" onclick="refreshData()">Reload</button>
</div>
