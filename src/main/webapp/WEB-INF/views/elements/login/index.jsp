<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<body class="d-flex align-items-center py-4 bg-body-tertiary">
	<style>
		html,
		body {
			height: 100%;
		}
		
		.form-signin {
			max-width: 330px;
			padding: 1rem;
		}
		
		.form-signin .form-floating:focus-within {
			z-index: 2;
		}
		
		.form-signin input[type="text"] {
			margin-bottom: -1px;
			border-bottom-right-radius: 0;
			border-bottom-left-radius: 0;
		}
		
		.form-signin input[type="password"] {
			margin-bottom: 10px;
			border-top-left-radius: 0;
			border-top-right-radius: 0;
		}
	</style>
	
	<main class="form-signin w-100 m-auto">
		<form action="auth/check-login.htm" method="POST">
			<img class="mb-4" src="resources/imgs/bootstrap-logo.svg" alt="" width="72" height="57">
			<h1 class="h3 mb-3 fw-normal">Hãy đăng nhập</h1>
			
			<div class="form-floating">
				<select class="form-select" id="usertype" name="usertype" required="true">
					<option value="">Chọn vai trò</option>
					<option value="GV">Giảng Viên</option>
					<option value="SV">Sinh Viên</option>
				</select>
				<label for="floatingInput">Cơ sở</label>
			</div>
			<div class="form-floating">
				<select class="form-select" id="site" name="site" required="true">
					<option value="">Chọn cơ sở</option>
					<option value="1">CS2</option>
					<option value="2">CS3</option>
				</select>
				<label for="floatingInput">Cơ sở</label>
			</div>
			<div class="form-floating">
				<input type="text" name="username" class="form-control" id="floatingInput" placeholder="username">
				<label for="floatingInput">Tên người dùng</label>
			</div>
			<div class="form-floating">
				<input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password">
				<label for="floatingPassword">Mật khẩu</label>
			</div>
			<c:if test="${not empty message}">
				<div class="alert alert-danger" role="alert">
					${message}
				</div>
			</c:if>
			<button class="btn btn-primary w-100 py-2" type="submit">Đăng nhập</button>
		</form>
	</main>
</body>
