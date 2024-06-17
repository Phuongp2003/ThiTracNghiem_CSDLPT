<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div class="student-list">
    <table class="table">
        <thead>
            <tr>
                <th scope="col">Mã SV</th>
                <th scope="col">Họ</th>
                <th scope="col">Tên</th>
                <th scope="col">Ngày sinh</th>
                <th scope="col">Địa chỉ</th>
                <th scope="col">Mã lớp</th>
                <th scope="col">Mật khẩu</th>
                <th scope="col">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="sv" items="${sinhViens}">
                <tr>
                    <td>${sv.MASV}</td>
                    <td>${sv.HO}</td>
                    <td>${sv.TEN}</td>
                    <td>${sv.NGAYSINH}</td>
                    <td>${sv.DIACHI}</td>
                    <td>${sv.MALOP}</td>
                    <td>${sv.MATKHAU}</td>
                    <td>
                        <a href="manage/category/${category.MATL}/delete" onclick="return confirm('Bạn có chắc muốn xóa thể loại ${category.TENTL}?')"><button class="btn btn-outline-primary"><i class="bi bi-trash3-fill"></i></button></a>
                        <a href="manage/category/${category.MATL}/update"><button class="btn btn-outline-primary"><i class="bi bi-pencil-square"></i></button></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>