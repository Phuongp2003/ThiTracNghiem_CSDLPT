<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<c:if test="${role == 'COSO' || role == 'GIANGVIEN' || role == 'TRUONG'}">
	<li class="nav-item">
		<a class="nav-link" href="teacher.htm">Giáo viên</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" href="student.htm">Sinh viên</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" href="subject.htm">Môn học</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" href="department-class.htm">Khoa, lớp</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" href="bode.htm">Nhập đề</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" href="dkthi.htm">Chuẩn bị thi</a>
	</li>
</c:if>
<li class="nav-item">
	<a class="nav-link" href="thi.htm">Thi</a>
</li>
