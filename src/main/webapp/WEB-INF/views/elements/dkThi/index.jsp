<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<style>
  #list-dkthi{
    display: none;
  }
  .dkthi .active{
    font-weight: bold;
    text-decoration: underline !important;
  }
</style>
<div class="dkthi container-fluid d-flex gap-1" style="width:75%;">
  <div class="col-md-3 d-flex flex-column gap-2 fs-5">
    <a href="#" id="create-dkthi-taga" class="active">Tạo lịch thi</a>
    <a href="#" id="list-dkthi-taga">Danh sách đăng ký thi</a>
  </div>
  <div class="col-md-6">
    <div id="create-dkthi">
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
                ${mh.TENMH}</option>
            </c:forEach>
          </select>
        </div>
        <div class="mb-3">
          <label>Trình độ</label>
          <select class="form-select" name="trinhdo">
            <option value="A">A (Đại học, chuyên ngành)</option>
            <option value="B">B (Đại học, không chuyên ngành)</option>
            <option value="C">C (Cao đẳng)</option>
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
        <button type="submit" class="btn btn-primary">Đăng ký</button>
      </form>
    </div>
    <div id="list-dkthi" style="width: 148%;">
      <div class="filter">
        <form method="POST" action="" class="d-flex gap-2">
          <div class="mb-3">
            <label>Từ ngày</label>
            <input type="date" name="startdate" value="23-06-2024" class="form-control">
          </div>
          <div class="mb-3">
            <label>Đến ngày</label>
            <input type="date" name="enddate" value="24-06-2024" class="form-control">
          </div>
          <div class="mt-4"><button type="submit" class="btn btn-primary">Lọc</button></div>
        </form>
      </div>
      <div class="list mt-2" style="margin-left: -18.5rem;">
        <h5 class="fw-bold text-center">DANH SÁCH ĐĂNG KÝ THI TRẮC NGHIỆM CƠ SỞ 1 TỪ NGÀY dd/mm/yyyy  ĐẾN NGÀY dd/mm/yyyy</h5>
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
            <c:forEach var="gvdk" items="${gvdks}">
              <tr>
                <th></th>
                <td>${gvdk.TENLOP}</td>
                <td>${gvdk.TENMH}</td>
                <td>${gvdk.HOTEN}</td>
                <td>${gvdk.SOCAUTHI}</td>
                <td>${gvdk.NGAYTHI}</td>
                <td>${gvdk.DATHI}</td>
                <td></td>
              </tr>
            </c:forEach>
        </table>
      </div>
    </div>
  </div>
</div>

<script>
  document.getElementById('create-dkthi-taga').addEventListener('click', function(event) {
      event.preventDefault();
      document.getElementById('create-dkthi').style.display = 'block';
      document.getElementById('list-dkthi').style.display = 'none';
      document.getElementById('create-dkthi-taga').classList.add('active');
      document.getElementById('list-dkthi-taga').classList.remove('active');
  });

  document.getElementById('list-dkthi-taga').addEventListener('click', function(event) {
      event.preventDefault();
      document.getElementById('create-dkthi').style.display = 'none';
      document.getElementById('list-dkthi').style.display = 'block';
      document.getElementById('create-dkthi-taga').classList.remove('active');
      document.getElementById('list-dkthi-taga').classList.add('active');
  });
</script>