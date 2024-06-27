<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid" style="width:75%;">
  <fmt:formatDate value="${startdate}" pattern="yyyy-MM-dd" var="formattedStartDate"/>
  <fmt:formatDate value="${enddate}" pattern="yyyy-MM-dd" var="formattedEndDate"/>
  <fmt:formatDate value="${startdate}" pattern="dd-MM-yyyy" var="from"/>
  <fmt:formatDate value="${enddate}" pattern="dd-MM-yyyy" var="to"/>
  <div class="filter">
    <form method="post" action="dkthi/dsdkthi.htm" class="d-flex gap-2">
      <div class="mb-3">
        <label>Từ ngày</label>
        <input type="date" name="startdate" value="${formattedStartDate}" class="form-control">
      </div>
      <div class="mb-3">
        <label>Đến ngày</label>
        <input type="date" name="enddate" value="${formattedEndDate}" class="form-control">
      </div>
      <div class="mt-4"><button type="submit" class="btn btn-primary">Lọc</button></div>
    </form>
  </div>
  <div class="list-dkthi mt-2">
    <h5 class="fw-bold text-center">DANH SÁCH ĐĂNG KÝ THI TRẮC NGHIỆM CƠ SỞ 1 TỪ NGÀY ${from}  ĐẾN NGÀY ${to}</h5>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">STT</th>
          <th scope="col">TÊN LỚP</th>
          <th scope="col">TÊN MÔN HỌC</th>
          <th scope="col">GIẢNG VIÊN ĐĂNG KÝ</th>
          <th scope="col">SỐ CÂU THI</th>
          <th scope="col">NGÀY THI</th>
          <th scope="col">ĐÃ THI</th>
          <th scope="col">GHI CHÚ</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="ds" items="${dsdk}" varStatus="loop">
          <tr>
            <td>${loop.index + 1}</td>
            <td>${ds[0]}</td>
            <td>${ds[1]}</td>
            <td>${ds[2]}</td>
            <td>${ds[3]}</td>
            <td>${ds[4]}</td>
            <td>${ds[5]}</td>
            <td></td>
          </tr>
        </c:forEach>
    </table>
    <h6 class="fw-bold">Tổng số lượt đăng ký: ${total}</h6>
  </div>
</div>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    var today = new Date();
    var dd = String(today.getDate()).padStart(2, '0');
    var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    var yyyy = today.getFullYear();
    today = yyyy + '-' + mm + '-' + dd;
    document.getElementById('startdate').value = today;
    document.getElementById('enddate').value = today;
  });
</script>