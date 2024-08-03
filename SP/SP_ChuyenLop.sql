USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_ChuyenLop]    Script Date: 25/06/2024 9:17:56 SA ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_ChuyenLop]
	(@MALOP nchar(8),
	 @MASV nchar(8))
    AS
    BEGIN
        UPDATE dbo.SINHVIEN 
		SET MALOP = @MALOP
		WHERE MASV = @MASV
	IF  exists(SELECT * from  dbo.SINHVIEN where MASV = @MASV AND MALOP = @MALOP)
   		raiserror ('Chuyển lớp thành công',16,1)
	ELSE
        raiserror ('Chuyển lớp thất bại',16,1)
    END;
GO

