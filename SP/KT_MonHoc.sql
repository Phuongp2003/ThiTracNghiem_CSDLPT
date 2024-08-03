USE [TN_CSDLPT]
GO

/****** Object:  UserDefinedFunction [dbo].[KT_MonHoc]    Script Date: 17/06/2024 10:33:17 SA ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER FUNCTION [dbo].[KT_MonHoc] (@mamh nchar(5))
RETURNS VARCHAR(50)
AS 
BEGIN
	DECLARE @checked VARCHAR(50);
	DECLARE @len INT = 0;
	SELECT @len = COUNT(*) FROM BANGDIEM WHERE BANGDIEM.DIEM IS NOT NULL AND BANGDIEM.MAMH=@maMH;

	IF @len > 0
	 SET @checked = 'X';
	 ELSE
	 SET @checked = '';

	RETURN @checked;
END;
GO

