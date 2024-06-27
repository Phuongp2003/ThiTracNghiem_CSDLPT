<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
	.cart-icon {
		position: relative;
		display: inline-block;
	}
	
	.cart-count {
		position: absolute;
		top: -8px;
		right: -8px;
		background-color: red;
		color: white;
		border-radius: 50%;
		padding: 2px 6px;
		font-size: 12px;
		font-weight: bold;
	}
</style>
<nav class="navbar navbar-light bg-light fs-3 bg-body-tertiary">
	<div class="container-fluid flex-row-reverse mx-auto justify-content-start w-75">
		<div class="user-bar"></div>
		<c:if test="${empty cookie.username}">
			<div class="d-flex me-3"><a href="auth/login"><i class="bi bi-person"></i></a></div>
		</c:if>
	</div>
</nav>
<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top fs-3 bg-body-tertiary">
	<div class="container-fluid mx-auto w-75">
		<a class="navbar-brand" href="home.htm"> <img src="resources/imgs/ptitlogo.png" alt="Navbar Brand" srcset=""> </a>
		<button class="navbar-toggler" type="button" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav navbar-functions ms-auto mb-2 mb-lg-0 fs-5 gap-3">
			</ul>
		</div>
	</div>
</nav>

<script>
	fetch('auth/user-info.htm', {
			method: 'POST'
		})
		.then(response => response.text())
		.then(data => {
			const userBar = document.querySelector('.user-bar');
			userBar.innerHTML = data;
		})
		.catch(error => {
			console.error('Error:', error);
		});
	
	fetch('function-filter.htm', {
			method: 'POST'
		})
		.then(response => response.text())
		.then(data => {
			const functionbar = document.querySelector('.navbar-functions');
			functionbar.innerHTML = data;
		})
		.catch(error => console.log('Error: ', error))
</script>
