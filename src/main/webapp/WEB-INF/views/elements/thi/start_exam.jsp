<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="start-exam container-fluid mt-4" style="width: 75%;">
    <div class="navbar bg-body-tertiary d-flex justify-content-between sticky-top">
        <button type="button" class="btn btn-danger">Thoát</button>
        <h5>Sinh viên: ${sv.HO}  ${sv.TEN} - MSSV: ${sv.MASV}</h5>
        <div class="d-flex gap-3">
            <div class="time mt-1"><i class="bi bi-clock h5"></i><span class="fs-5"> 40:00</span></div>
            <button type="button" class="btn btn-primary">Nộp bài</button>
        </div>
    </div>
    <div class="bg-body-secondary mt-4 p-2 grid">
        <div class="question">
            <h6>1. kiến trúc mạng (network architechture) là:</h6>
            <p><span class="fw-bold">A. </span>tập các chức năng trong mạng</p>
            <p><span class="fw-bold">B. </span>tập các cấp và các protocol trong mỗi cấp</p>
            <p><span class="fw-bold">C. </span>tập các dịch vụ trong mạng</p>
            <p><span class="fw-bold">D. </span>tập các protocol trong mạng</p>
        </div>
        <div class="answer d-flex gap-3">
            <input type="checkbox" class="btn-check " id="answer-a"  autocomplete="off">
            <label class="btn btn-outline-primary" for="answer-a">A</label>
            <input type="checkbox" class="btn-check " id="answer-b"  autocomplete="off">
            <label class="btn btn-outline-primary" for="answer-b">B</label>
            <input type="checkbox" class="btn-check " id="answer-c"  autocomplete="off">
            <label class="btn btn-outline-primary" for="answer-c">C</label>
            <input type="checkbox" class="btn-check " id="answer-d"  autocomplete="off">
            <label class="btn btn-outline-primary" for="answer-d">D</label>
        </div>
    </div>
</div>