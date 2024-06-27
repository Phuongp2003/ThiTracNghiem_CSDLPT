<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<style>
	.block-exam {
		z-index: 1005;
		position: absolute;
		width: 100%;
		height: 100%;
		top: 0;
		left: 0;
		background-color: inherit;
		display: block;
	}
	
	.block-exam .title {
		position: absolute;
		font-size: 30px;
		font-weight: bold;
		z-index: 1006;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
	}
	
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
<div class="block-exam">
	<div class="title">
		Hãy chờ đến thời gian làm bài!
	</div>
</div>
<div class="start-exam container-fluid mt-4" style="width: 75%;">
	<div class="navbar bg-body-tertiary d-flex justify-content-between sticky-top">
		<a href="thi.htm">
			<button type="button" class="btn btn-danger">Thoát</button></a>
		<h5>Sinh viên: ${sv.HO} ${sv.TEN} - MSSV: ${sv.MASV}</h5>
		<div class="d-flex gap-3">
			<div class="time mt-1"><i class="bi bi-clock h5"></i><span class="fs-5" id="examTimer"> 40:00 </span></div>
			<button type="button" class="btn btn-primary button-nopbai" onclick="submitExam()">Nộp bài</button>
		</div>
	</div>
	<div class="exam-controller">
		<c:forEach var="cauhoi" items="${deThi}" varStatus="status">
			<button type="button" class="btn btn-secondary question-select ${(cauhoi.getDAPAN() != null && cauhoi.getDAPAN() != '') ? 'done' : ''}" id="qnc-${status.index + 1}" onclick="selectQuestion(`${status.index + 1}`)">${status.index + 1}</button>
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
				<div class="answer d-flex gap-3 ${(cauhoi.getDAPAN() != null && cauhoi.getDAPAN() != '') ? 'done' : ''}" id="qnsl-${status.index + 1}">
					<input type="checkbox" class="btn-check" id="answer-a-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`, `${cauhoi.getCAUHOI()}`, `A`, this)" ${cauhoi.getDAPAN()=='A' ? 'checked' : '' }>
					<label class="btn btn-outline-primary" for="answer-a-${status.index + 1}">A</label>
					<input type="checkbox" class="btn-check" id="answer-b-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`, `${cauhoi.getCAUHOI()}`, `B`, this)" ${cauhoi.getDAPAN()=='B' ? 'checked' : '' }>
					<label class="btn btn-outline-primary" for="answer-b-${status.index + 1}">B</label>
					<input type="checkbox" class="btn-check" id="answer-c-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`, `${cauhoi.getCAUHOI()}`, `C`, this)" ${cauhoi.getDAPAN()=='C' ? 'checked' : '' }>
					<label class="btn btn-outline-primary" for="answer-c-${status.index + 1}">C</label>
					<input type="checkbox" class="btn-check" id="answer-d-${status.index + 1}" autocomplete="off" onchange="handleQuestionSelected(`${status.index + 1}`, `${cauhoi.getCAUHOI()}`, `D`, this)" ${cauhoi.getDAPAN()=='D' ? 'checked' : '' }>
					<label class="btn btn-outline-primary" for="answer-d-${status.index + 1}">D</label>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<script>
	var isDone = false;
	if (`${trangthaithi}` === 'DATHI') isDone = true;
	
	function getCookieValue(cookieName) {
		let name = cookieName + "=";
		let decodedCookie = decodeURIComponent(document.cookie);
		let ca = decodedCookie.split(';');
		for (let i = 0; i < ca.length; i++) {
			let c = ca[i];
			while (c.charAt(0) === ' ') {
				c = c.substring(1);
			}
			if (c.indexOf(name) === 0) {
				return c.substring(name.length, c.length);
			}
		}
		return "";
	}
	
	async function layKetQua() {
		isDone = true;
		return await fetch('thi/submit-exam.htm', {
				method: 'POST',
				body: 'thong tin bai thi'
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
				return response.text();
			})
			.catch(error => {
				console.error('Error:', error);
			});
	}
	
	function submitExam() {
		if (confirm("Bạn có chắc là muốn nộp bài?")) {
			if (confirm("Bạn sẽ không thể hoàn tác bài thi!")) {
				isDone = true;
			}
		}
	}
	// deny chinh sua trang web
	document.addEventListener('contextmenu', function(event) {
		event.preventDefault();
	});
	document.addEventListener('keydown', function(event) {
		if (event.key === 'F12' || (event.ctrlKey && event.shiftKey && (event.key === 'I' || event.key === 'J' || event.key === 'C'))) {
			event.preventDefault();
		}
	});
	
	// Thoi gian thi
	fetch("thi/time-exam.htm", {
			method: 'POST',
		})
		.then(response => {
			if (!response.ok) {
				throw new Error(`HTTP error! status: ${response.status}`);
			}
		})
		.catch(error => {
			console.error('Error:', error);
			alert('Có lỗi xảy ra!');
		});
	
	
	async function updateTimer() {
		await fetch("thi/time-exam.htm", {
				method: 'POST',
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert('Có lỗi xảy ra!');
			});
		var giobatdauthi = new Date(getCookieValue("ngaythi") + 'T' + getCookieValue("giothi"));
		var thoigianthi = parseInt(getCookieValue("thoigian"));
		var giohientai = new Date();
		var ketthucthi = new Date(giobatdauthi.getTime() + thoigianthi * 60000);
		const blockE = document.querySelector('.block-exam');
		const btnNopBai = document.querySelector('.button-nopbai');
		
		var now = new Date();
		var remainingTime = ketthucthi - now;
		if (remainingTime > thoigianthi * 60000) {
			remainingTime = remainingTime - thoigianthi * 60000;
			blockE.style.display = 'block';
			btnNopBai.disabled = true;
		} else {
			btnNopBai.disabled = false;
			blockE.style.display = 'none';
		}
		if (remainingTime >= 0) {
			var minutes = Math.floor((remainingTime % (1000 * 60 * 300)) / (1000 * 60));
			var seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);
			
			document.getElementById("examTimer").textContent = minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
		} else {
			document.getElementById("examTimer").textContent = "Hết giờ!";
			blockE.style.display = 'block';
			blockE.innerHTML = await layKetQua();
			btnNopBai.disabled = true;
			isDone = true;
		}
	}
	
	async function showResult() {
		const blockE = document.querySelector('.block-exam');
		blockE.style.display = 'block';
		blockE.innerHTML = await layKetQua();
		const btnNopBai = document.querySelector('.button-nopbai');
		btnNopBai.disabled = true;
		isDone = true;
	}
	if (!isDone)
		setInterval(updateTimer, 500);
	else {
		showResult();
	}
	
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
	
	function handleQuestionSelected(index, q, a, element) {
		const listA = document.getElementById('qnsl-' + index);
		const question = document.getElementById('qn-' + index);
		const questionControl = document.getElementById('qnc-' + index);
		if (element.checked)
			submitSingle(q, a)
		else
			submitSingle(q, '')
		
		
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
	
	function submitSingle(q, a) {
		fetch("thi/submit-question.htm", {
				method: 'POST',
				body: JSON.stringify({
					cauhoi: q,
					dapan: a
				})
			})
			.then(response => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
			})
			.catch(error => {
				console.error('Error:', error);
				alert('Có lỗi xảy ra!');
			});
	}
</script>
