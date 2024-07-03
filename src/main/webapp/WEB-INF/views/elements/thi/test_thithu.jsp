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
		<a href="thithu.htm">
			<button type="button" class="btn btn-danger">Thoát</button></a>
		<h5>Thi thử môn: ${jdbc.getMonHoc(monthi).getTENMH()}</h5>
		<div class="d-flex gap-3">
			<button type="button" class="btn btn-primary button-nopbai" onclick="check()">Kiểm tra đáp án</button>
			<button type="button" class="btn btn-primary button-nopbai" onclick="show()">Xem đáp án</button>
			<button type="button" class="btn btn-primary button-nopbai" onclick="reset()">Xóa đánh dấu</button>
		</div>
	</div>
	<div class="exam-controller">
		<c:forEach var="cauhoi" items="${deThi}" varStatus="status">
			<button type="button" class="btn btn-secondary question-select ${(cauhoi.getDAPANSV() != null && cauhoi.getDAPANSV() != '') ? 'done' : ''}" id="qnc-${status.index + 1}" onclick="selectQuestion(`${status.index + 1}`)">${status.index + 1}</button>
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
				<div class="answer d-flex gap-3 ${(cauhoi.getDAPANSV() != null && cauhoi.getDAPANSV() != '') ? 'done' : ''}" id="qnsl-${status.index + 1}">
					<input type="checkbox" class="btn-check ${cauhoi.getDAPANDUNG() == 'A' ? 'is-correct' : ''}" id="answer-a-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`, this)" ${cauhoi.getDAPANSV()=='A' ? 'checked' : '' }>
					<label class="btn btn-outline-primary" for="answer-a-${status.index + 1}">A</label>
					<input type="checkbox" class="btn-check ${cauhoi.getDAPANDUNG() == 'B' ? 'is-correct' : ''}" id="answer-b-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`, this)" ${cauhoi.getDAPANSV()=='B' ? 'checked' : '' }>
					<label class="btn btn-outline-primary" for="answer-b-${status.index + 1}">B</label>
					<input type="checkbox" class="btn-check ${cauhoi.getDAPANDUNG() == 'C' ? 'is-correct' : ''}" id="answer-c-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`, this)" ${cauhoi.getDAPANSV()=='C' ? 'checked' : '' }>
					<label class="btn btn-outline-primary" for="answer-c-${status.index + 1}">C</label>
					<input type="checkbox" class="btn-check ${cauhoi.getDAPANDUNG() == 'D' ? 'is-correct' : ''}" id="answer-d-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`, this)" ${cauhoi.getDAPANSV()=='D' ? 'checked' : '' }>
					<label class="btn btn-outline-primary" for="answer-d-${status.index + 1}">D</label>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<script>
	// handle chon dap an
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
	
	function handleQuestionSelected(index, element) {
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
	
	function applyStyles(element, styles) {
		Object.assign(element.style, styles);
	}
	
	function check() {
		Array.from(qnElements).forEach(element => {
			const index = element.id.match(/qn-(\d+)/);
			const controlE = document.querySelector('#qnc-' + index[1])
			
			const checkboxes = Array.from(element.getElementsByClassName('btn-check'));
			const checkedBox = checkboxes.find(checkbox => checkbox.checked);
			if (checkedBox) {
				const labelForCheckbox = document.querySelector('label[for=' + checkedBox.id + ']');
				if (checkedBox.classList.contains('is-correct')) {
					element.classList.add('correct');
					applyStyles(labelForCheckbox, {
						backgroundColor: 'green',
						color: 'black'
					})
					controlE.style.backgroundColor = 'green';
					controlE.style.color = 'black';
				} else {
					element.classList.add('incorrect');
					labelForCheckbox.style.backgroundColor = 'red';
					labelForCheckbox.style.color = 'white';
					controlE.style.backgroundColor = 'red';
					controlE.style.color = 'white';
				}
			} else {
				element.classList.add('missing');
				controlE.style.backgroundColor = 'purple';
				controlE.style.color = 'black';
			}
		})
	}
	
	function reset() {
		Array.from(qnElements).forEach(element => {
			element.classList.remove('correct', 'incorrect', 'missing');
			
			const index = element.id.match(/qn-(\d+)/);
			if (index) {
				const controlE = document.querySelector('#qnc-' + index[1]);
				if (controlE) {
					controlE.style.backgroundColor = '';
					controlE.style.color = '';
				}
			}
			
			const checkboxes = Array.from(element.getElementsByClassName('btn-check'));
			checkboxes.forEach(checkbox => {
				const labelForCheckbox = document.querySelector('label[for=' + checkbox.id + ']');
				if (labelForCheckbox) {
					labelForCheckbox.style.backgroundColor = '';
					labelForCheckbox.style.color = '';
				}
			});
		});
	}
	
	function show() {
		Array.from(qnElements).forEach(element => {
			const index = element.id.match(/qn-(\d+)/);
			const controlE = document.querySelector('#qnc-' + index[1])
			
			const checkboxes = Array.from(element.getElementsByClassName('btn-check'));
			const checkedBox = checkboxes.find(checkbox => checkbox.checked);
			const correctCheckedBox = checkboxes.find(checkbox => checkbox.classList.contains('is-correct'));
			const labelForCorrectCheckbox = document.querySelector('label[for=' + correctCheckedBox.id + ']');
			if (checkedBox) {
				const labelForCheckbox = document.querySelector('label[for=' + checkedBox.id + ']');
				if (checkedBox.classList.contains('is-correct')) {
					element.classList.add('correct');
					applyStyles(labelForCheckbox, {
						backgroundColor: 'green',
						color: 'black'
					})
					controlE.style.backgroundColor = 'green';
					controlE.style.color = 'black';
				} else {
					applyStyles(labelForCorrectCheckbox, {
						backgroundColor: 'green',
						color: 'black'
					})
					element.classList.add('incorrect');
					labelForCheckbox.style.backgroundColor = 'red';
					labelForCheckbox.style.color = 'white';
					controlE.style.backgroundColor = 'red';
					controlE.style.color = 'white';
				}
			} else {
				applyStyles(labelForCorrectCheckbox, {
					backgroundColor: 'green',
					color: 'black'
				})
				element.classList.add('missing');
				controlE.style.backgroundColor = 'purple';
				controlE.style.color = 'black';
			}
		})
	}
</script>
