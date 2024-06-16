<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="d-flex me-3 fs-5">
	<a href="auth/logout">
		<p><i class="bi bi-person"></i>
			Username: ${cookie.username.value} |
			Họ và tên: ${fullname} |
			Vai trò: ${role}
		</p>
	</a>
</div>
