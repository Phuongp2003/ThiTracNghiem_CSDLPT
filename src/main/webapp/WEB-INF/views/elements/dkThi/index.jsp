<%@ page pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div class="dkthi container-fluid" style="width:65%;">
  <h5>Tạo lịch thi</h5>
  <form method="POST" action="dkthi/add-dkthi.htm">
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
            ${mh.MAMH} (${mh.TENMH})</option>
        </c:forEach>
      </select>
    </div>
    <div class="mb-3">
      <label>Trình độ</label>
      <select class="form-select" name="trinhdo">
        <option value="A">Đại học, chuyên ngành</option>
        <option value="B">Đại học, không chuyên ngành</option>
        <option value="C">Cao đẳng</option>
      </select>
    </div>
    <div class="mb-3">
      <label>Lần thi</label>
      <input type="number" name="lanthi" class="form-control" max="2" min="1">
    </div>
    <div class="mb-3">
      <label>Số câu thi</label>
      <input type="number" name="socauthi" class="form-control" min="1">
    </div>
    <div class="mb-3">
      <label>Ngày thi</label>
      <input type="date" name="ngaythi" class="form-control">
    </div>
    <div class="mb-3">
      <label>Thời gian thi</label>
      <input type="number" name="thoigianthi" max="60" min="2" class="form-control">
    </div>
    <button type="submit" class="btn btn-primary">Save</button>
  </form>
</div>