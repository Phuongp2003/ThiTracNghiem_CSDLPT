<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="thi container-fluid" style="width:75%;">
    <div class="info-sv fw-bold d-flex gap-5">
        <h5>Sinh viên: ${sv.HO} ${sv.TEN}</h5>
        <h5>Mã số: ${sv.MASV}</h5>
        <h5>Lớp: ${sv.MALOP} (${lop.TENLOP})</h5>
    </div>
    <div class="container-fluid mt-4" style="width:75%;">
        <p class="fst-italic">Chọn môn học, ngày thi và lần thi để bắt đầu</p>
        <form method="POST" action="thi/start-exam.htm">
            <div class="mb-3">
                <label>Môn học</label>
                <select class="form-select" id="monhoc" name="mamh">
                    <c:forEach var="mh" items="${monhocs}">
                        <option value="${mh.MAMH}">
                            ${mh.MAMH} (${mh.TENMH})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label>Ngày thi</label>
                <input type="date" name="ngaythi" class="form-control">
            </div>
            <div class="mb-3">
                <label>Lần thi</label>
                <input type="number" name="lanthi" class="form-control" max="2" min="1">
            </div>
            <button type="submit" class="btn btn-primary">Bắt đầu thi</button>
        </form>
    </div>
</div>