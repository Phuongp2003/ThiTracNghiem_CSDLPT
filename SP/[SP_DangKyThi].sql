USE [TN_CSDLPT]
GO
/****** Object:  StoredProcedure [dbo].[SP_DangKyThi]    Script Date: 27/06/2024 6:13:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROC [dbo].[SP_DangKyThi]
 @magv char(8),@malop char(5),
        @mamh nchar(15) ,@trinhdo char(1),@ngaythi datetime,@socauthi smallint,@thoigian smallint,@lan smallint = 1
AS
BEGIN TRY
    EXEC SP_KiemTraDangKyThi @mamh, @malop, @lan
    EXEC SP_KiemTraSoLuongCau @mamh, @trinhdo, @socauthi
    
    INSERT INTO GIAOVIEN_DANGKY (MAGV, MAMH, MALOP, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN)
    VALUES (@magv,@mamh, @malop, @trinhdo, @ngaythi, @lan, @socauthi, @thoigian)
    
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage VARCHAR(2000)
    SELECT @ErrorMessage = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@ErrorMessage, 16, 1)
END CATCH