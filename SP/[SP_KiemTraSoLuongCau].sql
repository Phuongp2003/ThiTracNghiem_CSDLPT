USE [TN_CSDLPT]
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraSoLuongCau]    Script Date: 27/06/2024 6:17:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROC [dbo].[SP_KiemTraSoLuongCau]
@mamh char(5), @trinhdo char(1),@socauthi int
AS
BEGIN
DECLARE    @soluong int, @soluongduoi int, @trinhdoduoi char(1)
SELECT @soluong = COUNT(CAUHOI) FROM BODE WHERE MAMH = @mamh AND TRINHDO = @trinhdo

IF (@trinhdo = 'A')
    SET @trinhdoduoi = 'B'
ELSE IF (@trinhdo = 'B')
    SET @trinhdoduoi = 'C'

IF (@soluong >= @socauthi*0.7)
    BEGIN
        SELECT @soluongduoi = COUNT(CAUHOI) FROM BODE WHERE MAMH =@mamh AND TRINHDO = @trinhdoduoi
        IF ((@soluongduoi + @soluong) < @socauthi)
            RAISERROR (N'Khong du so luong cau de tao bai thi',16,1)
    END
ELSE
    RAISERROR(N'Khong du so luong cau phu hop de tao bai thi',16,1)
END