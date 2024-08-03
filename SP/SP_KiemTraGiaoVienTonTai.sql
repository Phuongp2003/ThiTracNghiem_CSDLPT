USE [TN_CSDLPT]
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraGiaoVienTonTai]    Script Date: 24/06/2024 3:42:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROC [dbo].[SP_KiemTraGiaoVienTonTai]
@MAGV NCHAR(15)
AS
BEGIN
    IF EXISTS(SELECT MAGV FROM GIAOVIEN WHERE MAGV = @MAGV)
    RAISERROR('Mã giáo viên này đã tồn tại', 16, 1) 
END