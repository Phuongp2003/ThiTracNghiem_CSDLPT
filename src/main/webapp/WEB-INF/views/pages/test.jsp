<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
	
	<head>
		<title>${title}</title>
		<script>
			function loadStudents() {
				fetch('test.htm')
					.then(response => response.text())
					.then(data => {
						console.log("🚀 ~ loadStudents ~ data:", data)
						let studentList = document.getElementById('studentList');
						studentList.innerHTML = data;
					});
			}
		</script>
	</head>
	
	<body>
		<h1>${title}</h1>
		<p>Type: ${type}</p>
		
		<button onclick="loadStudents()">Load Students</button>
		
		<div id="studentList">
			<c:forEach var="student" items="${students}">
				<h2>Student Information</h2>
				<p>MASV: ${student.MASV}</p>
				<p>HO: ${student.HO}</p>
				<p>TEN: ${student.TEN}</p>
				<p>NGAYSINH: ${student.NGAYSINH}</p>
				<p>DIACHI: ${student.DIACHI}</p>
				<p>MALOP: ${student.MALOP}</p>
			</c:forEach>
		</div>
		
	</body>
	
</html>
