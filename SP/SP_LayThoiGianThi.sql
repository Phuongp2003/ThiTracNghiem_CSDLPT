Create or ALTER PROC [dbo].[SP_LayThoiGianThi]
    @masv CHAR(8),
    @maMonThi CHAR(5),
    @lanThi SMALLINT
AS
BEGIN
    DECLARE @malop CHAR(10);

    SELECT @malop = MALOP 
    FROM SINHVIEN 
    WHERE MASV = @masv;

    IF @malop IS NULL
    BEGIN
        RAISERROR('Sinh viên không tồn tại hoặc không có mã lớp.', 16, 1);
        RETURN;
    END

    SELECT 
        (SELECT THOIGIAN 
         FROM GIAOVIEN_DANGKY 
         WHERE MALOP = @malop AND MAMH = @maMonThi AND LAN = @lanThi) AS THOIGIAN,
        (SELECT NGAYTHI 
         FROM BANGDIEM 
         WHERE MASV = @masv AND MAMH = @maMonThi AND LAN = @lanThi) AS NGAYTHI
END;