<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<c:if test="${not empty e_message}">
	<div id="error_messase_box" class="alert alert-danger alert-dismissible d-flex align-items-center" role="alert">
		<svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Danger:">
			<use xlink:href="#exclamation-triangle-fill" />
		</svg>
		<div id="error_message">
			${e_message}
		</div>
		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>
	
	<style>
		.alert {
			width: max-content;
			max-width: 600px;
			padding-right: 70px;
			position: absolute;
			top: 60px;
			z-index: 2000;
			left: 20px;
		}
	</style>
	
	<script>
		const message = document.getElementById('error_message');
		const mess_box = document.getElementById('error_messase_box');
		if (message.innerHTML.trim() === '') {
			mess_box.style.setProperty('display', 'none', 'important');
		}
	</script>
</c:if>
