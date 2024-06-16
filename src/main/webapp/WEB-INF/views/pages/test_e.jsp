<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="student" items="${students}">
	<h2>Student Information</h2>
	<p>MASV: ${student.MASV}</p>
	<p>HO: ${student.HO}</p>
	<p>TEN: ${student.TEN}</p>
	<p>NGAYSINH: ${student.NGAYSINH}</p>
	<p>DIACHI: ${student.DIACHI}</p>
	<p>MALOP: ${student.MALOP}</p>
</c:forEach>
