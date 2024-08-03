USE [TN_CSDLPT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE or ALTER PROC [dbo].[SP_TaoBaiThi]
	@masv char(8),
	@malop NCHAR(15),
	@maMH nchar(5),
	@lan smallint
AS
SET XACT_ABORT ON
BEGIN TRAN
BEGIN TRY
	DECLARE @ngayThi datetime, @soCauThi int, @trinhDo nchar(1), @soluong int, @soluongCSkhac int, @trinhDoDuoi nchar(1), @soLuongMoi int

	--Uu tien lay de cua giao vien o co so  ma lop do dang hoc
	--khong phai la lay de theo giao vien day lop do!!!
	SELECT @ngayThi = NGAYTHI, @soCauThi = SOCAUTHI, @trinhDo = TRINHDO
FROM GIAOVIEN_DANGKY
WHERE MAMH = @maMH AND MALOP = @maLop AND LAN = @lan	

	IF (@trinhDo = 'A')
		SET @trinhDoDuoi = 'B'
	ELSE IF (@trinhDo = 'B')
		SET @trinhDoDuoi = 'C'

	--Tu dong tao bang diem khi thi, diem = null
	DECLARE @maBangDiem nchar(10) = TRIM(@masv) + TRIM(@maMH) + STR(@lan,1,0), @giothi datetime = DATEADD(MINUTE, 1, CURRENT_TIMESTAMP)
	IF EXISTS (select 1
from BANGDIEM
where BANGDIEM.MABANGDIEM=@maBangDiem)
		BEGIN
	RAISERROR('Bang diem nay da ton tai',16,1)
	ROLLBACK
END
	INSERT INTO BANGDIEM
	(MASV, MAMH, LAN, NGAYTHI, DIEM, MABANGDIEM)
VALUES
	(@masv, @maMH, @lan, @giothi, NULL, @maBangDiem)

	IF (@trinhDo = 'C')
		BEGIN
	IF (@soluong > @soCauThi)
				BEGIN
		SELECT @soluong = COUNT(CAUHOI)
		FROM BODE
		WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV
			FROM GIAOVIEN
			WHERE MAKH IN (SELECT MAKH
			FROM KHOA))
		--Tao bai thi (duoc luu trong CTBAITHI)
		INSERT INTO CTBAITHI
			(CAUHOI, MABANGDIEM)
		SELECT TOP (@soCauThi)
			CAUHOI, @maBangDiem
		FROM BODE
		WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV
			FROM GIAOVIEN
			WHERE MAKH IN (SELECT MAKH
			FROM KHOA))
		ORDER BY NEWID()
		--Danh sach cau hoi cua bai thi
		SELECT NOIDUNG, A, B, C, D
		FROM (SELECT CAUHOI
			FROM CTBAITHI
			WHERE CTBAITHI.MABANGDIEM=@maBangDiem) BAITHI, BODE
		WHERE BODE.CAUHOI = BAITHI.CAUHOI
	END
			ELSE
				BEGIN
		SELECT @soluongCSkhac = COUNT(CAUHOI)
		FROM BODE
		WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV
			FROM GIAOVIEN
			WHERE MAKH IN (SELECT MAKH
			FROM KHOA))

		IF (@soluong + @soluongCSkhac < @soCauThi)
						BEGIN
			RAISERROR ('So luong cau hoi khong du',16,1)
			ROLLBACK
		END
					ELSE
						BEGIN
			--Tao bai thi (duoc luu trong CTBAITHI)
			--Lay cau hoi o co so hien tai
			INSERT INTO CTBAITHI
				(CAUHOI, MABANGDIEM)
			SELECT TOP (@soluong)
				CAUHOI, @maBangDiem
			FROM BODE
			WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV
				FROM GIAOVIEN
				WHERE MAKH IN (SELECT MAKH
				FROM KHOA))
			ORDER BY NEWID()

			--Lay cau hoi o co so khac
			INSERT INTO CTBAITHI
				(CAUHOI, MABANGDIEM)
			SELECT TOP (@soluongCSkhac)
				CAUHOI, @maBangDiem
			FROM BODE
			WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV
				FROM GIAOVIEN
				WHERE MAKH NOT IN (SELECT MAKH
				FROM KHOA))
			ORDER BY NEWID()
			--Danh sach cau hoi cua bai thi
			SELECT NOIDUNG, BAITHI.CAUHOI, A, B, C, D
			FROM (SELECT CAUHOI
				FROM CTBAITHI
				WHERE CTBAITHI.MABANGDIEM=@maBangDiem) BAITHI,
				(SELECT *
				FROM BODE
				WHERE BODE.MAMH = @maMH) DE
			WHERE DE.CAUHOI = BAITHI.CAUHOI
		END
	END
END
	ELSE --trinh do A hoac B
		BEGIN
	--Luu toan boan cau hoi cung trinh do vao bang tam #DETHI
	SELECT CAUHOI, NOIDUNG, A, B, C, D
	INTO #DETHI
	FROM BODE
	WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV
		FROM GIAOVIEN
		WHERE MAKH IN (SELECT MAKH
		FROM KHOA))
	--So luong cau hoi
	SELECT @soluong = COUNT(CAUHOI)
	FROM #DETHI

	IF (@soluong >= @soCauThi) 
				BEGIN
		INSERT INTO CTBAITHI
			(CAUHOI, MABANGDIEM)
		SELECT TOP (@soCauThi)
			CAUHOI, @maBangDiem
		FROM #DETHI
		ORDER BY NEWID()

		SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D
		FROM (SELECT CAUHOI
			FROM CTBAITHI
			WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
		WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
	END
			ELSE IF (@soluong >= @soCauthi*0.7)
				BEGIN
		INSERT INTO #DETHI
			(CAUHOI, NOIDUNG, A, B, C, D)
		--Luu them nhung cau hoi duoi trinh do 1 bac CUNG CO SO
		SELECT TOP (@soCauThi - @soluong)
			CAUHOI, NOIDUNG, A, B, C, D
		FROM BODE
		WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV
			FROM GIAOVIEN
			WHERE MAKH IN (SELECT MAKH
			FROM KHOA))
		ORDER BY NEWID()

		SELECT @soLuongMoi = COUNT(CAUHOI)
		FROM #DETHI


		IF (@soLuongMoi >= @soCauThi)
						BEGIN
			INSERT INTO CTBAITHI
				(CAUHOI, MABANGDIEM)
			SELECT TOP (@soCauThi)
				CAUHOI, @maBangDiem
			FROM #DETHI
			ORDER BY NEWID()

			SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D
			FROM (SELECT CAUHOI
				FROM CTBAITHI
				WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
			WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
		END
					ELSE --chuyen co so
						BEGIN
			INSERT INTO #DETHI
				(CAUHOI, NOIDUNG, A, B, C, D)
			--Luu them cau hoi cung bac nhung KHAC CO SO
			SELECT TOP (@soCauThi - @soLuongMoi)
				CAUHOI, NOIDUNG, A, B, C, D
			FROM BODE
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV
				FROM GIAOVIEN
				WHERE MAKH NOT IN (SELECT MAKH
				FROM KHOA))

			SELECT @soLuongMoi = COUNT(CAUHOI)
			FROM #DETHI
			IF (@soLuongMoi >= @soCauThi)
								BEGIN
				INSERT INTO CTBAITHI
					(CAUHOI, MABANGDIEM)
				SELECT TOP (@soCauThi)
					CAUHOI, @maBangDiem
				FROM #DETHI
				ORDER BY NEWID()

				SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D
				FROM (SELECT CAUHOI
					FROM CTBAITHI
					WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
				WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
			END
							ELSE
								BEGIN
				INSERT INTO #DETHI
					(CAUHOI, NOIDUNG, A, B, C, D)
				--Luu them cau hoi duoi 1 bac nhung KHAC CO SO
				SELECT TOP (@soCauThi - @soLuongMoi)
					CAUHOI, NOIDUNG, A, B, C, D
				FROM BODE
				WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV
					FROM GIAOVIEN
					WHERE MAKH NOT IN (SELECT MAKH
					FROM KHOA))

				SELECT @soLuongMoi = COUNT(CAUHOI)
				FROM #DETHI
				SELECT COUNT(CAUHOI)
				FROM #DETHI
				IF (@soLuongMoi >= @soCauThi)
										BEGIN
					INSERT INTO CTBAITHI
						(CAUHOI, MABANGDIEM)
					SELECT TOP (@soCauThi)
						CAUHOI, @maBangDiem
					FROM #DETHI
					ORDER BY NEWID()

					SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D
					FROM (SELECT CAUHOI
						FROM CTBAITHI
						WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
					WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
				END
									ELSE
										BEGIN
					RAISERROR('Khong du cau hoi de tao bai thi!',16,1)
					ROLLBACK
				END
			END
		END

	END
			
			ELSE --Khong du cau hoi trinh do bac hien tai
				BEGIN
		INSERT INTO #DETHI
			(CAUHOI, NOIDUNG, A, B, C, D)
		--luu them cau hoi cung bac NHUNG KHAC CO SO
		SELECT TOP (@soCauThi - @soluong)
			CAUHOI, NOIDUNG, A, B, C, D
		FROM BODE
		WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV
			FROM GIAOVIEN
			WHERE MAKH IN (SELECT MAKH
			FROM KHOA))

		SELECT @soLuongMoi = COUNT(CAUHOI)
		FROM #DETHI

		IF (@soLuongMoi >= @soCauThi)
						BEGIN
			INSERT INTO CTBAITHI
				(CAUHOI, MABANGDIEM)
			SELECT TOP (@soCauThi)
				CAUHOI, @maBangDiem
			FROM #DETHI
			ORDER BY NEWID()

			SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D
			FROM (SELECT CAUHOI
				FROM CTBAITHI
				WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
			WHERE BAITHI.CAUHOI = #DETHI.CAUHOI

		END
					ELSE IF (@soLuongMoi >= @soCauThi*0.7)
						BEGIN
			INSERT INTO #DETHI
				(CAUHOI, NOIDUNG, A, B, C, D)
			--luu them cau hoi duoi 1 bac CUNG CO SO
			SELECT TOP (@soCauThi - @soLuongMoi)
				CAUHOI, NOIDUNG, A, B, C, D
			FROM BODE
			WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV
				FROM GIAOVIEN
				WHERE MAKH IN (SELECT MAKH
				FROM KHOA))

			SELECT @soLuongMoi = COUNT(CAUHOI)
			FROM #DETHI

			IF (@soLuongMoi >= @soCauThi)
								BEGIN
				INSERT INTO CTBAITHI
					(CAUHOI, MABANGDIEM)
				SELECT TOP (@soCauThi)
					CAUHOI, @maBangDiem
				FROM #DETHI
				ORDER BY NEWID()

				SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D
				FROM (SELECT CAUHOI
					FROM CTBAITHI
					WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
				WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
			END
							ELSE 
								BEGIN
				INSERT INTO #DETHI
					(CAUHOI, NOIDUNG, A, B, C, D)
				--luu them cau hoi duoi 1 bac KHAC CO SO
				SELECT TOP (@soCauThi - @soLuongMoi)
					CAUHOI, NOIDUNG, A, B, C, D
				FROM BODE
				WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV NOT IN (SELECT MAGV
					FROM GIAOVIEN
					WHERE MAKH IN (SELECT MAKH
					FROM KHOA))

				SELECT @soLuongMoi = COUNT(CAUHOI)
				FROM #DETHI

				IF (@soLuongMoi >= @soCauThi)
										BEGIN
					INSERT INTO CTBAITHI
						(CAUHOI, MABANGDIEM)
					SELECT TOP (@soCauThi)
						CAUHOI, @maBangDiem
					FROM #DETHI
					ORDER BY NEWID()

					SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D
					FROM (SELECT CAUHOI
						FROM CTBAITHI
						WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
					WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
				END
									ELSE
										BEGIN
					RAISERROR('Khong du so luong cau hoi de tao bai thi',16,1)
				END
			END
		END
					ELSE
						BEGIN
			RAISERROR('Khong du cau hoi de tao bai thi',16,1)
			ROLLBACK
		END
	END
END

COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
	DECLARE @ErrorMessage VARCHAR(2000)
	SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
	RAISERROR(@ErrorMessage, 16, 1)
END CATCH
GO
