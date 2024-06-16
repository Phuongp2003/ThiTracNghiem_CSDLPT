<details style="font-size: 15px;">
<summary style="font-size: 25px; font-weight: 700; color: blue">
    Tasks
</summary>

- [x] Khởi tạo dự án
- [x] Kết nối database, thử kết nối và lấy data
- [x] Tạo phần đăng nhập
- [x] Import bean
- [x] Thêm form mức đổ dữ liệu giáo viên, sinh viên, môn học, khoa-lớp 
    (sinh viên, môn học hoàn thiện nhất có lọc theo lớp, khoa)
- [ ] Chỉnh các connection thành global
- [ ] Login: chỉnh role thành check box
- [ ] Login: chỉnh danh sách phân mảnh lấy bằng cách dùng SP
- [ ] Form môn học: 
  - [ ] thêm
  - [ ] xóa
  - [ ] sửa
  - [ ] phục hồi
  - [ ] reload?
- [ ] Form khoa, lớp
  - [ ] Show song song 2 form
  - [ ] Khoa
    - [ ] Thêm
    - [ ] Xóa
    - [ ] Sửa
    - [ ] Phục hồi
    - [ ] Reload?
  - [ ] Lớp
    - [ ] Thêm
    - [ ] Xóa
    - [ ] Sửa
    - [ ] Phục hồi
    - [ ] Reload?
- [ ] Form sinh viên (của lớp)
  - [ ] Thêm
  - [ ] Xóa
  - [ ] Sửa
  - [ ] Phục hồi
  - [ ] reload
- [ ] Form (subform) giảng viên (của khoa)
  - [ ] Thêm
  - [ ] Xóa
  - [ ] Sửa
  - [ ] Phục hồi
  - [ ] reload
- [ ] Nhập đề (Giảng viên only), giảng viên chỉ thấy và sửa câu hỏi của mình (bảng BoDe)
  - [ ] Thêm
  - [ ] Xóa
  - [ ] Sửa
  - [ ] Phục hồi
  - [ ] reload
- [ ] Chuẩn bị thi
  - [ ] Nhân viên nhập tên lớp, môn sẽ thi, trình độ, lần thi, số câu thi, ngày thì, thời gian thi(phút), ghi vào GiangVien_DangKy
  - [ ] Khi đăng ký thi cần kiểm tra ràng buộc
- [ ] Thi
  - [ ] Phần thông tin thí sinh: Mã lớp, tên lớp, họ tên
  - [ ] Phần bài thi: 
    - [ ] Môn thi, ngày thi, số lần thi
    - [ ] Lọc ra số câu thi, thời gian thi, trình độ(giáo viên đăng ký)
    - [ ] Khi nhấn "bắt đầu thi", lọc các câu từ bước 2 phía trên (ngẫu nhiên, không trùng), sau đó tiến hành cho thí sinh thi ***(giao tác)***
  - [ ] Tiêu chí đề thi:
    - [ ] Ngẫu nhiên, không trùng nhau
    - [ ] Lấy theo trình độ A, B hay C
    - [ ] Ưu tiên lấy các câu trình độ cao, nếu thiếu thì lấy ở trình độ thấp hơn
    - [ ] Số câu trình độ cao **bắt buộc lớn hơn 70%**, nếu thiếu có thể lấy ở cơ sở khác
    - [ ] Ưu tiên lấy ở cơ sở mà lớp đố học
    - [ ] Điểm cao nhât là 10, số điểm mỗi câu là như nhau (trung bình cộng go brr)
    - [ ] Cho user chọn câu đã thi ở lần thi trước
    - [ ] Hết thời gian quy định => buộc kết thúc bài thi
    - [ ] Thông báo điểm cho sinh viên và lưu vào BangDiem
- [ ] Xem kết quả
  - [ ] In ra số câu đã thi dựa trên các thông tin Mã sinh viên, môn học, lần thi
  - [ ] Kết xuất bắt buộc
  ![alt text](.github/src/imgs/image.png)
- [ ] Bảng điểm môn học
  - [ ] Giáo viên chọn tên lớp, tên môn học, lần thi: chương trình in ra bảng điểm hết môn của lớp đã chọn
  - [ ] Mẫu bảng: (Stt,) MASV, HO, TEN, DIEM, ĐIỂM CHỮ
- [ ] Báo cáo DANH SÁCH ĐĂNG KÝ THI TRẮC NGHIỆM CƠ SỞ X
  - [ ] Xem danh sách đăng ký thi trắc nghiệm của cả 2 cơ sở @tungay đến @denngay; In theo từng cơ sở, in theo thứ tự tăng dần của ngày đăng ký ***(xử lý job)***
  - [ ] Mẫu: 
  ![alt text](.github/src/imgs/image2.png)

</details>

<details style="font-size: 15px;">
<summary style="font-size: 25px; font-weight: 700; color: blue">
    SP Task
</summary>

- [ ] Xem, thêm, xóa, sửa(, phục hồi, reload) môn học
- [ ] Xem, thêm, xóa, sửa(, phục hồi, reload) khoa
- [ ] Xem, thêm, xóa, sửa(, phục hồi, reload) lớp
- [ ] Xem, thêm, xóa, sửa(, phục hồi, reload) sinh viên
- [ ] Xem, thêm, xóa, sửa(, phục hồi, reload) giáo viên
- [ ] Xem, thêm, xóa, sửa(, phục hồi, reload) đề thi (câu hỏi)
- [ ] Xem, thêm, xóa, sửa(, phục hồi, reload) GiangVien_DangKy; khi thêm, sửa cần kiểm tra ràng buộc
- [ ] Xem thông tin thí sinh dự thi
- [ ] ***Lọc danh sách câu hỏi phù hợp với thí sinh tham gia dự thi***
- [ ] ***Chọn câu hỏi từ danh sách đã lọc để tạo đề thi***
- [ ] Tạo / sửa bảng tạm (local) lưu kết quả thi của sinh viên (theo 2 cách, mỗi 1 khoảng thời gian khi thi, hoặc ngay khi thí sinh chọn/đổi đáp án của 1 câu hỏi)
- [ ] Lưu kết quả cuối cùng vào BangDiem
- [ ] Show kết quả bài thi, output: STT, Câu số (trong đề), Nội dung, Các chọn lựa, đáp án (lựa chọn sính xác), Đã chọn (đáp án thí sinh chọn)
- [ ] Bảng điểm môn học của lớp, output: (Stt,) MASV, HO, TEN, DIEM, ĐIỂM CHỮ
- [ ] Báo cáo danh sách đăng ký thi
</details>
