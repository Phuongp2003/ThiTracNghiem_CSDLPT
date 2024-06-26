<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<style>
	.exam-controller {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		gap: 2px 1px;
	}
	
	.question-select {
		width: 4.927%;
		max-width: 4.927%;
	}
	
	.question-wrap {
		display: none;
	}
	
	.question-wrap.current {
		display: block;
	}
	
	.question-select.current {
		border: blue 2px solid;
	}
	
	.question-select.done {
		background-color: aqua;
		color: black;
	}
</style>

<div class="start-exam container-fluid mt-4" style="width: 75%;">
	<div class="navbar bg-body-tertiary d-flex justify-content-between sticky-top">
		<button type="button" class="btn btn-danger">Thoát</button>
		<h5>Sinh viên: ${sv.HO} ${sv.TEN} - MSSV: ${sv.MASV}</h5>
		<div class="d-flex gap-3">
			<div class="time mt-1"><i class="bi bi-clock h5"></i><span class="fs-5"> 40:00</span></div>
			<button type="button" class="btn btn-primary">Nộp bài</button>
		</div>
	</div>
	<div class="exam-controller">
		<c:forEach var="cauhoi" items="${deThi}" varStatus="status">
			<button type="button" class="btn btn-secondary question-select" id="qnc-${status.index + 1}" onclick="selectQuestion(`${status.index + 1}`)">${status.index + 1}</button>
		</c:forEach>
	</div>
	<div class="bg-body-secondary mt-4 p-2 grid">
		<c:forEach var="cauhoi" items="${deThi}" varStatus="status">
			<div class="question-wrap" id="qn-${status.index + 1}">
				<div class="question">
					<h6> <span>Câu ${status.index + 1}:</span> ${cauhoi.NOIDUNG}</h6>
					<p><span class="fw-bold">A. </span>${cauhoi.getA()}</p>
					<p><span class="fw-bold">B. </span>${cauhoi.getB()}</p>
					<p><span class="fw-bold">C. </span>${cauhoi.getC()}</p>
					<p><span class="fw-bold">D. </span>${cauhoi.getD()}</p>
				</div>
				<div class="answer d-flex gap-3" id="qnsl-${status.index + 1}">
					<input type="checkbox" class="btn-check" id="answer-a-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`)">
					<label class="btn btn-outline-primary" for="answer-a-${status.index + 1}">A</label>
					<input type="checkbox" class="btn-check" id="answer-b-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`)">
					<label class="btn btn-outline-primary" for="answer-b-${status.index + 1}">B</label>
					<input type="checkbox" class="btn-check" id="answer-c-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`)">
					<label class="btn btn-outline-primary" for="answer-c-${status.index + 1}">C</label>
					<input type="checkbox" class="btn-check" id="answer-d-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`)">
					<label class="btn btn-outline-primary" for="answer-d-${status.index + 1}">D</label>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<script>
	// document.addEventListener('contextmenu', function(event) {
	// 	event.preventDefault();
	// });
	// document.addEventListener('keydown', function(event) {
	// 	if (event.key === 'F12' || (event.ctrlKey && event.shiftKey && (event.key === 'I' || event.key === 'J' || event.key === 'C'))) {
	// 		event.preventDefault();
	// 	}
	// });
	
	// Select the elements by ID
	const qnElements = document.getElementsByClassName('question-wrap');
	const qncElements = document.getElementsByClassName('question-select');
	
	function selectQuestion(value) {
		let qnId = 'qn-' + value;
		let qncId = 'qnc-' + value;
		let qnElement = document.getElementById(qnId);
		let qncElement = document.getElementById(qncId);
		
		Array.from(qnElements).forEach(element => {
			element.classList.remove('current');
		});
		
		Array.from(qncElements).forEach(element => {
			element.classList.remove('current');
		});
		
		if (qnElement) qnElement.classList.add('current');
		if (qncElement) qncElement.classList.add('current');
	}
	
	selectQuestion(1)
	
	function handleQuestionSelected(index) {
		const listA = document.getElementById('qnsl-' + index);
		const question = document.getElementById('qn-' + index);
		const questionControl = document.getElementById('qnc-' + index);
		
		if (listA) {
			listA.addEventListener('change', function(event) {
				if (event.target.type === 'checkbox') {
					const checkedCheckboxes = listA.querySelectorAll('input[type="checkbox"]:checked');
					if (checkedCheckboxes.length > 1) {
						checkedCheckboxes.forEach((checkbox) => {
							// Uncheck all checkboxes except the one that triggered the event
							if (checkbox !== event.target) {
								checkbox.checked = false;
							}
						});
					}
					if (checkedCheckboxes.length > 0) {
						question.classList.add('done');
						questionControl.classList.add('done');
					} else {
						question.classList.remove('done');
						questionControl.classList.remove('done');
					}
				}
			});
		}
	}
</script>
