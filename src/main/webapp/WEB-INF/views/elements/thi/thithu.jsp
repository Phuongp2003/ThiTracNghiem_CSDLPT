<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="thi container-fluid" style="width:55%;">
    <div class="mt-4">
        <p class="fst-italic">Chọn lớp, môn học và lần thi để bắt đầu thi thử</p>
        <form method="POST" action="thi/start-exam.htm">
            <div class="mb-3">
                <label>Lớp</label>
                <select class="form-select" id="lop" name="malop">
                    <c:forEach var="l" items="${lops}">
                        <option value="${l.MALOP}">
                            ${l.MALOP} (${l.TENLOP})</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label>Môn học</label>
                <select class="form-select" id="monhoc" name="mamh">
                    <c:forEach var="mh" items="${monhocs}">
                        <option value="${mh.MAMH}">
                            ${mh.TENMH}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label>Lần thi</label>
                <input type="number" name="lanthi" class="form-control" max="2" min="1">
            </div>
            <button type="submit" class="btn btn-primary">Bắt đầu thi thử</button>
        </form>
    </div>
</div>