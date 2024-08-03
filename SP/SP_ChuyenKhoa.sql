USE [TN_CSDLPT]
GO

/****** Object:  StoredProcedure [dbo].[SP_ChuyenKhoa]    Script Date: 25/06/2024 9:17:34 SA ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[SP_ChuyenKhoa](@MAKH nchar(8),
							   @MAGV nchar(8))
    AS
    BEGIN
        UPDATE dbo.GIAOVIEN 
		SET MAKH = @MAKH
		WHERE MAGV = @MAGV
	IF  exists(SELECT * from  dbo.GIAOVIEN where MAGV = @MAGV AND MAKH = @MAKH)
   		raiserror ('Chuyển khoa thành công',16,1)
	ELSE
        raiserror ('Chuyển khoa thất bại',16,1)
    END;
GO

