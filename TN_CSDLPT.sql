USE [master]
GO
/****** Object:  Database [TN_CSDLPT]    Script Date: 04/08/2024 00:37:34 ******/
CREATE DATABASE [TN_CSDLPT]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TN_CSDLPT', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER_TN\MSSQL\DATA\TN_CSDLPT.mdf' , SIZE = 139264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TN_CSDLPT_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER_TN\MSSQL\DATA\TN_CSDLPT_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TN_CSDLPT] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TN_CSDLPT].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TN_CSDLPT] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET ARITHABORT OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TN_CSDLPT] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TN_CSDLPT] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TN_CSDLPT] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TN_CSDLPT] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET RECOVERY FULL 
GO
ALTER DATABASE [TN_CSDLPT] SET  MULTI_USER 
GO
ALTER DATABASE [TN_CSDLPT] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TN_CSDLPT] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TN_CSDLPT] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TN_CSDLPT] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TN_CSDLPT] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TN_CSDLPT] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TN_CSDLPT', N'ON'
GO
ALTER DATABASE [TN_CSDLPT] SET QUERY_STORE = ON
GO
ALTER DATABASE [TN_CSDLPT] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TN_CSDLPT]
GO
/****** Object:  User [KDTHIEN]    Script Date: 04/08/2024 00:37:34 ******/
CREATE USER [KDTHIEN] FOR LOGIN [TH101] WITH DEFAULT_SCHEMA=[KDTHIEN]
GO
/****** Object:  User [admin]    Script Date: 04/08/2024 00:37:34 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [TRUONG]    Script Date: 04/08/2024 00:37:34 ******/
CREATE ROLE [TRUONG]
GO
/****** Object:  DatabaseRole [SINHVIEN]    Script Date: 04/08/2024 00:37:34 ******/
CREATE ROLE [SINHVIEN]
GO
/****** Object:  DatabaseRole [MSmerge_PAL_role]    Script Date: 04/08/2024 00:37:34 ******/
CREATE ROLE [MSmerge_PAL_role]
GO
/****** Object:  DatabaseRole [MSmerge_CDBA1C4AB51143FC89BB6BA3B64BADC1]    Script Date: 04/08/2024 00:37:34 ******/
CREATE ROLE [MSmerge_CDBA1C4AB51143FC89BB6BA3B64BADC1]
GO
/****** Object:  DatabaseRole [MSmerge_621BA99A4920475CBC70095A158666D9]    Script Date: 04/08/2024 00:37:34 ******/
CREATE ROLE [MSmerge_621BA99A4920475CBC70095A158666D9]
GO
/****** Object:  DatabaseRole [MSmerge_1BD383B8F3F64481ABD86B80F3BEC914]    Script Date: 04/08/2024 00:37:34 ******/
CREATE ROLE [MSmerge_1BD383B8F3F64481ABD86B80F3BEC914]
GO
/****** Object:  DatabaseRole [GIANGVIEN]    Script Date: 04/08/2024 00:37:34 ******/
CREATE ROLE [GIANGVIEN]
GO
/****** Object:  DatabaseRole [COSO]    Script Date: 04/08/2024 00:37:34 ******/
CREATE ROLE [COSO]
GO
ALTER ROLE [GIANGVIEN] ADD MEMBER [KDTHIEN]
GO
ALTER ROLE [TRUONG] ADD MEMBER [admin]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_CDBA1C4AB51143FC89BB6BA3B64BADC1]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_621BA99A4920475CBC70095A158666D9]
GO
ALTER ROLE [MSmerge_PAL_role] ADD MEMBER [MSmerge_1BD383B8F3F64481ABD86B80F3BEC914]
GO
/****** Object:  Schema [KDTHIEN]    Script Date: 04/08/2024 00:37:34 ******/
CREATE SCHEMA [KDTHIEN]
GO
/****** Object:  Schema [MSmerge_PAL_role]    Script Date: 04/08/2024 00:37:34 ******/
CREATE SCHEMA [MSmerge_PAL_role]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertDiemChu]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[ConvertDiemChu](@Number float)
RETURNS nvarchar(4000) AS 
BEGIN
	DECLARE @sNumber nvarchar(4000)
	DECLARE @Return	nvarchar(4000)
	DECLARE @mLen int
	DECLARE @i int

	DECLARE @mDigit char(1)
	DECLARE @mTemp nvarchar(4000)
	DECLARE @mNumText nvarchar(4000)
	IF @Number IS NULL
    BEGIN
        RETURN N'Không'
    END
	SELECT @sNumber=LTRIM(cast(@Number as nvarchar))
	SELECT @mLen = Len(@sNumber)

	if @mLen =2
		BEGIN
			SELECT @Return = N'Mười'
			RETURN @Return
		END
	SELECT @i=1
	SELECT @mTemp=''

	WHILE @i <= @mLen
		BEGIN

		SELECT @mDigit=SUBSTRING(@sNumber, @i, 1)

		IF @mDigit='0' SELECT @mNumText=N'không'
		ELSE
			BEGIN
			IF @mDigit='1' SELECT @mNumText=N'một'
			ELSE
			IF @mDigit='2' SELECT @mNumText=N'hai'
			ELSE
			IF @mDigit='3' SELECT @mNumText=N'ba'
			ELSE
			IF @mDigit='4' SELECT @mNumText=N'bốn'
			ELSE
			IF @mDigit='5' SELECT @mNumText=N'năm'
			ELSE
			IF @mDigit='6' SELECT @mNumText=N'sáu'
			ELSE
			IF @mDigit='7' SELECT @mNumText=N'bảy'
			ELSE
			IF @mDigit='8' SELECT @mNumText=N'tám'
			ELSE
			IF @mDigit='9' SELECT @mNumText=N'chín'
			ELSE 
			IF @mDigit='.' SELECT @mNumText=N'phẩy'
			END

		SELECT @mTemp = @mTemp + ' ' + @mNumText

		IF (@mLen = @i) BREAK
		
		IF @i =3
			SELECT @mTemp = @mTemp + N' mươi'
		SELECT @i=@i+1
		END


	SELECT @mTemp = Replace(@mTemp, N'không mươi ', N'không ')

	SELECT @mTemp = Replace(@mTemp, N'một mươi', N'mười')

	SELECT @mTemp = Replace(@mTemp, N'mươi năm', N'mươi lăm')

	--'Fix trường hợp x1, x>=2

	SELECT @mTemp = Replace(@mTemp, N'mươi một', N'mươi mốt')

	--'Fix trường hợp x15

	SELECT @mTemp = Replace(@mTemp, N'mười năm', N'mười lăm')

	--'Bỏ ký tự space

	SELECT @mTemp = LTrim(@mTemp)

	--'Ucase ký tự đầu tiên

	SELECT @Return=UPPER(Left(@mTemp, 1)) + SUBSTRING(@mTemp,2, 4000)

	RETURN @Return
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetInitials]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetInitials] (@input NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @result NVARCHAR(MAX) = '';
    DECLARE @index INT = 1;
    DECLARE @char NVARCHAR(1);
    
    SET @input = LTRIM(RTRIM(@input));
    
    IF LEN(@input) > 0
    BEGIN
        SET @result = SUBSTRING(@input, 1, 1);  -- First character
        
        WHILE @index < LEN(@input)
        BEGIN
            SET @char = SUBSTRING(@input, @index, 1);
            
            IF @char = ' '
            BEGIN
                SET @result = @result + SUBSTRING(@input, @index + 1, 1);
            END
            
            SET @index = @index + 1;
        END
    END
    
    RETURN @result;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[KiemTraDotThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[KiemTraDotThi] (@mamh nchar(5), @malop nchar(15), @lan smallint)
RETURNS VARCHAR(50)
AS 
BEGIN
    DECLARE @checked VARCHAR(50);
    DECLARE @len INT = 0;
    IF (@malop IN (SELECT MALOP FROM LOP))
        BEGIN
            SELECT
                @len = COUNT(*) FROM BANGDIEM
            WHERE BANGDIEM.DIEM IS NOT NULL
                AND BANGDIEM.MAMH=@maMH
                AND BANGDIEM.LAN = @lan
                AND BANGDIEM.MASV IN (SELECT MASV FROM SINHVIEN WHERE MALOP = @malop);
        END
    ELSE
        BEGIN
            SELECT
                @len = COUNT(*) FROM LINK1.TN_CSDLPT.DBO.BANGDIEM AS BD
            WHERE BD.DIEM IS NOT NULL
                AND BD.MAMH = @mamh
                AND BD.LAN = @lan
                AND BD.MASV IN (SELECT MASV FROM LINK1.TN_CSDLPT.DBO.SINHVIEN WHERE MALOP = @malop)
        END

    IF @len > 0
        SET @checked = 'X';
    ELSE
        SET @checked = '';

RETURN @checked;
END;
GO
/****** Object:  UserDefinedFunction [dbo].[KT_MonHoc]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION [dbo].[KT_MonHoc] (@mamh nchar(5))
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
/****** Object:  UserDefinedFunction [dbo].[TaoAlias]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[TaoAlias] (@input NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @result NVARCHAR(MAX) = '';
    DECLARE @index INT = 1;
    DECLARE @char NVARCHAR(1);
    
    SET @input = LTRIM(RTRIM(@input));
    
    IF LEN(@input) > 0
    BEGIN
        SET @result = SUBSTRING(@input, 1, 1);
        
        WHILE @index < LEN(@input)
        BEGIN
            SET @char = SUBSTRING(@input, @index, 1);
            
            IF @char = ' '
            BEGIN
                SET @result = @result + SUBSTRING(@input, @index + 1, 1);
            END
            
            SET @index = @index + 1;
        END
    END
    
    RETURN UPPER(@result);
END;
GO
/****** Object:  Table [dbo].[GIAOVIEN_DANGKY]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN_DANGKY](
	[MAGV] [char](8) NULL,
	[MAMH] [char](5) NOT NULL,
	[MALOP] [nchar](15) NOT NULL,
	[TRINHDO] [char](1) NULL,
	[NGAYTHI] [datetime] NULL,
	[LAN] [smallint] NOT NULL,
	[SOCAUTHI] [smallint] NULL,
	[THOIGIAN] [smallint] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_GIAOVIEN_DANGKY] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC,
	[MALOP] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DanhSachCacMonThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[view_DanhSachCacMonThi] AS
SELECT MAMH, MALOP, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN FROM GIAOVIEN_DANGKY 
WHERE 
	CONVERT(DATE, NGAYTHI) >= CONVERT(date, GETDATE())
GO
/****** Object:  View [dbo].[view_DanhSachPhanManh]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DanhSachPhanManh] AS
SELECT
    ms.subscriber_server AS TENSERVER,
    mp.description AS TENCS,
    dbo.TaoAlias(mp.description) AS 's_TENCS'
FROM
    dbo.sysmergesubscriptions AS ms
    INNER JOIN dbo.sysmergepublications AS mp ON ms.pubid=mp.pubid
WHERE
    (
        ms.subscriber_server<>(
            SELECT
                TOP (1) srvname
            FROM
                dbo.sysreplservers
        )
    )



GO
/****** Object:  Table [dbo].[BANGDIEM]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BANGDIEM](
	[MASV] [char](8) NOT NULL,
	[MAMH] [char](5) NOT NULL,
	[LAN] [smallint] NOT NULL,
	[NGAYTHI] [datetime] NULL,
	[DIEM] [float] NULL,
	[MABANGDIEM] [char](10) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_BANGDIEM] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC,
	[MAMH] ASC,
	[LAN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BODE]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BODE](
	[CAUHOI] [int] NOT NULL,
	[MAMH] [char](5) NULL,
	[TRINHDO] [char](1) NULL,
	[NOIDUNG] [ntext] NULL,
	[A] [ntext] NULL,
	[B] [ntext] NULL,
	[C] [ntext] NULL,
	[D] [ntext] NULL,
	[DAP_AN] [char](1) NULL,
	[MAGV] [char](8) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_BODE] PRIMARY KEY CLUSTERED 
(
	[CAUHOI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COSO]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COSO](
	[MACS] [nchar](3) NOT NULL,
	[TENCS] [nvarchar](50) NOT NULL,
	[DIACHI] [nvarchar](100) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_COSO] PRIMARY KEY CLUSTERED 
(
	[MACS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTBAITHI]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTBAITHI](
	[MABANGDIEM] [char](10) NOT NULL,
	[CAUHOI] [int] NOT NULL,
	[DAPANSV] [char](1) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_CTBAITHI] PRIMARY KEY CLUSTERED 
(
	[MABANGDIEM] ASC,
	[CAUHOI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GIAOVIEN]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GIAOVIEN](
	[MAGV] [char](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[DIACHI] [nvarchar](50) NULL,
	[MAKH] [nchar](8) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_GIAOVIEN] PRIMARY KEY CLUSTERED 
(
	[MAGV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHOA]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHOA](
	[MAKH] [nchar](8) NOT NULL,
	[TENKH] [nvarchar](50) NOT NULL,
	[MACS] [nchar](3) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_KHOA] PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOP]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOP](
	[MALOP] [nchar](15) NOT NULL,
	[TENLOP] [nvarchar](50) NOT NULL,
	[MAKH] [nchar](8) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_LOP] PRIMARY KEY CLUSTERED 
(
	[MALOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MONHOC]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONHOC](
	[MAMH] [char](5) NOT NULL,
	[TENMH] [nvarchar](50) NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_TENMH] PRIMARY KEY CLUSTERED 
(
	[MAMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SINHVIEN]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINHVIEN](
	[MASV] [char](8) NOT NULL,
	[HO] [nvarchar](50) NULL,
	[TEN] [nvarchar](10) NULL,
	[NGAYSINH] [date] NULL,
	[DIACHI] [nvarchar](100) NULL,
	[MALOP] [nchar](15) NULL,
	[MATKHAU] [nvarchar](30) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_SINHVIEN] PRIMARY KEY CLUSTERED 
(
	[MASV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [MABANGDIEM], [rowguid]) VALUES (N'001     ', N'AVCB ', 1, CAST(N'2024-07-02T05:19:46.770' AS DateTime), 3.5, N'001AVCB1  ', N'2751dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [MABANGDIEM], [rowguid]) VALUES (N'001     ', N'MMTCB', 1, CAST(N'2024-04-24T00:00:00.000' AS DateTime), 9, N'BD1       ', N'fea2f70d-7aea-ee11-b76a-dbdbe3260541')
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [MABANGDIEM], [rowguid]) VALUES (N'002     ', N'AVCB ', 1, CAST(N'2024-06-28T03:44:33.667' AS DateTime), 3.2, N'002AVCB1  ', N'4171f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [MABANGDIEM], [rowguid]) VALUES (N'002     ', N'MMTCB', 1, CAST(N'2024-06-27T18:51:02.730' AS DateTime), 1.1428571428571428, N'002MMTCB  ', N'874af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [MABANGDIEM], [rowguid]) VALUES (N'167     ', N'MMTCB', 2, CAST(N'2024-07-03T10:43:21.177' AS DateTime), 1, N'N21CN167MM', N'6578453c-ee38-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[BANGDIEM] ([MASV], [MAMH], [LAN], [NGAYTHI], [DIEM], [MABANGDIEM], [rowguid]) VALUES (N'999     ', N'AVCB ', 1, CAST(N'2024-07-03T13:30:53.907' AS DateTime), 0, N'999AVCB1  ', N'530111a8-0539-ef11-b7c9-ec2e98e3b030')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (1, N'MMTCB', N'A', N'mạng máy tính(compute netword) so với hệ thống tập trung multi-user', N'dễ phát triển hệ thống', N'tăng độ tin cậy', N'tiết kiệm chi phí', N'tất cả đều đúng', N'D', N'TH657   ', N'3f548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (3, N'MMTCB', N'A', N'để một máy tính truyền dữ liệu cho một số máy khác trong mạng, ta dùng loại địa chỉ', N'Broadcast', N'Broadband', N'multicast', N'multiple access', N'C', N'TH123   ', N'40548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (4, N'MMTCB', N'A', N'thứ tự phân loại mạng theo chiều dài đường truyền', N'internet, lan, man, wan', N'internet, wan, man, lan', N'lan, wan, man, internet', N'man, lan, wan, internet', N'B', N'TH123   ', N'41548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (5, N'MMTCB', N'A', N'mạng man được sử dụng trong phạm vi:', N'quốc gia', N'lục địa', N'khu phố', N'thành phố', N'D', N'TH123   ', N'42548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (6, N'MMTCB', N'A', N'thuật ngữ man được viết tắt bởi:', N'middle area network', N'metropolitan area network', N'medium area network', N'multiple access network', N'D', N'TH123   ', N'43548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (7, N'MMTCB', N'A', N'mạng man không kết nối theo sơ đồ:', N'bus', N'ring', N'star', N'tree', N'D', N'TH123   ', N'44548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (8, N'MMTCB', N'A', N'kiến trúc mạng (network architechture) là:', N'tập các chức năng trong mạng', N'tập các cấp và các protocol trong mỗi cấp', N'tập các dịch vụ trong mạng', N'tập các protocol trong mạng', N'B', N'TH123   ', N'45548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (9, N'MMTCB', N'A', N'thuật ngữ nào không cùng nhóm:', N'simplex', N'multiplex', N'half duplex', N'full duplex', N'B', N'TH123   ', N'46548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (10, N'MMTCB', N'A', N'loại dịch vụ nào có thể nhận dữ liệu không đúng thứ tự khi truyền', N'point to point', N'có kết nối', N'không kết nối', N'broadcast', N'C', N'TH123   ', N'47548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (11, N'MMTCB', N'A', N'dịch vụ không xác nhận (unconfirmed) chỉ sử dụng 2 phép toán cơ bản:', N'response and confirm', N'confirm and request', N'request and indication', N'indication and response', N'C', N'TH123   ', N'48548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (12, N'MMTCB', N'A', N'Chọn câu sai trong các nguyên lý phân cấp của mô hình OSI', N'Mỗi cấp thực hiện 1 chức năng rõ ràng', N'Mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'Mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'Mỗi cấp phải cung cấp cùng 1 kiểu địa chỉ và dịch vụ', N'D', N'TH123   ', N'49548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (13, N'MMTCB', N'A', N'Chức năng của cấp vật lý(physical)', N'Qui định truyền 1 hay 2 chiều', N'Quản lý lỗi sai', N'Xác định thời gian truyền 1 bit dữ liệu', N'Quản lý địa chỉ vật lý', N'C', N'TH123   ', N'4a548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (14, N'MMTCB', N'A', N'Chức năng câp liên kết dữ liệu (data link)', N'Quản lý lỗi sai', N'Mã hóa dữ liệu', N'Tìm đường đi cho dữ liệu', N'Chọn kênh truyền', N'A', N'TH123   ', N'4b548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (15, N'MMTCB', N'A', N'Chức năng cấp mạng (network)', N'Quản lý lưu lượng đường truyền', N'Điều khiển hoạt động subnet', N'Nén dữ liệu', N'Chọn điện áp trên kênh truyền', N'B', N'TH123   ', N'4c548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (16, N'MMTCB', N'A', N'Chức năng cấp vận tải (transport) ', N'Quản lý địa chỉ mạng', N'Chuyển đổi các dạng frame khác nhau', N'Thiết lập và hủy bỏ dữ liệu', N'Mã hóa và giải mã dữ liệu', N'C', N'TH123   ', N'4d548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (17, N'MMTCB', N'A', N'Cáp xoắn đôi trong mạng LAN dùng đầu nối', N'AUI', N'BNC', N'RJ11', N'RJ45', N'D', N'TH123   ', N'4e548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (18, N'MMTCB', N'A', N'T-connector dùng trong loại cáp', N'10Base-2', N'10Base-5', N'10Base-T', N'10Base-F', N'A', N'TH123   ', N'4f548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (19, N'MMTCB', N'A', N'chọn câu sai trong các nguyên lý phân cấp của mô hình osi', N'mỗi cấp thực hiện 1 chức năng rõ ràng', N'mỗi cấp được chọn sao cho thông tin trao đổi giữa các cấp tối thiểu', N'mỗi cấp được tạo ra ứng với 1 mức trừu tượng hóa', N'mỗi cấp phải cung cấp cùng một kiểu địa chỉ và dịch vụ', N'D', N'TH123   ', N'50548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (20, N'AVCB ', N'A', N'The publishers suggested that the envelopes be sent to ...... by courier so that the film can be developed as soon as possible', N'they', N'their', N'theirs', N'them', N'D', N'TH234   ', N'51548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (21, N'AVCB ', N'A', N'Board members ..... carefully define their goals and objectives for the agency before the monthly meeting next week.', N'had', N'should', N'used ', N'have', N'B', N'TH234   ', N'52548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (22, N'AVCB ', N'A', N'For business relations to continue between our two firms, satisfactory agreement must be ...... reached and signer', N'yet', N'both', N'either ', N'as well as', N'C', N'TH234   ', N'53548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (23, N'AVCB ', N'A', N'The corporation, which underwent a major restructing seven years ago, has been growing steadily ......five years', N'for', N'on', N'from', N'since', N'A', N'TH234   ', N'54548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (24, N'AVCB ', N'A', N'Making advance arrangements for audiovisual equipment is....... recommended for all seminars.', N'sternly', N'strikingly', N'stringently', N'strongly', N'A', N'TH234   ', N'55548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (25, N'AVCB ', N'A', N'Two assistants will be required to ...... reporter''s names when they arrive at the press conference', N'remark', N'check', N'notify', N'ensure', N'B', N'TH234   ', N'56548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (26, N'AVCB ', N'A', N'The present government has an excellent ......to increase exports', N'popularity', N'regularity', N'celebrity', N'opportunity', N'D', N'TH234   ', N'57548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (27, N'AVCB ', N'A', N'While you are in the building, please wear your identification badge at all times so that you are ....... as a company employee.', N'recognize', N'recognizing', N'recognizable', N'recognizably', N'C', N'TH234   ', N'58548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (28, N'AVCB ', N'A', N'Our studies show that increases in worker productivity have not been adequately .......rewarded by significant increases in ......', N'compensation', N'commodity', N'compilation', N'complacency', N'B', N'TH234   ', N'59548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (29, N'AVCB ', N'A', N'Conservatives predict that government finaces will remain...... during the period of the investigation', N'authoritative', N'summarized', N'examined', N'stable', N'D', N'TH234   ', N'5a548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (30, N'AVCB ', N'B', N'Battery-operated reading lamps......very well right now', N'sale', N'sold', N'are selling', N'were sold', N'C', N'TH234   ', N'5b548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (31, N'AVCB ', N'B', N'In order to place a call outside the office, you have to .......nine first. ', N'tip', N'make', N'dial', N'number', N'D', N'TH234   ', N'5c548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (32, N'AVCB ', N'B', N'We are pleased to inform...... that the missing order has been found.', N'you', N'your', N'yours', N'yourseld', N'A', N'TH234   ', N'5d548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (33, N'AVCB ', N'B', N'Unfortunately, neither Mr.Sachs....... Ms Flynn will be able to attend the awards banquet this evening', N'but', N'and', N' nor', N'either', N'C', N'TH234   ', N'5e548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (34, N'AVCB ', N'B', N'According to the manufacturer, the new generatir is capable of....... the amount of power consumed by our facility by nearly ten percent.', N'reduced', N'reducing', N'reduce', N'reduces', N'B', N'TH234   ', N'5f548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (35, N'AVCB ', N'B', N'After the main course, choose from our wide....... of homemade deserts', N'varied', N'various', N'vary', N'variety', N'D', N'TH234   ', N'60548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (36, N'AVCB ', N'B', N'One of the most frequent complaints among airline passengers is that there is not ...... legroom', N'enough', N'many', N'very', N'plenty', N'A', N'TH234   ', N'61548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (37, N'AVCB ', N'B', N'Faculty members are planning to..... a party in honor of Dr.Walker, who will retire at the end of the semester', N'carry', N'do', N'hold', N'take', N'D', N'TH234   ', N'62548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (38, N'AVCB ', N'B', N'Many employees seem more ....... now about how to use the new telephone system than they did before they attended the workshop', N'confusion', N'confuse', N'confused', N'confusing', N'C', N'TH234   ', N'63548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (39, N'AVCB ', N'B', N'.........our production figures improve in the near future, we foresee having to hire more people between now and July', N'During', N'Only', N'Unless', N'Because', N'D', N'TH234   ', N'64548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (40, N'AVCB ', N'C', N'Though their performance was relatively unpolished, the actors held the audience''s ........for the duration of the play.', N'attentive', N'attentively', N'attention', N'attentiveness', N'C', N'TH234   ', N'65548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (41, N'AVCB ', N'C', N'Dr. Abernathy''s donation to Owstion College broke the record for the largest private gift...... give to the campus', N'always', N'rarely', N'once', N'ever', N'C', N'TH234   ', N'66548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (42, N'AVCB ', N'C', N'Savat Nation Park is ....... by train,bus, charter plane, and rental car.', N'accessible', N'accessing', N'accessibility', N'accesses', N'A', N'TH234   ', N'67548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (43, N'AVCB ', N'C', N'In Piazzo''s lastest architectural project, he hopes to......his flare for blending contemporary and traditional ideals.', N'demonstrate', N'appear', N'valve', N'position', N'A', N'TH234   ', N'68548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (44, N'AVCB ', N'C', N'Replacing the offic equipment that the company purchased only three years ago seems quite.....', N'waste', N'wasteful', N'wasting', N'wasted', N'C', N'TH234   ', N'69548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (45, N'AVCB ', N'C', N'On........, employees reach their peak performance level when they have been on the job for at least two years.', N'common', N'standard', N'average', N'general', N'D', N'TH234   ', N'6a548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (46, N'AVCB ', N'C', N'We were........unaware of the problems with the air-conidtioning units in the hotel rooms until this week.', N'complete ', N'completely', N'completed', N'completing', N'D', N'TH234   ', N'6b548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (47, N'AVCB ', N'C', N'If you send in an order ....... mail, we recommend that you phone our sales division directly to confirm the order.', N'near', N'by', N'for', N'on', N'A', N'TH234   ', N'6c548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (48, N'AVCB ', N'C', N'A recent global survey suggests.......... demand for aluminum and tin will remain at its current level for the next five to ten years.', N'which', N'it ', N'that', N'both', N'C', N'TH234   ', N'6d548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (49, N'AVCB ', N'C', N'Rates for the use of recreational facilities do not include ta and are subject to change without.........', N'signal', N'cash', N'report', N'notice', N'A', N'TH234   ', N'6e548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (50, N'AVCB ', N'A', N'Aswering telephone calls is the..... of an operator', N'responsible', N'responsibly', N'responsive', N'responsibility', N'D', N'TH234   ', N'6f548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (51, N'AVCB ', N'A', N'A free watch will be provided with every purchase of $20.00 or more a ........ period of time', N'limit', N'limits', N'limited', N'limiting', N'C', N'TH234   ', N'70548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (52, N'AVCB ', N'A', N'The president of the corporation has .......arrived in Copenhagen and will meet with the Minister of Trade on Monday morning', N'still', N'yet', N'already', N'soon', N'C', N'TH234   ', N'71548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (53, N'AVCB ', N'A', N'Because we value your business, we have .......for card members like you to receive one thousand  dollars of complimentary life insurance', N'arrange', N'arranged', N'arranges', N'arranging', N'B', N'TH234   ', N'72548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (54, N'AVCB ', N'A', N'Employees are........that due to the new government regulations. there is to be no smoking in the factory', N'reminded', N'respected', N'remembered', N'reacted', N'A', N'TH234   ', N'73548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (55, N'AVCB ', N'A', N'MS. Galera gave a long...... in honor of the retiring vice-president', N'speak', N'speaker', N'speaking', N'speech', N'D', N'TH234   ', N'74548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (56, N'AVCB ', N'A', N'Any person who is........ in volunteering his or her time for the campaign should send this office a letter of intent', N'interest', N'interested', N'interesting', N'interestingly', N'B', N'TH234   ', N'75548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (57, N'AVCB ', N'A', N'Mr.Gonzales was very concerned.........the upcoming board of directors meeting', N'to', N'about', N'at ', N'upon', N'B', N'TH234   ', N'76548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (58, N'AVCB ', N'A', N'The customers were told that no ........could be made on weekend nights because the restaurant was too busy', N'delays', N'cuisines', N'reservation', N'violations', N'C', N'TH234   ', N'77548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (59, N'AVCB ', N'A', N'The sales representive''s presentation was difficult to understand ........ he spoke very quickly', N'because', N'althought', N'so that', N'than', N'A', N'TH234   ', N'78548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (60, N'AVCB ', N'B', N'It has been predicted that an.......weak dollar will stimulate tourism in the United States', N'increased', N'increasingly', N'increases', N'increase', N'B', N'TH234   ', N'79548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (61, N'AVCB ', N'B', N'The firm is not liable for damage resulting from circumstances.........its control.', N'beyond', N'above', N'inside', N'around', N'A', N'TH234   ', N'7a548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (62, N'AVCB ', N'B', N'Because of.......weather conditions, California has an advantage in the production of fruits and vegetables', N'favorite', N'favor', N'favorable', N'favorably', N'C', N'TH234   ', N'7b548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (63, N'AVCB ', N'B', N'On international shipments, all duties and taxes are paid by the..........', N'recipient', N'receiving', N'receipt', N'receptive', N'A', N'TH234   ', N'7c548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (64, N'AVCB ', N'B', N'Although the textbook gives a definitive answer,wise managers will look for........ own creative solutions', N'them', N'their', N'theirs', N'they', N'B', N'TH234   ', N'7d548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (65, N'AVCB ', N'B', N'Initial ....... regarding the merger of the companies took place yesterday at the Plaza Conference Center.', N'negotiations', N'dedications', N'propositions', N'announcements', N'A', N'TH234   ', N'7e548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (66, N'AVCB ', N'B', N'Please......... photocopies of all relevant docunments to this office ten days prior to your performance review date', N'emerge', N'substantiate', N'adapt', N'submit', N'D', N'TH234   ', N'7f548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (67, N'AVCB ', N'B', N'The auditor''s results for the five year period under study were .........the accountant''s', N'same', N'same as', N'the same', N'the same as', N'D', N'TH234   ', N'80548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (68, N'AVCB ', N'B', N'.........has the marketing environment been more complex and subject to change', N'Totally', N'Negatively', N'Decidedly', N'Rarely', N'D', N'TH234   ', N'81548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (69, N'AVCB ', N'B', N'All full-time staff are eligible to participate in the revised health plan, which becomes effective the first ......... the month.', N'of', N'to', N'from', N'for', N'A', N'TH234   ', N'82548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (70, N'AVCB ', N'C', N'Contracts must be read........ before they are signed.', N'thoroughness', N'more thorough', N'thorough', N'thoroughly', N'D', N'TH234   ', N'83548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (71, N'AVCB ', N'C', N'Passengers should allow for...... travel time to the airport in rush hour traffic', N'addition', N'additive', N'additionally', N'additional', N'D', N'TH234   ', N'84548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (72, N'AVCB ', N'C', N'This fiscal year, the engineering team has worked well together on all phases ofproject.........', N'development', N'developed', N'develops', N'developer', N'A', N'TH234   ', N'85548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (73, N'AVCB ', N'C', N'Mr.Dupont had no ....... how long it would take to drive downtown', N'knowledge', N'thought', N'idea', N'willingness', N'C', N'TH234   ', N'86548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (74, N'AVCB ', N'C', N'Small company stocks usually benefit..........the so called January effect that cause the price of these stocks to rise between November and January', N'unless', N'from', N'to ', N'since', N'B', N'TH234   ', N'87548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (75, N'AVCB ', N'C', N'It has been suggested that employees ........to work in their current positions until the quarterly review is finished.', N'continuity', N'continue', N'continuing', N'continuous', N'B', N'TH234   ', N'88548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (76, N'AVCB ', N'C', N'It is admirable that Ms.Jin wishes to handle all transactions by........, but it might be better if several people shared the responsibility', N'she', N'herself', N'her', N'hers', N'B', N'TH234   ', N'89548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (77, N'AVCB ', N'C', N'This new highway construction project will help the company.........', N'diversity', N'clarify', N'intensify', N'modify', N'A', N'TH234   ', N'8a548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (78, N'AVCB ', N'C', N'Ms.Patel has handed in an ........business plan to the director', N'anxious', N'evident', N'eager', N'outstanding', N'D', N'TH234   ', N'8b548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (79, N'AVCB ', N'C', N'Recent changes in heating oil costs have affected..........production of turniture', N'local', N'locality', N'locally', N'location', N'A', N'TH234   ', N'8c548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (80, N'MMTCB', N'A', N'Termiator là linh kiện dùng trong loại cáp mạng', N'Cáp quang', N'UTP và STP ', N'Xoắn đôi', N'Đồng trục', N'D', N'TH123   ', N'8d548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (81, N'MMTCB', N'A', N'Mạng không dây dùng loại sóng nào không bị ảnh hưởng bởi khoảng cách địa lý', N'Sóng radio', N'Sống hồng ngoại', N'Sóng viba', N'Song cực ngắn', N'A', N'TH123   ', N'8e548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (82, N'MMTCB', N'A', N'Đường truyền E1 gồm 32 kênh, trong đó sử dụng cho dữ liệu là:', N'32 kênh', N'31 kênh', N'30 kênh', N'24 kênh', N'C', N'TH123   ', N'8f548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (83, N'MMTCB', N'A', N'Mạng máy tính thường sử dụng loại chuyển mach', N'Gói (packet switch)', N'Kênh (Circuit switch)', N'Thông báo(message switch)', N'Tất cả đều đúng', N'A', N'TH123   ', N'90548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (84, N'MMTCB', N'A', N'Cáp UTP hỗ trợ tôc độ truyền 100MBps là loại', N'Cat 3', N'Cat 4', N'Cat 5', N'Cat 6', N'C', N'TH123   ', N'91548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (85, N'MMTCB', N'A', N'Thiết bị nào làm việc trong cấp vật lý (physical) ', N'Terminator', N'Hub', N'Repeater', N'Tất cả đều đúng', N'D', N'TH123   ', N'92548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (86, N'MMTCB', N'A', N'Phương pháp dồn kênh phân chia tần số gọi là', N'FDM', N'WDM', N'TDM', N'CSMA', N'A', N'TH123   ', N'93548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (87, N'MMTCB', N'A', N'Dịch vụ nào không sử dụng trong cấp data link', N'Xác nhận, có kết nối', N'Xác nhận, không kết nôi', N'Không xác nhận, có kết nối', N'Không xác nhận, không kết nối', N'C', N'TH123   ', N'94548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (88, N'MMTCB', N'A', N'Nguyên nhân gây sai sót khi gửi/nhận dữ liệu trên mạng', N'Mất đồng bộ trong khi truyền', N'Nhiễu từ môi trường', N'Lỗi phần cứng hoặc phần mềm', N'Tất cả đều đúng ', N'D', N'TH123   ', N'95548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (89, N'MMTCB', N'A', N'Để tránh sai sót khi truyền dữ liệu trong cấp data link', N'Đánh số thứ tự frame', N'Quản lý dữ liệu theo frame', N'Dùng vùng checksum', N'Tất cả đều đúng', N'D', N'TH123   ', N'96548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (90, N'MMTCB', N'A', N'Quản lý lưu lượng đường truyền là chức năng của cấp', N'Presentation', N'Network', N'Data link', N'Physical', N'C', N'TH123   ', N'97548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (91, N'MMTCB', N'A', N'Hoạt động của protocol Stop and Wait', N'Chờ một khoảng thời gian time-out rồi gửi tiếp frame kế', N'Chờ 1 khoảng thời gian time-out rồi gửi lại frame trước', N'Chờ nhận được ACK của frame trước mới gửi tiếp frame kế', N'Không chờ mà gửi liên tiếp các frame kế nhau', N'C', N'TH123   ', N'98548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (92, N'MMTCB', N'A', N'Protocol nào tạo frame bằng phương pháp chèn kí tự', N'ADCCP', N'HDLC', N'SDLC', N'PPP', N'D', N'TH123   ', N'99548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (93, N'MMTCB', N'A', N'Phương pháp nào được dủng trong việc phát hiện lỗi', N'Timer', N'Ack', N'Checksum', N'Tất cả đều đúng', N'C', N'TH123   ', N'9a548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (94, N'MMTCB', N'A', N'Kiểm soát lưu lượng (flow control) có nghĩa là', N'Thay đổi thứ tự truyền frame', N'Điều tiết tốc độ truyền frame', N'Thay đổi thời gian chờ time-out', N'Điều chỉnh kích thước frame', N'B', N'TH123   ', N'9b548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (95, N'MMTCB', N'A', N'Khả năng nhận biết tình trạng đường truyền ( carrier sence) là', N'Xác định đường truyền tốt hay xấu', N'Có kết nối được hay không', N'Nhận biết có xung đột hay không', N'Đường truyền đang rảnh hay bận', N'C', N'TH123   ', N'9c548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (96, N'MMTCB', N'A', N'Mạng nào không có khả năng nhận biết tình trạng đường truyền (carrier sence)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng ', N'A', N'TH123   ', N'9d548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (97, N'MMTCB', N'A', N'Mạng nào có khả năng nhận biết xung đột (collision)', N'ALOHA', N'CSMA', N'CSMA/CD', N'Tất cả đều đúng', N'D', N'TH123   ', N'9e548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (98, N'MMTCB', N'A', N'Chuẩn mạng nào có khả năng pkhát hiện xung đột (collision) trong khi truyền', N'1-persistent CSMA', N'p-persistent CSMA', N'Non-persistent CSMA', N'CSMA/CD', N'D', N'TH123   ', N'9f548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (99, N'MMTCB', N'A', N'Loại mạng cục bộ nào dùng chuẩn CSMA/CD', N'Token-ring', N'Token-bus', N'Ethernet', N'ArcNet', N'C', N'TH123   ', N'a0548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (100, N'MMTCB', N'A', N'Mạng Ethernet được IEEE đưa vào chuẩn', N'IEEE 802.2', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'B', N'TH123   ', N'a1548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (101, N'MMTCB', N'A', N'Chuẩn nào không dùng trong mạng cục bộ (LAN )', N'IEEE 802.3', N'IEEE 802.4', N'IEEE 802.5', N'IEEE 802.6', N'D', N'TH123   ', N'a2548b13-02e5-ee11-b765-d055e6165ab4')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (102, N'MMTCB', N'A', N'Loại mạng nào dùng 1 máy tính làm Monitor để bảo trì mạng', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'B', N'TH123   ', N'a3548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (103, N'MMTCB', N'A', N'Loại mạng nào không có độ ưu tiên', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'D', N'TH123   ', N'a4548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (104, N'MMTCB', N'A', N'Loại mạng nào dùng 2 loại frame khác nhau trên đường truyền', N'Token-ring', N'Token-bus', N'Ethernet', N'Tất cả đều sai', N'A', N'TH123   ', N'a5548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (105, N'MMTCB', N'A', N'Vùng dữ liệu trong mạng Ethernet chứa tối đa', N'185 bytes', N'1500 bytes', N'8182 bytes', N'Không giới hạn', N'B', N'TH123   ', N'a6548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (106, N'MMTCB', N'A', N'Chọn câu sai:" Cầu nối (bridge) có thể kết nối các mạng có...."', N'Chiều dài frame khác nhau', N'Cấu trúc frame khác nhau', N'Tốc độ truyền khác nhau', N'Chuẩn khác nhau', N'A', N'TH123   ', N'a7548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (107, N'MMTCB', N'A', N'Mạng nào có tốc độ truyền lớn hơn 100Mbps', N'Fast Ethernet', N'Gigabit Ethernet', N'Ethernet', N'Tất cả đều đúng', N'B', N'TH123   ', N'a8548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (108, N'MMTCB', N'A', N'Mạng Ethernet sử dụng được loại cáp', N'Cáp quang', N'Xoắn đôi', N'Đồng trục', N'Tất cả đều đúgn', N'D', N'TH123   ', N'a9548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (109, N'MMTCB', N'A', N'Khoảng cách đường truyền tối đa mạng FDDI có thể đạt', N'1Km', N'10Km', N'100Km', N'1000Km', N'C', N'TH123   ', N'aa548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (110, N'MMTCB', N'A', N'Cấp network truyền nhận theo kiểu end-to-end vì nó quản lý dữ liệu', N'Giữa 2 đầu subnet', N'Giữa 2 máy tính trong mạng', N'Giữa 2 thiết bị trên đường truyền', N'Giữa 2 đầu đường truyền', N'A', N'TH123   ', N'ab548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (111, N'MMTCB', N'A', N'Kiểu mạch ảo(virtual circuit) được dùng trong loại dịch vụ mạng', N'Có kết nối', N'Không kết nối', N'Truyền 1 chiều', N'Truyền 2 chiều', N'A', N'TH123   ', N'ac548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (112, N'MMTCB', N'A', N'Kiểu datagram trong cấp network', N'Chỉ tìm đường 1 lần khi tạo kết nối', N'Phải tìm đường riêng cho từng packet', N'THông tin có sẵn trong packet, không cần tìm đường', N'Thông tin có sẵn trong router , không cần tìm đường', N'B', N'TH123   ', N'ad548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (113, N'MMTCB', N'A', N'Kiểm soát tắc nghẽn (congestion) là nhiệm vụ của cấp', N'Physical', N'Transport', N'Data link', N'Network', N'D', N'TH123   ', N'ae548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (114, N'MMTCB', N'A', N'Nguyên nhân dẫn đến tắt nghẻn (congestion) trên mạng', N'Tốc độ xử lý của router chậm', N'Buffers trong router nhỏ', N'Router có nhiều đường vào nhưng ít đường ra', N'Tất cả đều đúng', N'D', N'TH123   ', N'af548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (115, N'MMTCB', N'A', N'Cấp appliation trong mô hình TCP/IP tương đương với cấp nào trong mô hình OSI', N'Session', N'Application', N'Presentation', N'Tất cả đều đúng', N'D', N'TH123   ', N'b0548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (116, N'MMTCB', N'A', N'Cấp nào trong mô hình mạng OSI tương đương với cấp Internet trong mô hình TCP/IP ', N'Network', N'Transport', N'Physical', N'Data link', N'A', N'TH123   ', N'b1548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (117, N'MMTCB', N'A', N'Chất lượng dịch vụ mạng không được đánh giá trên chỉ tiêu nào?', N'Thời gian thiết lập kết nối ngắn', N'Tỉ lệ sai sót rất nhỏ', N'Tốc độ đường truyền cao', N'Khả năng phục hồi khi có sự cố', N'A', N'TH123   ', N'b2548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (118, N'MMTCB', N'A', N'Kỹ thuật Multiplexing được dùng khi', N'Có nhiều kênh truyền hơn đường truyền', N'Có nhiều đường truyền hơn kênh truyền', N'Truyền dữ liệu số trên mạng điện thoại', N'Truyền dữ liệu tương tự trên mạng điện thọai', N'A', N'TH123   ', N'b3548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (119, N'MMTCB', N'A', N'Dịch vụ truyền Email sử dụng protocol nào?', N'HTTP', N'NNTP', N'SMTP', N'FTP', N'C', N'TH123   ', N'b4548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (120, N'MMTCB', N'A', N'Địa chỉ IP lớp B nằm trong phạm vi nào', N'192.0.0.0 - 223.0.0.0', N'127.0.0.0 - 191.0.0.0', N'128.0.0.0 - 191.0.0.0 ', N'1.0.0.0 - 126.0.0.0', N'C', N'TH123   ', N'b5548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (121, N'MMTCB', N'A', N'Subnet Mask nào sau đây chỉ cho tối đa 2 địa chỉ host', N'255.255.255.252', N'255.255.255.254', N'255.255.255.248', N'255.255.255.240', N'A', N'TH123   ', N'b6548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (122, N'MMTCB', N'A', N'Thành phần nào không thuộc socket', N'Port', N'Địa chỉ IP', N'Địa chỉ cấp MAC', N'Protocol cấp Transport', N'C', N'TH123   ', N'b7548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (123, N'MMTCB', N'A', N'Mục đích của Subnet Mask trong địa chỉ IP là', N'Xác định host của địa chỉ IP', N'Xác định vùng network của địa chỉ IP', N'Lấy các bit trong vùng subnet làm địa chỉ host', N'Lấy các bit trong vùng địa chỉ host làm subnet', N'A', N'TH123   ', N'b8548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (124, N'MMTCB', N'A', N'Bước đầu tiên cần thực hiện để truyền dữ liệu theo ALOHA là', N'Chờ 1 thời gian ngẫu nhiên', N'Gửi tín hiệu tạo kết nối', N'Kiểm tra tình trạng đường truyền', N'Lập tức truyền dữ liệu', N'D', N'TH123   ', N'b9548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (125, N'MMTCB', N'A', N'Cầu nối trong suốt hoạt động trong cấp nào', N'Data link', N'Physical', N'Network', N'Transport', N'A', N'TH123   ', N'ba548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (126, N'MMTCB', N'A', N'Tốc độ của đường truyền T1 là:', N'2048 Mbps', N'1544 Mbps', N'155 Mbps', N'56 Kbps', N'B', N'TH123   ', N'bb548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (127, N'MMTCB', N'A', N'Khi một dịch vụ trả lời ACK cho biết dữ liệu đã nhận được, đó là', N'Dịch vụ có xác nhận', N'Dịch vụ không xác nhận', N'Dịch vụ có kết nối', N'Dịch vụ không kết nối', N'A', N'TH123   ', N'bc548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (128, N'MMTCB', N'A', N'Loại frame nào được sử dụng trong mạng Token-ring', N'Monitor', N'Token', N'Data', N'Token và Data', N'D', N'TH123   ', N'bd548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (129, N'MMTCB', N'A', N'Thuật ngữ OSI là viết tắt bởi', N'Organization for Standard Institude', N'Organization for Standard Internet', N'Open Standard Institude', N'Open System Interconnection', N'D', N'TH123   ', N'be548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (130, N'MMTCB', N'A', N'Trong mạng Token-ting, khi 1 máy nhận được Token', N'Nó phải truyền cho máy kế trong vòng', N'Nó được quyền truyền dữ liệu', N'Nó được quyền giữ lại Token', N'Tất cả đều sai', N'B', N'TH123   ', N'bf548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (131, N'MMTCB', N'A', N'Trong mạng cục bộ, để xác định 1 máy trong mạng ta dùng địa chỉ', N'MAC', N'Socket', N'Domain', N'Port', N'A', N'TH123   ', N'c0548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (132, N'MMTCB', N'A', N'Thứ tự các cấp trong mô hình OSI', N'Application,Session,Transport,Physical', N'Application, Transport, Network, Physical', N'Application, Presentation,Session,Network,Transport,Data link,Physical', N'Application,Presentation,Session,Transport,Network,Data link,Physical', N'D', N'TH123   ', N'c1548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (133, N'MMTCB', N'A', N'Cấp vật lý (physical) không quản lý', N'Mức điện áp', N'Địa chỉ vật lý', N'Mạch giao tiếp vật lý', N'Truyền các bit dữ liêu', N'B', N'TH123   ', N'c2548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (134, N'MMTCB', N'A', N'TCP sử dụng loại dịch vụ', N'Có kết nối, độ tin cậy cao', N'Có kết nối, độ tin cậy thấp', N'Không kết nối, độ tin cậy cao', N'Không kết nối, độ tin cậy thấp', N'A', N'TH123   ', N'c3548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (135, N'MMTCB', N'A', N'Địa chỉ IP bao gồm', N'Địa chỉ Network và địa chỉ host', N'Địa chỉ physical và địa chỉ logical', N'Địa chỉ cấp MAC và và địa chỉ LLC', N'Địa chỉ hardware và địa chỉ software', N'A', N'TH123   ', N'c4548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (136, N'MMTCB', N'A', N'Chức năng cấp mạng (network) là', N'Mã hóa và định dạng dữ liệu', N'Tìm đường và kiểm soát tắc nghẽn', N'Truy cập môi trường mạng', N'Kiểm soát lỗi và kiểm soát lưu lượng', N'B', N'TH123   ', N'c5548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (137, N'MMTCB', N'A', N'Mạng CSMA/CD làm gì', N'Truyền Token trên mạng hình sao', N'Truyền Token trên mạng dạng Bus', N'Chia packet ra thành từng frame nhỏ và truỵền đi trên mạng', N'Truy cập đường truyền và truyền lại dữ liệu nếu xảy ra đụng độ', N'D', N'TH123   ', N'c6548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (138, N'MMTCB', N'A', N'Tiền thân của mạng Internet là', N'Intranet', N'Ethernet', N'Arpanet', N'Token-bus', N'C', N'TH123   ', N'c7548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (139, N'MMTCB', N'A', N'Khi 1 cầu nối ( bridge) nhận được 1 framechưa biết thông tin về địa chỉ máy nhận, nó sẽ', N'Xóa bỏ frame này', N'Gửi trả lại máy gốc', N'Gửi đến mọi ngõ ra còn lại', N'Giảm thời gian sống của frame đi 1 đơn vị và gửi đến mọi ngõ ra còn lại', N'C', N'TH123   ', N'c8548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (140, N'MMTCB', N'A', N'Chức năng của cấp Network là', N'Tìm đường', N'Mã hóa dữ liệu', N'Tạo địa chỉ vật lý', N'Kiểm soát lưu lượng', N'A', N'TH123   ', N'c9548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (141, N'MMTCB', N'B', N'Sự khác nhau giữa địa chỉ cấp Data link và Network là', N'Địa chỉ cấp Data link có kích thước nhỏ hơn địa chỉ cấp Network', N'Địa chỉ cấp Data link là đia chỉ Physic, địa chỉ cấp Network là địa chỉ Logic', N'Địa chỉ cấp Data Link là địa chỉ Logic, địa chỉ câp Network là địa chỉ Physic', N'Địa chỉ Data link cấu hình theo mạng, địa chỉ cấp Network xác định theo IEEE', N'B', N'TH123   ', N'ca548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (142, N'MMTCB', N'B', N'Kỹ thuật nào không sử dụng được trong việc kiểm soát lưu lượng(flow control)', N'Ack', N'Buffer', N'Windowing', N'Multiplexing', N'D', N'TH123   ', N'cb548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (143, N'MMTCB', N'B', N'Cấp cao nhất trong mô hình mạng OSI là', N'Transport', N'Physical', N'Network', N'Application', N'D', N'TH123   ', N'cc548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (144, N'MMTCB', N'B', N'Tại sao mạng máy tình dùng mô hình phân cấp', N'Để mọi người sử dụng cùng 1 ứng dụng mạng', N'Để phân biệt giữa chuẩn mạng và ứng dụng mạng', N'Giảm độ phức tạp trong việc thiết kế và cài đặt', N'Các cấp khác không cần sửa đổi khi thay đổi 1 cấp mạng', N'D', N'TH123   ', N'cd548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (145, N'MMTCB', N'B', N'Router làm gì để giảm tăc nghẽn (congestion)', N'Nén dữ liệu', N'Lọc bớt dữ liệu theo địa chỉ vật lý', N'Lọc bớt dữ liệu theo địa chỉ logic', N'Cấm truyền dữ liệu broadcasr', N'D', N'TH123   ', N'ce548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (146, N'MMTCB', N'B', N'Byte đầu của 1 IP có giá trị 222, địa chỉ này thuộc lớp địa chỉ nào', N'Lớp A', N'Lớp B', N'Lớp C', N'Lớp D', N'C', N'TH123   ', N'cf548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (147, N'MMTCB', N'B', N'Chọn câu đúng đối với switch của mạng LAN', N'Là 1 cầu nối tốc độ cao', N'Nhận data từ 1 cổng và xuất ra mọi cổng còn lại', N'Nhận data từ 1 cổng và xuất ra  cổng đích tùy theo địa chỉ cấp IP', N'Nhận data từ 1 cổng và xuất ra 1 cổng đích tùy theo địa chỉ cấp MAC', N'D', N'TH123   ', N'd0548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (148, N'MMTCB', N'B', N'Thuật ngữ nào cho biết loại mạng chỉ truyền được  chiều tại 1 thời điểm', N'Half duplex', N'Full duplex', N'Simplex', N'Monoplex', N'A', N'TH123   ', N'd1548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (149, N'MMTCB', N'B', N'Protocol nghĩa là', N'Tập các chuẩn truyền dữ liệu', N'Tập các cấp mạng trong mô hình OSI', N'Tập các chức năng của từng cấp trong mạng', N'Tập các qui tắc và cấu trúc dữ liệu để truyền thông giữa các cấp mạng', N'D', N'TH123   ', N'd2548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (150, N'MMTCB', N'B', N'Truyền dữ liệu theo kiểu có kết nối không cần thực hiện việc', N'Hủy kết nối', N'Tạo kết nối', N'Truyền dữ liệu', N'Tìm đường cho từng gói tin', N'D', N'TH123   ', N'd3548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (151, N'MMTCB', N'B', N'Byte đầu của địa chỉ IP lớp E nằm trong phạm vi', N'128 - 191', N'192 - 232 ', N'224 - 239 ', N'240 - 247', N'D', N'TH123   ', N'd4548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (152, N'MMTCB', N'B', N'Khi truyền đi chuỗi "VIET NAM" nhưng nhận được chuỗi"MAN TEIV ". Cần phải hiệu chỉnh các protocol trong cấp nào để truyền chính xác', N'Session', N'Transport', N'Application', N'Presentation', N'B', N'TH123   ', N'd5548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (153, N'MMTCB', N'B', N'Tên cáp UTP dùng torng mạng Fast Ethernet là', N'100BaseF', N'100Base2', N'100BaseT', N'100Base5', N'C', N'TH123   ', N'd6548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (154, N'MMTCB', N'B', N'Tốc độ truyền của mạng Ethernet là', N'1 Mbps', N'10 Mbps', N'100 Mbps', N'1000 Mbps', N'B', N'TH123   ', N'd7548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (155, N'MMTCB', N'B', N'Dịch vụ mạng thường được phân chia thành', N'Dịch vụ không kết nối và có kết nối', N'Dich vụ có xác nhận và không xác nhận', N'Dịch vụ có độ tin cậy cao và có độ tin cậy thấp', N'Tất cả đều đúng', N'D', N'TH123   ', N'd8548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (156, N'MMTCB', N'B', N'Đơn vị truyền dữ liệu trong cấp Network gọi là', N'Bit', N'Frame', N'Packet', N'Segment', N'C', N'TH123   ', N'd9548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (157, N'MMTCB', N'B', N'Protocol nào trong mạng TCP/IP chuyển đổi địa chỉ vật lý thành địa chỉ IP', N'IP', N'ARP', N'ICMP', N'RARP', N'D', N'TH123   ', N'da548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (158, N'MMTCB', N'B', N'Đầu nới AUI dùng cho loại cáp nào?', N'Đồng trục', N'Xoắn đôi', N'Cáp quang', N'Tất cả đều đúng', N'A', N'TH123   ', N'db548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (159, N'MMTCB', N'B', N'Subnet mask chuẩn của địa chỉ IP lớp B là', N'255.0.0.0', N'255.255.0.0', N'255.255.255.0', N'255.255.255.255', N'B', N'TH123   ', N'dc548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (160, N'MMTCB', N'B', N'Lý do nào khiến người ta chọn protocol TCP hơn là UDP', N'Không ACK', N'Dễ sử dụng', N'Độ tin cậy', N'Không kết nối', N'C', N'TH123   ', N'dd548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (161, N'MMTCB', N'B', N'Nhược điểm của dịch vụ có kết nối so với không kết nối', N'Độ tin cậy', N'Thứ tự nhận dữ liệu không đúng', N'Đường truyền không thay đổi', N'Đường truyền thay đổi liên tục', N'C', N'TH123   ', N'de548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (162, N'MMTCB', N'B', N'Cấp Data link không thực hiện chức năng nào?', N'Kiểm soát lỗi', N'Địa chỉ vật lý', N'Kiểm soát lưu lượng', N'Thiết lập kết nối', N'D', N'TH123   ', N'df548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (163, N'MMTCB', N'B', N'Cầu nối (bridge)dựa vào thông tin nào để truyền tiếp hoặc hủy bỏ 1 frame', N'Điạ chỉ nguồn', N'Địa chỉ đích', N'Địa chỉ mạng', N'Tất cả đều đúng', N'C', N'TH123   ', N'e0548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (164, N'MMTCB', N'B', N'Chuẩn nào sử dụng trong cấp presentation?', N'UTP và STP', N'SMTP và HTTP', N'ASCII và EBCDIC', N'TCP và UDP', N'C', N'TH123   ', N'e1548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (165, N'MMTCB', N'B', N'Đơn vị truyền dữ liệu giữa các cấp trong mạng theo thứ tự', N'bit,frame,packet,data', N'bit,packet,frame,data', N'data,frame,packet,bit', N'data,bit,packet,frame', N'A', N'TH123   ', N'e2548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (166, N'MMTCB', N'B', N'Mạng Ethernet do cơ quan nào phát minh', N'ANSI', N'ISO', N'IEEE', N'XEROX', N'D', N'TH123   ', N'e3548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (167, N'MMTCB', N'B', N'Chiều dài loại cáp nào tối đa 100 m? ', N'10Base2', N'10Base5', N'10BaseT', N'10BaseF', N'C', N'TH123   ', N'e4548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (168, N'MMTCB', N'B', N'Địa chỉ IP 100.150.200.250 có nghĩa là', N'Địa chỉ network 100, địa chỉ host 150.200.250', N'Địa chỉ network 100.150, địa chỉ host 200.250', N'Địa chỉ network 100.150.200, địa chỉ host 250', N'Tất cả đều sai', N'D', N'TH123   ', N'e5548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (169, N'MMTCB', N'B', N'Switching hun khác hub thông thường ở chỗ nó làm', N'Giảm collision trên mạng', N'Tăng collision trên mạng', N'Giảm congestion trên mạng', N'Tăng congestion trên mạng', N'A', N'TH123   ', N'e6548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (170, N'MMTCB', N'B', N'Loại cáp nào chỉ truyền dữ liệu 1 chiều', N'Cáp quang', N'Xoắn đôi', N'Đồng trục', N'Tất cả đều đúng', N'A', N'TH123   ', N'e7548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (171, N'MMTCB', N'B', N'Thiết bị Modem dùng để', N'Tách và ghép tín hiệu', N'Nén và gải nén tín hiệu', N'Mã hóa và giải mã tín hiệu', N'Điều chế và giải điều chế tín hiệu', N'D', N'TH123   ', N'e8548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (172, N'MMTCB', N'B', N'Việc cấp phát kênh truyền áp dụng cho loại mạng', N'Peer to peer', N'Point to point', N'Broadcast', N'Multiple Access', N'C', N'TH123   ', N'e9548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (173, N'MMTCB', N'B', N'Mạng nào dùng phương pháp mã hóa Manchester Encoding', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều đúng ', N'D', N'TH123   ', N'ea548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (174, N'MMTCB', N'B', N'Phương pháp tìm đường có tính đến thời gian trễ', N'Tìm đường theo chiều sâu', N'Tìm đường theo chiều rộng', N'Tìm đường theo vector khoảng cách', N'Tìm đường theo trạng thái đường truyền', N'D', N'TH123   ', N'eb548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (175, N'MMTCB', N'B', N'Chuẩn mạng nào khi có dữ liệu không truyền ngay mà chờ 1 thời gian ngẫu nhiên?', N'1-presistent CSMA', N'p-presistent CSMA', N'Non-presistent CSMA', N'CSMA/CD', N'C', N'TH123   ', N'ec548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (176, N'MMTCB', N'B', N'Phương pháp chèn bit (bit stuffing) được dùng để', N'Phân biệt đầu và cuối frame', N'Bổ sung cho đủ kích thước frame tối thiểu', N'Phân cách nhiều bit 0 bằng bit 1', N'Biến đổi dạng dữ liệu 8 bit ra 16 bit', N'A', N'TH123   ', N'ed548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (177, N'MMTCB', N'B', N'Để chống nhiễu trên đường truyền tốt nhất, nên dùng loại cáp:', N'Xoắn đôi', N'Đồng trục', N'Cáp quang', N'Mạng không dây', N'C', N'TH123   ', N'ee548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (178, N'MMTCB', N'B', N'Phần mềm gửi/nhận thư điện tử thuộc cấp nào trong mô hình OSI', N'Data link', N'Network', N'Application', N'Presentation', N'C', N'TH123   ', N'ef548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (179, N'MMTCB', N'B', N'Chức năng của thiết bị Hub trong mạng LAN', N'Mã hóa tín hiệu', N'Triệt tiêu tín hiệu', N'Phân chia tín hiệu', N'Điều chế tín hiếu', N'C', N'TH123   ', N'f0548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (180, N'MMTCB', N'B', N'Switch là thiết bị mạng làm việc tương tự như', N'Hub', N'Repeater', N'Router', N'Bridge', N'D', N'TH123   ', N'f1548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (181, N'MMTCB', N'C', N'Thiết bị nào làm việc trong cấp Network', N'Bridge', N'Repeater', N'Router', N'Gateway', N'C', N'TH123   ', N'f2548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (182, N'MMTCB', N'C', N'Thiết bị nào cần có bộ nhớ làm buffer', N'Hub', N'Switch', N'Repeater', N'Router', N'D', N'TH123   ', N'f3548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (183, N'MMTCB', N'C', N'Luật 5-4-3 cho phép tối đa', N'5 segment trong 1 mạng', N'5 repeater trong 1 mạng', N'5 máy tính trong 1 mạng', N'5 máy tính trong 1 segment', N'A', N'TH123   ', N'f4548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (184, N'MMTCB', N'C', N'Thiết bị nào có thể thêm vào mạng LAN mà không sợ vi phạm luật 5-4-3', N'Router', N'Repeater', N'Máy tính', N'Tất cả đều đúng', N'A', N'TH123   ', N'f5548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (185, N'MMTCB', N'C', N'Thêm thiết bị nào vào mạng có thể qui phạm luật 5-4-3', N'Router', N'Repeater', N'Bridge', N'Tất cả đều đúng', N'B', N'TH123   ', N'f6548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (186, N'MMTCB', N'C', N'Mạng nào cóxảy ra xung đột (collision) trên đường truyền', N'Ethernet', N'Token-ring', N'Token-bus', N'Tất cả đều sai', N'A', N'TH123   ', N'f7548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (187, N'MMTCB', N'C', N'Từ "Broad" trong tên cáp 10Broad36 viết tắt bởi', N'Broadcast', N'Broadbase', N'Broadband', N'Broadway', N'C', N'TH123   ', N'f8548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (188, N'MMTCB', N'C', N'Protocol nào sử dụng trong cấp Network', N'IP', N'TCP', N'UDP', N'FTP', N'A', N'TH123   ', N'f9548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (189, N'MMTCB', N'C', N'Protocol nào torng cấp Transport cung cấp dịch vụ không kết nối', N'IP', N'TCP', N'UDP', N'FTP', N'C', N'TH123   ', N'fa548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (190, N'MMTCB', N'C', N'Protocol nào trong cấp Transport dùng kiểu dịch vụ có kết nối?', N'IP', N'TCP', N'UDP', N'FTP', N'B', N'TH123   ', N'fb548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (191, N'MMTCB', N'C', N'Địa chỉ IP được chia làm mấy lớp', N'2', N'3', N'4', N'5', N'D', N'TH123   ', N'fc548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (192, N'MMTCB', N'C', N'Chức năng nào không phải của cấp Network', N'Tìm đường', N'Địa chỉ logic', N'Kiểm soát tắc nghẽn', N'Chất lượng dịch vụ', N'B', N'TH123   ', N'fd548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (193, N'MMTCB', N'C', N'Phương pháp chèn kí tự dùng để', N'Phân cách các frame', N'Phân biệt dữ liệu và ký tự điều khiển', N'Nhận diện đầu cuối frame', N'Bổ sung cho đủ kich thước frame tối thiểu', N'B', N'TH123   ', N'fe548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (194, N'MMTCB', N'C', N'Kỹ thuật truyền nào mã hóa trực tiếp dữ liệu ra đường truyền không cần sóng mang', N'Broadcast', N'Digital', N'Baseband', N'Broadband', N'C', N'TH123   ', N'ff548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (195, N'MMTCB', N'C', N'Sóng viba sử dụng băng tần', N'SHF', N'LF và MF', N'UHF và VHF', N'Tất cả đều đúng', N'D', N'TH123   ', N'00558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (196, N'MMTCB', N'C', N'Sóng viba bị ảnh hưởng bời', N'Trời mưa', N'Sấm chớp', N'Giông bão', N'Ánh sáng mặt trời', N'A', N'TH123   ', N'01558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (197, N'MMTCB', N'C', N'Đường dây trung kế trong mạng điện thoại sử dụng', N'Tín hiệu số', N'Kỹ thuật dồn kênh', N'Cáp quang, cáp đồng và viba', N'Tất cả đêu đúng', N'D', N'TH123   ', N'02558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (198, N'MMTCB', N'C', N'Cáp quang dùng công nghệ dồn kênh nào', N'TDM', N'FDM', N'WDM', N'CDMA', N'C', N'TH123   ', N'03558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (199, N'MMTCB', N'C', N'Nhược điểm của phương pháp chèn ký tự', N'Giảm tốc độ đường truyền', N'Tăng phí tổn đường truyền', N'Mất đồng bộ frame', N'Không nhận diện được frame', N'B', N'TH123   ', N'04558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (200, N'MMTCB', N'C', N'Mất đồng bộ frame xảy ra đối với phương pháp', N'Chèn bit', N'Đếm ký tự', N'Chèn ký tự', N'Tất cả đều đúng', N'B', N'TH123   ', N'05558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (201, N'MMTCB', N'C', N'Mạng nào dùng công nghệ Token-bus', N'FDDI', N'CDDI', N'Fast Ethernet', N'100VG-AnyLAN', N'D', N'TH123   ', N'06558b13-02e5-ee11-b765-d055e6165ab4')
GO
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (202, N'MMTCB', N'C', N'Thiết bị nào tự trao đổi thông tin lẫn nhau để quản lý mạng', N'Hub', N'Bridge', N'Router', N'Repeater', N'C', N'TH123   ', N'07558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (203, N'MMTCB', N'C', N'Tần số sóng điện từ dùng trong mạng vô tuyến sắp theo thứ tự tăng dần', N'Radio,viba,hồng ngoại', N'Radio,hồng ngoại,viba', N'Hồng ngoại,viba,radio', N'Viba,radio,hồng ngoại', N'A', N'TH123   ', N'08558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (204, N'MMTCB', N'C', N'Đường dây hạ kế (local loop) trong mạch điện thoại dùng tín hiệu', N'Digital', N'Analog', N'Manchester', N'T1 hoặc E1', N'B', N'TH123   ', N'09558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (205, N'MMTCB', N'C', N'Để tránh nhận trùng dữ liệu người ta dùng phương pháp', N'Đánh số thứ tự các frame', N'Quy định kích thước frame cố định', N'Chờ nhận ACK mới gửi frame kế tiếp', N'So sánh và loại bỏ các frame giống nhau', N'A', N'TH123   ', N'0a558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (206, N'MMTCB', N'C', N'Cơ chế Timer dùng để', N'Đo thời gian chơ frame', N'Tránh tình trạng mất frame', N'Chọn thời điểm truyền frame', N'Kiểm soát thòi gian truyền frame', N'A', N'TH123   ', N'0b558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (207, N'MMTCB', N'C', N'Cấp nào trong mô hình OSI quan tâm tới topology mạng', N'Transport', N'Network', N'Data link', N'Physical', N'B', N'TH123   ', N'0c558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (208, N'MMTCB', N'C', N'Loại mạng nào sử dụng trên WAN', N'Ethernet và Token-bus', N'ISDN và Frame relay', N'Token-ring và FDDI', N'SDLC và HDLC', N'A', N'TH123   ', N'0d558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (209, N'MMTCB', N'C', N'Repeater nhiều port là tên gọi của', N'Hub', N'Host', N'Bridge', N'Router', N'A', N'TH123   ', N'0e558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (210, N'MMTCB', N'C', N'Đơn vị đo tốc độ đường truyền', N'bps(bit per second)', N'Bps(Byte per second)', N'mps(meter per second)', N'hertz (ccle per second)', N'A', N'TH123   ', N'0f558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (211, N'MMTCB', N'C', N'Repeater dùng để', N'Lọc bớt dữ liệu trên mạng', N'Tăng tốc độ lưu thông trên mạng', N'Tăng thời gian trễ trên mạng', N'Mở rộng chiều dài đường truyền', N'D', N'TH123   ', N'10558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (212, N'MMTCB', N'C', N'Cáp đồng trục (coaxial)', N'Có 4 đôi dây', N'Không cần repeater', N'Truyền tín hiệu ánh sáng', N'Chống nhiễu tốt hơn UTP', N'D', N'TH123   ', N'11558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (213, N'MMTCB', N'C', N'Câp Data link ', N'Truyền dữ liệu cho các cấp khác trong mạng', N'Cung cấp dịch vụ cho chương trình ứng dụng', N'Nhận tín hiệu yếu,lọc,khuếch đại và phát lại trên mạng', N'Bảo đảm đường truyền dữ liệu tin cậy giữa 2 đầu đường truyền', N'D', N'TH123   ', N'12558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (214, N'MMTCB', N'C', N'Địa chỉ IP còn gọi là', N'Địa chĩ vật lý', N'Địa chỉ luận lý', N'Địa chỉ thập phân', N'Địa chỉ thập lục phân', N'B', N'TH123   ', N'13558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (215, N'MMTCB', N'C', N'Cấp Presentation', N'Thiết lập, quản lý và kết thúc các ứng dụng', N'Hướng dẫn cách mô tả hình ảnh, âm thanh, tiếng nói', N'Cung cấp dịch vụ truyền dữ liệu từ nguồn đến đích', N'Hỗ trợ việc truyền thông trong các ứng dụng như web, mail...', N'C', N'TH123   ', N'14558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (216, N'MMTCB', N'C', N'Tập các luật để định dạng và truyền dữ liệu gọi là', N'Qui luật (rule)', N'Nghi thức (protocol)', N'Tiêu chuẩn (standard)', N'Mô hình (model)', N'B', N'TH123   ', N'15558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (217, N'MMTCB', N'C', N'Tại sao cần có tiêu chuẩn về mang', N'Định hướng phát triển phần cứng và phần mềm mới', N'LAN,MAN và WAN sử dụng các thiết bị khác nhau', N'Kết nối mạng giữa các quôc gia khác nhau', N'Tương thích về công nghệ để truyền thông được lẫn nhau', N'D', N'TH123   ', N'16558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (218, N'MMTCB', N'C', N'Dữ liệu truyền trên mạng bằng', N'Mã ASCII', N'Số nhị phân', N'Không và một', N'Xung điện áp', N'D', N'TH123   ', N'17558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (219, N'MMTCB', N'C', N'Mạng CSMA/CD', N'Kiểm tra để bảo đảm dữ liệu truyền đến đích', N'Kiểm tra đường truyền nếu rảnh mới truyền dữ liệu', N'Chờ 1 thời gian ngẫu nhiên rồi truyền  dữ liệu kế tiếp', N'Tất cả đều đúng', N'B', N'TH123   ', N'18558b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[BODE] ([CAUHOI], [MAMH], [TRINHDO], [NOIDUNG], [A], [B], [C], [D], [DAP_AN], [MAGV], [rowguid]) VALUES (220, N'MMTCB', N'C', N'Địa chỉ MAC ', N'Gồm có 32 bit', N'Còn gọi là địa chỉ logic', N'Nằm trong cấp Network', N'Dùng để phân biệt các máy trong mạng', N'D', N'TH123   ', N'19558b13-02e5-ee11-b765-d055e6165ab4')
GO
INSERT [dbo].[COSO] ([MACS], [TENCS], [DIACHI], [rowguid]) VALUES (N'CS1', N'Cơ sở 1 ', N'11 Nguyễn Đình Chiểu, Phường Đakao, Quận 1, TP. HCM', N'21548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[COSO] ([MACS], [TENCS], [DIACHI], [rowguid]) VALUES (N'CS2', N'Cơ sở 2', N'Số 9 Man Thiện , quận 9, TP. HCM', N'22548b13-02e5-ee11-b765-d055e6165ab4')
GO
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 20, N'D', N'3951dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 21, N'A', N'2a51dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 22, N'D', N'2851dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 23, N'A', N'3651dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 24, N'C', N'3051dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 25, N'B', N'3551dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 26, N'B', N'2951dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 27, N'B', N'2d51dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 28, N'B', N'3851dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 29, N'B', N'3251dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 50, N'B', N'3b51dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 51, N'B', N'2f51dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 52, N'B', N'3a51dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 53, N'B', N'3451dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 54, N'B', N'3151dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 55, N'B', N'3751dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 56, N'B', N'3351dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 57, N'B', N'2e51dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 58, N'B', N'2c51dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'001AVCB1  ', 59, N'B', N'2b51dfe1-f737-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 20, N'D', N'5671f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 21, N'B', N'4e71f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 22, N'C', N'5971f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 23, N'C', N'5371f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 24, N'C', N'5a71f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 25, N'C', N'5471f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 26, N'C', N'4c71f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 27, N'C', N'4f71f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 28, N'C', N'4471f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 29, N'C', N'5571f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 35, N'C', N'5271f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 37, N'C', N'4271f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 50, N'C', N'4b71f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 51, N'C', N'4d71f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 52, N'C', N'5871f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 53, N'C', N'5171f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 54, N'C', N'4771f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 55, N'C', N'4671f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 56, N'C', N'4571f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 57, N'C', N'4871f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 58, N'C', N'4971f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 59, N'C', N'4a71f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 62, N'C', N'5771f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 65, N'C', N'5071f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002AVCB1  ', 69, N'C', N'4371f1ea-c534-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 4, N'C', N'884af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 5, N'C', N'a64af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 6, N'C', N'c54af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 7, N'C', N'894af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 8, N'C', N'be4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 9, N'C', N'9d4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 10, N'C', N'8a4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 11, N'C', N'9e4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 12, N'C', N'c24af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 13, N'C', N'924af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 14, N'C', N'ae4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 15, N'C', N'994af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 16, N'C', N'974af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 17, N'C', N'a24af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 18, N'C', N'8e4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 19, N'C', N'c84af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 80, N'C', N'c14af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 81, N'C', N'984af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 82, N'C', N'a34af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 83, N'C', N'964af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 84, N'C', N'c64af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 85, N'C', N'c94af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 86, N'C', N'8b4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 87, N'C', N'a44af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 88, N'C', N'a74af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 89, N'C', N'b74af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 90, N'C', N'ba4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 91, NULL, N'b94af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 92, N'C', N'c74af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 93, NULL, N'8f4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 94, NULL, N'944af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 96, NULL, N'8d4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 98, NULL, N'b24af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 99, NULL, N'aa4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 100, NULL, N'c04af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 101, NULL, N'c44af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 102, NULL, N'a54af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 104, NULL, N'a04af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 105, NULL, N'9a4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 106, NULL, N'c34af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 107, NULL, N'9b4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 108, NULL, N'ac4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 109, NULL, N'cc4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 111, NULL, N'ab4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 112, NULL, N'b64af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 113, NULL, N'b54af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 114, NULL, N'934af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 115, NULL, N'954af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 116, NULL, N'af4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 117, NULL, N'cb4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 118, NULL, N'a14af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 119, NULL, N'8c4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 120, NULL, N'b44af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 121, N'C', N'904af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 123, NULL, N'ad4af062-7b34-ef11-b7c5-ec2e98e3b030')
GO
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 124, NULL, N'bf4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 125, NULL, N'9f4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 126, NULL, N'bb4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 127, NULL, N'ca4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 128, NULL, N'bd4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 129, NULL, N'b84af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 130, NULL, N'cd4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 132, NULL, N'a84af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 133, NULL, N'9c4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 134, N'B', N'b34af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 135, NULL, N'bc4af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 137, NULL, N'914af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 138, NULL, N'b14af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 139, NULL, N'a94af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'002MMTCB  ', 140, NULL, N'b04af062-7b34-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 21, NULL, N'580111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 23, NULL, N'570111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 24, NULL, N'5a0111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 25, NULL, N'590111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 27, NULL, N'550111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 50, NULL, N'5c0111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 51, NULL, N'560111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 52, NULL, N'5d0111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 55, NULL, N'5b0111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'999AVCB1  ', 59, NULL, N'540111a8-0539-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'BD1       ', 1, N'a', N'e49c3323-7aea-ee11-b76a-dbdbe3260541')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'N21CN167MM', 114, N'C', N'6a78453c-ee38-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'N21CN167MM', 126, N'C', N'6f78453c-ee38-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'N21CN167MM', 128, N'D', N'6978453c-ee38-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'N21CN167MM', 129, N'B', N'6c78453c-ee38-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'N21CN167MM', 134, N'D', N'6e78453c-ee38-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[CTBAITHI] ([MABANGDIEM], [CAUHOI], [DAPANSV], [rowguid]) VALUES (N'N21CN167MM', 135, N'B', N'6678453c-ee38-ef11-b7c9-ec2e98e3b030')
GO
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH101   ', N'KIEU DAC', N'THIEN', N'9,3A, Q.BINH TAN', N'CNTT    ', N'2a548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH111   ', N'PHAM NGOC', N'LY', N'72 THONG NHAT, DUC TRONG, LAM DONG', N'CNDPT   ', N'b0040c93-a138-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH123   ', N'PHAN VAN ', N'HAI', N'15/72 LE VAN THO F8 GO VAP', N'CNTT    ', N'2b548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH222   ', N'NGO QUYET', N'THANG', N'72a HIEP PHU, HIEPTHANH, DUCTRONG, LAM DONG', N'VT      ', N'7dd93cad-a138-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH234   ', N'DAO VAN ', N'TUYET', N'14/7 BUI DINH TUY TAN BINH', N'CNTT    ', N'2c548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[GIAOVIEN] ([MAGV], [HO], [TEN], [DIACHI], [MAKH], [rowguid]) VALUES (N'TH657   ', N'PHAN HONG', N'NGOC', N'DC1', N'VT      ', N'2d548b13-02e5-ee11-b765-d055e6165ab4')
GO
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH234   ', N'AVCB ', N'D18CQCN01      ', N'A', CAST(N'2024-07-03T00:00:00.000' AS DateTime), 1, 10, 2, N'1dce3f90-0439-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH123   ', N'AVCB ', N'TH04           ', N'A', CAST(N'2024-07-02T00:00:00.000' AS DateTime), 1, 25, 30, N'6b9353de-6934-ef11-b7c5-ec2e98e3b030')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH657   ', N'AVCB ', N'VT04           ', N'A', CAST(N'2024-06-29T00:00:00.000' AS DateTime), 1, 20, 25, N'61fcd268-0d36-ef11-b7c6-ec2e98e3b030')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH123   ', N'MMTCB', N'D21DQCN02      ', N'A', CAST(N'2024-07-03T00:00:00.000' AS DateTime), 1, 10, 2, N'2ce65c80-f038-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH101   ', N'MMTCB', N'TH04           ', N'A', CAST(N'2024-06-27T00:00:00.000' AS DateTime), 1, 70, 60, N'f5096ad8-6aea-ee11-b76a-dbdbe3260541')
INSERT [dbo].[GIAOVIEN_DANGKY] ([MAGV], [MAMH], [MALOP], [TRINHDO], [NGAYTHI], [LAN], [SOCAUTHI], [THOIGIAN], [rowguid]) VALUES (N'TH123   ', N'MMTCB', N'VT04           ', N'A', CAST(N'2024-07-03T00:00:00.000' AS DateTime), 1, 10, 2, N'6399fcd0-e238-ef11-b7c9-ec2e98e3b030')
GO
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'CNDPT   ', N'Công Nghệ Đa Phương Tiện 1', N'CS1', N'8c20da66-0aea-ee11-b76a-dbdbe3260541')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'CNTT    ', N'Công nghệ thông tin', N'CS1', N'27548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'DT      ', N'Điện tử', N'CS2', N'28548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[KHOA] ([MAKH], [TENKH], [MACS], [rowguid]) VALUES (N'VT      ', N'Viễn thông', N'CS2', N'29548b13-02e5-ee11-b765-d055e6165ab4')
GO
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'D18CQCN01      ', N'Ngành CNTT Khóa 2018 - 1', N'CNTT    ', N'2e548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'D21DQCN02      ', N'Công nghệ thông tin 2 - K21', N'CNTT    ', N'64b7375f-9d37-ef11-b7c7-ec2e98e3b030')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH04           ', N'TIN HOC 2004', N'CNTT    ', N'2f548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH05           ', N'TIN HOC 2005', N'CNTT    ', N'30548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH06           ', N'TIN HOC 2006', N'CNTT    ', N'31548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH07           ', N'TIN HOC 2007', N'CNTT    ', N'32548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'TH08           ', N'TIN HOC 2008', N'CNTT    ', N'33548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[LOP] ([MALOP], [TENLOP], [MAKH], [rowguid]) VALUES (N'VT04           ', N'VIỄN THÔNG 2004', N'VT      ', N'34548b13-02e5-ee11-b765-d055e6165ab4')
GO
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'AVCB ', N'ANH VĂN CĂN BẢN', N'23548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CSDL ', N'CƠ SỞ DỮ LIỆU', N'24548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'CTDL ', N'CẤU TRÚC DỮ LIỆU', N'25548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[MONHOC] ([MAMH], [TENMH], [rowguid]) VALUES (N'MMTCB', N'MẠNG MÁY TÍNH CĂN BẢN', N'26548b13-02e5-ee11-b765-d055e6165ab4')
GO
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'001     ', N'LÊ VĂN ', N'THÀNH', CAST(N'1985-03-06' AS Date), N'23/5 PHUNG KHAC KHOAN F3 Q3', N'TH04           ', N'001', N'35548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'002     ', N'DAO TRONG', N'KHAI', CAST(N'1979-08-19' AS Date), N'15/72 LE VAN THO F8 GOVAP', N'TH04           ', N'002', N'36548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'003     ', N'CAO TUAN', N'KHA', CAST(N'1985-12-06' AS Date), N'12/5 LE QUANG DINH F5 GO VAP', N'TH04           ', N'003', N'37548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'004     ', N'HA THANH ', N'BINH', CAST(N'1984-03-24' AS Date), N'23/4 HOANG HOA THAM', N'TH04           ', N'004', N'38548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'005     ', N'NGUYEN THÚY ', N'VÂN', CAST(N'1987-11-06' AS Date), N'7 HUYNH THUC KHANG', N'TH05           ', N'005', N'39548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'006     ', N'NGUYEN NGOC ', N'YEN', CAST(N'1980-11-23' AS Date), N'3/5 AN DUONG VUONG', N'TH05           ', N'006', N'3a548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'007     ', N'NGUYEN THUY ', N'DUNG', CAST(N'1988-05-23' AS Date), N'8 HUYNH VAN BANH f1 q binh thanh', N'TH05           ', N'007', N'3b548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'008     ', N'TRINH', N'PHONG', CAST(N'1985-12-10' AS Date), N'', N'TH06           ', N'008', N'3c548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'009     ', N'TRAN THANH', N'HUNG', CAST(N'1985-03-28' AS Date), N'', N'TH05           ', N'009', N'3d548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'011     ', N'PHAN HONG', N'NGOC', CAST(N'1986-01-17' AS Date), N'PHAN VAN HAN BINH THANH', N'TH04           ', N'011', N'3e548b13-02e5-ee11-b765-d055e6165ab4')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'142     ', N'Nguyễn Phi', N'Long', CAST(N'2003-09-09' AS Date), N'aaa', N'VT04           ', N'142', N'4b0a165b-df38-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'167     ', N'Phạm Bùi Nam', N'Phương', CAST(N'2003-09-25' AS Date), N'No DC', N'D21DQCN02      ', N'N21CN167', N'e2ff5180-ef37-ef11-b7c9-ec2e98e3b030')
INSERT [dbo].[SINHVIEN] ([MASV], [HO], [TEN], [NGAYSINH], [DIACHI], [MALOP], [MATKHAU], [rowguid]) VALUES (N'999     ', N'H', N'T', CAST(N'2002-09-25' AS Date), N'ss', N'D18CQCN01      ', N'999', N'a63ef29a-0539-ef11-b7c9-ec2e98e3b030')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_BANGDIEM]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_BANGDIEM] ON [dbo].[BANGDIEM]
(
	[MABANGDIEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_901578250]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_901578250] ON [dbo].[BANGDIEM]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_933578364]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_933578364] ON [dbo].[BODE]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_965578478]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_965578478] ON [dbo].[COSO]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1525580473]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1525580473] ON [dbo].[CTBAITHI]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_997578592]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_997578592] ON [dbo].[GIAOVIEN]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_GIAOVIEN_DANGKY_NGAYTHI]    Script Date: 04/08/2024 00:37:34 ******/
CREATE NONCLUSTERED INDEX [IX_GIAOVIEN_DANGKY_NGAYTHI] ON [dbo].[GIAOVIEN_DANGKY]
(
	[NGAYTHI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1029578706]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1029578706] ON [dbo].[GIAOVIEN_DANGKY]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1061578820]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1061578820] ON [dbo].[KHOA]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UN_TENLOP]    Script Date: 04/08/2024 00:37:34 ******/
ALTER TABLE [dbo].[LOP] ADD  CONSTRAINT [UN_TENLOP] UNIQUE NONCLUSTERED 
(
	[TENLOP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1093578934]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1093578934] ON [dbo].[LOP]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UN_TENMH]    Script Date: 04/08/2024 00:37:34 ******/
ALTER TABLE [dbo].[MONHOC] ADD  CONSTRAINT [UN_TENMH] UNIQUE NONCLUSTERED 
(
	[TENMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_MONHOC]    Script Date: 04/08/2024 00:37:34 ******/
CREATE NONCLUSTERED INDEX [IX_MONHOC] ON [dbo].[MONHOC]
(
	[MAMH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1125579048]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1125579048] ON [dbo].[MONHOC]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [MSmerge_index_1605580758]    Script Date: 04/08/2024 00:37:34 ******/
CREATE UNIQUE NONCLUSTERED INDEX [MSmerge_index_1605580758] ON [dbo].[SINHVIEN]
(
	[rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BANGDIEM] ADD  CONSTRAINT [MSmerge_df_rowguid_AAAB5273D9014F96AC938FAAD27A0F09]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[BODE] ADD  CONSTRAINT [MSmerge_df_rowguid_D0D5FBF986C144FE800BB7C71BB6635E]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[COSO] ADD  CONSTRAINT [MSmerge_df_rowguid_604DDCFAA9744BF488405B89A1B42156]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[CTBAITHI] ADD  CONSTRAINT [MSmerge_df_rowguid_53FB772C583C4AF49CB94ACDDBE9D456]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[GIAOVIEN] ADD  CONSTRAINT [MSmerge_df_rowguid_0386172219A341E2B76F560DEFE7F3A9]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] ADD  CONSTRAINT [MSmerge_df_rowguid_ED574F4FD84B406786F9B7E25229455F]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[KHOA] ADD  CONSTRAINT [MSmerge_df_rowguid_281687BBF7144E42B2F0ED4431A7262F]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[LOP] ADD  CONSTRAINT [MSmerge_df_rowguid_62F9AB5701A0405DA0EBBBF70025CFB3]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[MONHOC] ADD  CONSTRAINT [MSmerge_df_rowguid_333BC8470241461586EBFD0F46928B66]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[SINHVIEN] ADD  CONSTRAINT [MSmerge_df_rowguid_E098BA098483448188F0F3E9BEFD3E8F]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_MONHOC]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [FK_BANGDIEM_SINHVIEN1] FOREIGN KEY([MASV])
REFERENCES [dbo].[SINHVIEN] ([MASV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [FK_BANGDIEM_SINHVIEN1]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [FK_BODE_GIAOVIEN] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [FK_BODE_GIAOVIEN]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [FK_BODE_MONHOC] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [FK_BODE_MONHOC]
GO
ALTER TABLE [dbo].[CTBAITHI]  WITH CHECK ADD  CONSTRAINT [FK_CTBAITHI_BANGDIEM] FOREIGN KEY([MABANGDIEM])
REFERENCES [dbo].[BANGDIEM] ([MABANGDIEM])
GO
ALTER TABLE [dbo].[CTBAITHI] CHECK CONSTRAINT [FK_CTBAITHI_BANGDIEM]
GO
ALTER TABLE [dbo].[CTBAITHI]  WITH CHECK ADD  CONSTRAINT [FK_CTBAITHI_BODE] FOREIGN KEY([CAUHOI])
REFERENCES [dbo].[BODE] ([CAUHOI])
GO
ALTER TABLE [dbo].[CTBAITHI] CHECK CONSTRAINT [FK_CTBAITHI_BODE]
GO
ALTER TABLE [dbo].[GIAOVIEN]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN] CHECK CONSTRAINT [FK_GIAOVIEN_KHOA]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1] FOREIGN KEY([MAGV])
REFERENCES [dbo].[GIAOVIEN] ([MAGV])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_GIAOVIEN1]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_LOP]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1] FOREIGN KEY([MAMH])
REFERENCES [dbo].[MONHOC] ([MAMH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [FK_GIAOVIEN_DANGKY_MONHOC1]
GO
ALTER TABLE [dbo].[KHOA]  WITH CHECK ADD  CONSTRAINT [FK_KHOA_COSO] FOREIGN KEY([MACS])
REFERENCES [dbo].[COSO] ([MACS])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[KHOA] CHECK CONSTRAINT [FK_KHOA_COSO]
GO
ALTER TABLE [dbo].[LOP]  WITH CHECK ADD  CONSTRAINT [FK_LOP_KHOA] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHOA] ([MAKH])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[LOP] CHECK CONSTRAINT [FK_LOP_KHOA]
GO
ALTER TABLE [dbo].[SINHVIEN]  WITH CHECK ADD  CONSTRAINT [FK_SINHVIEN_LOP] FOREIGN KEY([MALOP])
REFERENCES [dbo].[LOP] ([MALOP])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SINHVIEN] CHECK CONSTRAINT [FK_SINHVIEN_LOP]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_DIEM] CHECK  (([DIEM]>=(0) AND [DIEM]<=(10)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_DIEM]
GO
ALTER TABLE [dbo].[BANGDIEM]  WITH NOCHECK ADD  CONSTRAINT [CK_LANTHI] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[BANGDIEM] CHECK CONSTRAINT [CK_LANTHI]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_BODE] CHECK  (([TRINHDO]='A' OR [TRINHDO]='B' OR [TRINHDO]='C'))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_BODE]
GO
ALTER TABLE [dbo].[BODE]  WITH NOCHECK ADD  CONSTRAINT [CK_DAPAN] CHECK  (([DAP_AN]='D' OR ([DAP_AN]='C' OR ([DAP_AN]='B' OR [DAP_AN]='A'))))
GO
ALTER TABLE [dbo].[BODE] CHECK CONSTRAINT [CK_DAPAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_LAN] CHECK  (([LAN]>=(1) AND [LAN]<=(2)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_LAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_SOCAUTHI] CHECK  (([SOCAUTHI]>=(10) AND [SOCAUTHI]<=(100)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_SOCAUTHI]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_THOIGIAN] CHECK  (([THOIGIAN]>=(2) AND [THOIGIAN]<=(60)))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_THOIGIAN]
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY]  WITH CHECK ADD  CONSTRAINT [CK_TRINHDO] CHECK  (([TRINHDO]='C' OR ([TRINHDO]='B' OR [TRINHDO]='A')))
GO
ALTER TABLE [dbo].[GIAOVIEN_DANGKY] CHECK CONSTRAINT [CK_TRINHDO]
GO
/****** Object:  StoredProcedure [dbo].[GetExamDetails]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetExamDetails]
    @MASV CHAR(10),
    @MAMH CHAR(10),
    @LAN INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Bảng 1: Thông tin sinh viên, môn học, lớp, ngày thi và lần thi
    SELECT 
        CONCAT(s.HO, ' ', s.TEN) AS HO_TEN,
        m.TENMH,
        m.MAMH,
        l.TENLOP,
        bd.NGAYTHI,
        bd.LAN
    FROM 
        BANGDIEM bd
    JOIN 
        SINHVIEN s ON bd.MASV = s.MASV
    JOIN 
        MONHOC m ON bd.MAMH = m.MAMH
    JOIN 
        LOP l ON s.MALOP = l.MALOP
    WHERE 
        bd.MASV = @MASV 
        AND bd.MAMH = @MAMH 
        AND bd.LAN = @LAN;

    -- Bảng 2: Danh sách câu hỏi và đáp án sinh viên
    SELECT 
        b.CAUHOI,
        b.NOIDUNG,
        b.A,
        b.B,
        b.C,
        b.D,
        b.DAP_AN as 'DAPAN',
        c.DAPANSV
    FROM 
        BODE b
    JOIN 
        CTBAITHI c ON b.CAUHOI = c.CAUHOI
    WHERE 
        c.MABANGDIEM = (
            SELECT MABANGDIEM 
            FROM BANGDIEM 
            WHERE MASV = @MASV AND MAMH = @MAMH AND LAN = @LAN
        );
END;
GO
/****** Object:  StoredProcedure [dbo].[LayDanhSachThiTracNghiem]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[LayDanhSachThiTracNghiem]
	@tungay DATE,
	@denngay DATE
AS
	WITH RegistrationDetails AS (
		SELECT
			ROW_NUMBER() OVER (ORDER BY GD.NGAYTHI) AS 'STT', 
			LOP.TENLOP AS 'TÊN LỚP',
			MONHOC.TENMH AS 'TÊN MÔN HỌC',
			GV.HO + ' ' + GV.TEN AS 'GIẢNG VIÊN ĐĂNG KÝ',
			GD.SOCAUTHI AS 'SỐ CÂU THI',
			GD.NGAYTHI AS 'NGÀY THI',
			CASE WHEN BD.MASV IS NOT NULL THEN 'X' ELSE '' END AS 'ĐÃ THI (X)',
			'' AS 'GHI CHÚ'
		FROM
			GIAOVIEN_DANGKY GD
		INNER JOIN MONHOC ON GD.MAMH = MONHOC.MAMH
		INNER JOIN LOP ON GD.MALOP = LOP.MALOP
		INNER JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
		LEFT JOIN (
			SELECT DISTINCT MASV, MAMH, LAN
			FROM BANGDIEM
		) BD ON GD.MAMH = BD.MAMH AND GD.LAN = BD.LAN
		WHERE
			GD.NGAYTHI BETWEEN @tungay AND @denngay
	)

	SELECT
		'CS1' AS 'CƠ SỞ',
		*
	FROM
		RegistrationDetails
	WHERE
		RegistrationDetails.STT IN (
			SELECT STT
			FROM RegistrationDetails
			GROUP BY STT
		)

	UNION ALL

	SELECT
		'CS2' AS 'CƠ SỞ',
		*
	FROM
		RegistrationDetails
	WHERE
		RegistrationDetails.STT NOT IN (
			SELECT STT
			FROM RegistrationDetails
			GROUP BY STT
		)

	ORDER BY
		RegistrationDetails.[NGÀY THI];
GO
/****** Object:  StoredProcedure [dbo].[LOGINGV]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[LOGINGV]
@TENLOGIN NVARCHAR (50)
AS
DECLARE @TENUSER NVARCHAR(50)
SELECT @TENUSER=NAME FROM sys.sysusers WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT USERNAME = @TENLOGIN, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM dbo.GIAOVIEN  WHERE MAGV = @TENUSER ),
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT MIN(GROUPUID) FROM SYS.SYSMEMBERS WHERE MEMBERUID = (SELECT UID FROM sys.sysusers WHERE NAME = @TENUSER))

GO
/****** Object:  StoredProcedure [dbo].[SP_CapNhatBaiThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   proc [dbo].[SP_CapNhatBaiThi]
(@masv char(8),
@mamh char(5),
@lanthi smallint,
@cauhoi int,
@traloi char(1))
AS
BEGIN
	UPDATE CTBAITHI
	SET DAPANSV = CASE 
                    WHEN @traloi = '' THEN NULL 
                    ELSE @traloi 
                END
	WHERE 
		MABANGDIEM = 
			(SELECT MABANGDIEM FROM BANGDIEM WHERE MASV = @masv and MAMH = @mamh and LAN = @lanthi) 
		and CAUHOI = @cauhoi
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_ChamDiemBaiThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_ChamDiemBaiThi]
@masv char(8), @mamh char(5), @lan smallint
AS
BEGIN TRY
    DECLARE @maBangDiem nchar(10), @soluong int, @soCauDung float, @diemSV float

    SELECT @maBangDiem = MABANGDIEM, @diemSV = DIEM FROM BANGDIEM WHERE MASV = @masv AND MAMH = @mamh AND LAN = @lan

    IF (@maBangDiem IS NULL)
        BEGIN
            RAISERROR(N'Thí sinh này chưa thi!',16,1)
        END

    IF (@diemSV IS NOT NULL)
        BEGIN
            RAISERROR(N'Bài thi của sinh viên này đã được chấm',16,1)
        END

    SELECT CAUHOI, DAPANSV INTO #BAITHI FROM CTBAITHI WHERE MABANGDIEM = @maBangDiem
    SELECT @soluong = COUNT(CAUHOI) FROM #BAITHI

    SELECT @soCauDung= (@soluong*2- COUNT(CAUHOI)) FROM
        (SELECT CAUHOI, DAPANSV FROM #BAITHI
        UNION 
        SELECT CAUHOI, DAP_AN FROM BODE WHERE CAUHOI IN (SELECT CAUHOI FROM #BAITHI)) DAPANDUNG

    SET @diemSV = ROUND((@soCauDung / @soluong) * 10,2)
    UPDATE BANGDIEM
        SET DIEM = @diemSV WHERE MABANGDIEM = @maBangDiem and MAMH = @mamh and MASV = @masv and LAN = @lan
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(2000) = N'Lỗi: ' + ERROR_MESSAGE()
    SELECT @ErrorMessage 
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_ChuyenKhoa]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_ChuyenKhoa](@MAKH nchar(8),
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
/****** Object:  StoredProcedure [dbo].[SP_ChuyenLop]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[SP_ChuyenLop]
    (@MALOP nchar(15),
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
/****** Object:  StoredProcedure [dbo].[SP_DangKyThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DangKyThi]
 @magv char(8),@malop char(5),
        @mamh nchar(15) ,@trinhdo char(1),@ngaythi datetime,@socauthi smallint,@thoigian smallint,@lan smallint = 1
AS
BEGIN TRY
    DECLARE @returnvalue int

    EXEC @returnvalue = SP_KiemTraDangKyThi @mamh, @malop, @lan
    EXEC @returnvalue = SP_KiemTraSoLuongCau @mamh, @trinhdo, @socauthi
    
    INSERT INTO GIAOVIEN_DANGKY (MAGV, MAMH, MALOP, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN)
    VALUES (@magv,@mamh, @malop, @trinhdo, @ngaythi, @lan, @socauthi, @thoigian)
    
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(2000)
    SELECT @ErrorMessage = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@ErrorMessage, 16, 1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_DangNhapGiangVien]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DangNhapGiangVien]
@TENLOGIN NVARCHAR (50)
AS
DECLARE @TENUSER NVARCHAR(50), @UID INT
SELECT @UID= UID, @TENUSER=NAME FROM sys.sysusers 
     WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT MANV = @TENUSER, 
  HOTEN = (SELECT HO+ ' '+ TEN FROM dbo.GIAOVIEN  WHERE MAGV = @TENUSER ),
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= @UID)
GO
/****** Object:  StoredProcedure [dbo].[SP_DangNhapSinhVien]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DangNhapSinhVien]
@maSV nchar(8),
@pass nvarchar(30)
AS
SELECT USERNAME = 'SV',
	HOTEN = HO+ ' '+ TEN,
	TENNHOM = 'SV'
FROM dbo.SINHVIEN
WHERE 
	MASV = @maSV and 
	MATKHAU = @pass
GO
/****** Object:  StoredProcedure [dbo].[SP_DanhSachCacMonDaThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_DanhSachCacMonDaThi]
@masv char(8)
AS
BEGIN
    DECLARE @malop nchar(15)
    SELECT @malop = MALOP FROM SINHVIEN WHERE MASV = @masv
    SELECT MAMH, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN FROM GIAOVIEN_DANGKY 
	WHERE MALOP = @malop and 
		EXISTS(SELECT 1 
		FROM BANGDIEM 
		WHERE MASV = @masv and 
			MAMH = GIAOVIEN_DANGKY.MAMH and 
			LAN = GIAOVIEN_DANGKY.LAN and 
			DIEM is not NULL)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DanhSachCacMonThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DanhSachCacMonThi]
@masv char(8)
AS
BEGIN
    DECLARE @malop nchar(15)
    SELECT @malop = MALOP FROM SINHVIEN WHERE MASV = @masv
    SELECT MAMH, TRINHDO, NGAYTHI, LAN, SOCAUTHI, THOIGIAN FROM GIAOVIEN_DANGKY WHERE MALOP = @malop AND NGAYTHI > GETDATE() - 1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DanhSachDangKyThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DanhSachDangKyThi] @fromDate datetime,
@toDate datetime
AS
BEGIN TRY
    SET NOCOUNT ON
    IF (1=0) SET FMTONLY OFF
    IF (@fromDate > @toDate)
        RAISERROR (N'Ngày không hợp lệ',16,1)
    DECLARE @COSO NCHAR(3)
    SET @COSO = (SELECT MACS FROM COSO)
    SELECT LOP.TENLOP, MH.TENMH, (LTRIM(RTRIM(GV.HO))+ ' ' +LTRIM(GV.TEN)) AS GVDK, 
    DK.SOCAUTHI, DK.NGAYTHI, dbo.KiemTraDotThi(MH.MAMH, LOP.MALOP, DK.LAN) AS DATHI, @COSO AS MACS
        FROM (SELECT MAGV, HO, TEN FROM GIAOVIEN WHERE MAGV IN (SELECT MAGV FROM GIAOVIEN)) GV 
        INNER JOIN (SELECT MALOP, MAMH, MAGV, SOCAUTHI, NGAYTHI, LAN FROM GIAOVIEN_DANGKY 
            WITH(INDEX = IX_GIAOVIEN_DANGKY_NGAYTHI)
            WHERE NGAYTHI BETWEEN @fromDate AND @toDate) DK
        ON DK.MAGV = GV.MAGV
        INNER JOIN (SELECT MAMH, TENMH FROM MONHOC WHERE MAMH IN (SELECT MAMH FROM MONHOC)) MH
        ON MH.MAMH = DK.MAMH
        INNER JOIN (SELECT MALOP, TENLOP FROM LOP WHERE MALOP IN (SELECT MALOP FROM GIAOVIEN_DANGKY)) LOP
        ON LOP.MALOP = DK.MALOP
        
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(2000)
    SELECT @ErrorMessage = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@ErrorMessage, 16, 1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_DanhSachDangKyThiJob]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DanhSachDangKyThiJob] @fromDate datetime,
@toDate datetime
AS
BEGIN
    SET NOCOUNT ON
    IF (1=0) SET FMTONLY OFF
    IF (@fromDate > @toDate)
        RAISERROR (N'Ngày không hợp lệ',16,1)
-- Tạo bảng tạm toàn cục
    IF OBJECT_ID('tempdb..##JobResult') IS NOT NULL
        DROP TABLE ##JobResult;
    CREATE TABLE ##JobResult (
        TENLOP NVARCHAR(50),
        TENMH NVARCHAR(50),
        GVDK NVARCHAR(50),
        SOCAUTHI SMALLINT,
		NGAYTHI DATETIME,
		DATHI NCHAR(1),
		MACS NCHAR(3)
    );

    DECLARE @STR1 NVARCHAR(4000);
    SET @STR1 = 'INSERT INTO ##JobResult EXEC SP_DanhSachDangKyThi ' + '''' + CONVERT(NVARCHAR(10), @fromDate, 120) + ''',''' + CONVERT(NVARCHAR(10), @toDate, 120)+'''';
    PRINT(@STR1)

	DECLARE @login_name nvarchar(20) = SUSER_SNAME()

    -- Xóa job nếu đã tồn tại
    IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Job_1')
        EXEC msdb.dbo.sp_delete_job @job_name = N'Job_1'


    -- Tạo job mới
    EXEC msdb.dbo.sp_add_job @job_name = N'Job_1', @start_step_id = 1;
    EXEC msdb.dbo.sp_add_jobserver @job_name = N'Job_1', @server_name = @@SERVERNAME;
    EXEC msdb.dbo.sp_add_jobstep @job_name = N'Job_1', @step_id = 1, @step_name = 'takedataformlocal', @command = @STR1, @server = @@SERVERNAME, @database_name = 'TN_CSDLPT'

    -- Khởi động job
    EXEC msdb.dbo.sp_start_job @job_name = N'Job_1'
	-----------------lấy dữ liệu từ chi nhánh 2
	-- Tạo bảng tạm cục bộ
    CREATE TABLE #TempTable (
        TENLOP NVARCHAR(50),
        TENMH NVARCHAR(50),
        GVDK NVARCHAR(50),
        SOCAUTHI SMALLINT,
		NGAYTHI DATETIME,
		DATHI NCHAR(1),
		MACS NCHAR(3)
    );
	
    -- Chèn dữ liệu vào bảng tạm cục bộ
    INSERT INTO #TempTable
    EXEC LINK1.TN_CSDLPT.dbo.SP_DanhSachDangKyThi  @fromDate, @toDate;
	
	-- Chờ job hoàn thành
    WHILE EXISTS (
        SELECT * 
        FROM msdb.dbo.sysjobactivity 
        WHERE job_id = (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = 'Job_1')
          AND run_requested_date IS NOT NULL 
          AND stop_execution_date IS NULL
    )
    BEGIN
        WAITFOR DELAY '00:00:00';
    END

    -- Lấy trạng thái của lần chạy job gần nhất
    DECLARE @job_status INT;
    SELECT TOP 1 @job_status = run_status
    FROM msdb.dbo.sysjobhistory
    WHERE job_id = (SELECT job_id FROM msdb.dbo.sysjobs WHERE name = N'Job_1')
    ORDER BY run_date DESC, run_time DESC;

    IF @job_status = 1  -- Job đã hoàn thành thành công
    BEGIN

	CREATE TABLE #FINAL (
        TENLOP NVARCHAR(50),
        TENMH NVARCHAR(50),
        GVDK NVARCHAR(50),
        SOCAUTHI SMALLINT,
		NGAYTHI DATETIME,
		DATHI NCHAR(1),
		MACS NCHAR(3)
    );
	INSERT INTO #FINAL (TENLOP, TENMH, GVDK, SOCAUTHI, NGAYTHI, DATHI, MACS)
	SELECT TENLOP, TENMH, GVDK, SOCAUTHI, NGAYTHI, DATHI, MACS FROM ##JobResult
	UNION ALL
	SELECT TENLOP, TENMH, GVDK, SOCAUTHI, NGAYTHI, DATHI, MACS FROM #TempTable

	DROP TABLE #TempTable
	SELECT * FROM #FINAL

    -- Xóa job nếu đã tồn tại
    IF EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N'Job_1')
        EXEC msdb.dbo.sp_delete_job @job_name = N'Job_1'

    END
    ELSE
    BEGIN
        RAISERROR ('Job failed.', 16, 1);
    END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DanhSachLop]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_DanhSachLop]
AS
BEGIN
    SELECT MALOP, TENLOP, (SELECT TENKH FROM KHOA WHERE (LOP.MAKH = MAKH)) AS MAKH
    FROM LOP
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DanhSachMonCoDiem]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DanhSachMonCoDiem]
@masv char(8)
AS
BEGIN
    SELECT MAMH, DIEM, LAN, NGAYTHI FROM BANGDIEM WHERE BANGDIEM.MASV = @masv AND DIEM IS NOT NULL
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DanhSachSinhVien]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_DanhSachSinhVien]
AS
BEGIN
    SELECT MASV, HO, TEN, NGAYSINH, DIACHI, MALOP=(SELECT TENLOP FROM LOP WHERE SINHVIEN.MALOP = LOP.MALOP), MATKHAU
    FROM SINHVIEN
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_DeThi]
@masv char(8), @mamh char(5), @lan smallint
AS
BEGIN
    DECLARE @maBangDiem nchar(10)
    SELECT @maBangDiem = MABANGDIEM FROM BANGDIEM WHERE MASV = @masv AND MAMH = @mamh AND LAN = @lan
    
    SELECT NOIDUNG, BAITHI.CAUHOI, A, B, C, D
        FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM=@maBangDiem) BAITHI, 
                (SELECT * FROM BODE WHERE BODE.MAMH = @mamh) NOIDUNG
        WHERE NOIDUNG.CAUHOI = BAITHI.CAUHOI
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GiaoVienChuaTaoTK]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SP_GiaoVienChuaTaoTK]
AS
BEGIN
    SELECT name as MAGV,
           type_desc as type
           INTO  ##Users
    FROM sys.database_principals
    WHERE type not in ('A', 'G', 'R', 'X')
          and sid is not null
          and name != 'guest'
    ORDER BY MAGV;

    SELECT GIAOVIEN.MAGV , HO +' '+TEN AS TEN
        FROM dbo.GIAOVIEN LEFT JOIN ##Users 
            ON GIAOVIEN.MAGV =##Users.MAGV
        where ##Users.MAGV IS NULL; 
        --GROUP BY dbo.GIAOVIEN.MAGV

    DROP TABLE ##Users
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InBangDiem]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROC [dbo].[SP_InBangDiem]
@MALOP NVARCHAR (15),
@MAMONHOC char(5),
@LANTHI smallint
AS
BEGIN
SELECT SV.MASV, HOTEN=HO + ' ' + TEN, ISNULL(DIEM,0) AS DIEM, dbo.ConvertDiemChu(DIEM) AS DIEMCHU 
FROM (SELECT MASV, HO, TEN FROM SINHVIEN  WHERE MALOP = @MALOP) SV 
LEFT JOIN
(SELECT MASV, DIEM FROM BANGDIEM WHERE MAMH =@MAMONHOC AND LAN=@LANTHI) DIEM
ON SV.MASV = DIEM.MASV
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraBoDeTonTai]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_KiemTraBoDeTonTai]
@CAUHOI INT
AS
BEGIN  TRY
    IF EXISTS(SELECT CAUHOI FROM BODE WHERE CAUHOI = @CAUHOI)
        RAISERROR(N'Mã câu hỏi này đã tồn tại', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@message,16,1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraDangKyThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_KiemTraDangKyThi]
@MAMH CHAR(5), @MALOP NCHAR(15), @LAN SMALLINT, @SOCAU int, @TRINHDO char(1), @NGAYTHI Datetime
AS
BEGIN TRY
	IF (CONVERT (date, @NGAYTHI) < CONVERT(date, GETDATE())) 
		RAISERROR(N'Ngày đăng ký thi phải lớn hơn hoặc bằng ngày hôm nay!', 16, 1)
    IF EXISTS(SELECT 1 FROM GIAOVIEN_DANGKY WHERE MAMH = @MAMH AND MALOP = @MALOP AND LAN = @LAN)
        RAISERROR(N'Lớp này đã được đăng kí thi môn này lần này', 16, 1)
	EXEC SP_KiemTraSoLuongCau @MAMH, @TRINHDO, @SOCAU
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = ERROR_MESSAGE()
    RAISERROR(@message,16,1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraGiaoVienTonTai]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROC [dbo].[SP_KiemTraGiaoVienTonTai]
@MAGV NCHAR(15)
AS
BEGIN TRY
    IF EXISTS(SELECT MAGV FROM GIAOVIEN WHERE MAGV = @MAGV)
        RAISERROR(N'Mã giáo viên này đã tồn tại', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@message,16,1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraKhoaTonTai]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_KiemTraKhoaTonTai]
@MAKH NCHAR(8), @TENKH NVARCHAR(50)
AS
BEGIN TRY
    IF EXISTS(SELECT MAKH FROM LINK2.TN_CSDLPT.DBO.KHOA WHERE MAKH = @MAKH) AND EXISTS(SELECT TENKH FROM LINK2.TN_CSDLPT.DBO.KHOA WHERE TENKH = @TENKH)
        RAISERROR(N'Mã và tên khoa này đã tồn tại', 16, 1)    
    IF EXISTS(SELECT TENKH FROM LINK2.TN_CSDLPT.DBO.KHOA WHERE TENKH = @TENKH)
        RAISERROR(N'Tên khoa này đã tồn tại', 16, 1)
    ELSE IF EXISTS(SELECT MAKH FROM LINK2.TN_CSDLPT.DBO.KHOA WHERE MAKH = @MAKH)
        RAISERROR(N'Mã khoa này đã tồn tại', 16, 1) 
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@message,16,1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraLopTonTai]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROC [dbo].[SP_KiemTraLopTonTai]
@MALOP NCHAR(15), @TENLOP NVARCHAR(50)
AS
BEGIN TRY
    IF EXISTS(SELECT MALOP FROM LINK2.TN_CSDLPT.DBO.LOP WHERE MALOP = @MALOP) AND EXISTS(SELECT TENLOP FROM LINK2.TN_CSDLPT.DBO.LOP WHERE TENLOP = @TENLOP)
        RAISERROR(N'Mã và tên lớp này đã tồn tại', 16, 1) 
    IF EXISTS(SELECT MALOP FROM LINK2.TN_CSDLPT.DBO.LOP WHERE MALOP = @MALOP)
        RAISERROR(N'Mã lớp này đã tồn tại', 16, 1) 
    ELSE IF EXISTS(SELECT TENLOP FROM LINK2.TN_CSDLPT.DBO.LOP WHERE TENLOP = @TENLOP)
        RAISERROR(N'Tên lớp này đã tồn tại', 16, 1)
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@message,16,1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraMonHocTonTai]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_KiemTraMonHocTonTai]
@MAMH NCHAR(5), @TENMH NVARCHAR(50)
AS
BEGIN TRY
    IF EXISTS(SELECT MAMH FROM MONHOC WHERE MAMH = @MAMH) AND EXISTS(SELECT TENMH FROM MONHOC WHERE TENMH = @TENMH)
        RAISERROR(N'Mã và tên môn này đã tồn tại', 16, 1) 
    IF EXISTS(SELECT MAMH FROM MONHOC WHERE MAMH = @MAMH)
        RAISERROR(N'Mã môn này đã tồn tại', 16, 1) 
    ELSE IF EXISTS(SELECT TENMH FROM MONHOC WHERE TENMH = @TENMH)
        RAISERROR(N'Tên môn này đã tồn tại', 16, 1) 
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@message,16,1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraSinhVienTonTai]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROC [dbo].[SP_KiemTraSinhVienTonTai]
@MASV NCHAR(15)
AS
BEGIN TRY
    IF EXISTS(SELECT MASV FROM LINK2.TN_CSDLPT.DBO.SINHVIEN WHERE MASV = @MASV)
        RAISERROR(N'Mã sinh viên này đã tồn tại',16,1)
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@message,16,1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraSoLuongCau]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_KiemTraSoLuongCau]
@mamh char(5), @trinhdo char(1),@socauthi int
AS

BEGIN TRY
    DECLARE    @soluong int, @soluongduoi int, @trinhdoduoi char(1)
    DECLARE @thieu int = 0
    SELECT @soluong = COUNT(CAUHOI) FROM BODE WHERE MAMH = @mamh AND TRINHDO = @trinhdo

    IF (@trinhdo = 'A')
        SET @trinhdoduoi = 'B'
    ELSE IF (@trinhdo = 'B')
        SET @trinhdoduoi = 'C'

    IF (@soluong >= @socauthi*0.7)
        BEGIN
            SELECT @soluongduoi = COUNT(CAUHOI) FROM BODE WHERE MAMH =@mamh AND TRINHDO = @trinhdoduoi
            IF ((@soluongduoi + @soluong) < @socauthi)
                BEGIN
                    SET @thieu = @socauthi - (@soluongduoi + @soluong)
                    RAISERROR (N'Không đủ số lượng câu. Số lượng thiếu: %s', 16 ,1, @thieu)
                END
        END
    ELSE
        BEGIN
            SET @thieu = ROUND(convert(float,@socauthi)*0.7 - @soluong, 1)
            IF ((@soluong + @thieu) < 0.7*@socauthi)
                SET @thieu += 1
            RAISERROR(N'Không đủ số lượng câu cùng bậc. Số lượng thiếu: %d',16,1, @thieu)
        END
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = N'Lỗi: ' + ERROR_MESSAGE()
    RAISERROR(@message,16,1)
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraSoLuongCauCungBac]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROC [dbo].[SP_KiemTraSoLuongCauCungBac]
@mamh char(5), @trinhdo char(1),@socauthi int
AS
DECLARE @thieu int = 0
BEGIN TRY
    DECLARE    @soluong int
    SELECT @soluong = COUNT(CAUHOI) FROM BODE WHERE MAMH = @mamh AND TRINHDO = @trinhdo
    BEGIN
        SET @thieu = ROUND(convert(float,@socauthi)*0.7 - @soluong, 1)
        IF ((@soluong + @thieu) < 0.7*@socauthi)
            SET @thieu += 1
            RAISERROR(N'Không đủ số lượng câu cùng bậc. Số lượng thiếu: %d',16,1, @thieu)
    END
    SELECT @thieu
END TRY
BEGIN CATCH
    DECLARE @message nvarchar(200) = N'Lỗi:' + ERROR_MESSAGE()
    SELECT @message
    return @thieu
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraTrangThaiThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KiemTraTrangThaiThi] @MASV NVARCHAR(50),
    @MAMH NVARCHAR(50),
    @LAN INT,
    @Result NVARCHAR(50) OUTPUT
AS
BEGIN
    DECLARE @DIEM FLOAT, @NGAYTHI DATETIME

    -- Check if the row exists and get the DIEM and NGAYTHI value
    SELECT @DIEM = DIEM, @NGAYTHI = NGAYTHI
    FROM BANGDIEM
    WHERE MASV = @MASV AND MAMH = @MAMH AND LAN = @LAN;

    -- Determine the result based on the DIEM value
    IF @DIEM IS NULL
    BEGIN
        IF @NGAYTHI IS NOT NULL
        BEGIN
            DECLARE @tgt INT;
            SET @tgt = (SELECT THOIGIAN 
                        FROM GIAOVIEN_DANGKY 
                        WHERE MAMH = @MAMH AND LAN = @LAN
                          AND MALOP = (SELECT MALOP FROM SINHVIEN WHERE MASV = @MASV));

            DECLARE @hanThi DATETIME = DATEADD(MINUTE, @tgt, @NGAYTHI);

            IF @hanThi > CURRENT_TIMESTAMP
                SET @Result = 'DANGTHI';
            ELSE
                SET @Result = 'DATHI';
        END
        ELSE
        BEGIN
            SET @Result = 'CHUATHI';
        END
    END
    ELSE
    BEGIN
        SET @Result = 'DATHI';
    END
END;



GO
/****** Object:  StoredProcedure [dbo].[SP_KiemTraXoaGVDK]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_KiemTraXoaGVDK]
  @MAMH nchar(5),
  @MALOP nchar(8),
  @LAN smallint
AS
BEGIN
    
    SELECT BANGDIEM.MASV INTO ##TAMSV FROM dbo.SINHVIEN JOIN dbo.BANGDIEM ON BANGDIEM.MASV = SINHVIEN.MASV WHERE LAN = @LAN AND MAMH =@MAMH

    SELECT dbo.SINHVIEN.MALOP INTO ##TAMLOP FROM ##TAMSV JOIN dbo.SINHVIEN ON SINHVIEN.MASV = ##TAMSV.MASV GROUP BY MALOP

    IF exists(select * FROM ##TAMLOP WHERE MALOP = @MALOP)
        raiserror ('Thông tin của giảng viên đăng ký này đã tồn tại trong bảng điểm, Không thể xóa',16,1)

    DROP TABLE ##TAMSV;
    DROP TABLE ##tamLop;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_KTSinhVienTonTai]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SP_KTSinhVienTonTai] @masv char(8)
AS
IF exists(select MASV from LINK2.TN_CSDLPT.dbo.SINHVIEN where MASV =@masv)
		raiserror ('Mã Sinh Viên đã tồn tại, vui lòng nhập lại',16,1)
GO
/****** Object:  StoredProcedure [dbo].[SP_LayThoiGianThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create   PROC [dbo].[SP_LayThoiGianThi]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_LOGIN]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[SP_LOGIN]
@TENLOGIN NVARCHAR (50)
AS
DECLARE @TENUSER NVARCHAR(50), @UID INT
SELECT @UID= UID, @TENUSER=NAME FROM sys.sysusers 
     WHERE sid = SUSER_SID(@TENLOGIN)
 
 SELECT MANV = @TENUSER, 
   TENNHOM= NAME
   FROM sys.sysusers 
   WHERE UID = (SELECT GROUPUID 
                 FROM SYS.SYSMEMBERS 
                   WHERE MEMBERUID= @UID)
GO
/****** Object:  StoredProcedure [dbo].[SP_TAO_LOGIN]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TAO_LOGIN] @LGNAME VARCHAR(50),
  @PASS VARCHAR(50),
  @USERNAME VARCHAR(50),
  @ROLE VARCHAR(50)
AS
  DECLARE @RET INT
  EXEC @RET= SP_ADDLOGIN @LGNAME, @PASS,'TN_CSDLPT'
  IF (@RET =1)  -- LOGIN NAME BI TRUNG
  BEGIN
    RAISERROR('Login name đã tồn tại.', 16, 1)
    RETURN 1
  END
 
  EXEC @RET= SP_GRANTDBACCESS @LGNAME, @USERNAME
  IF (@RET =1)  -- USER  NAME BI TRUNG
  BEGIN
       EXEC SP_DROPLOGIN @LGNAME
       RAISERROR('User name đã tồn tại.', 16, 1)
       return 2
  END
  EXEC sp_addrolemember @ROLE, @USERNAME
  IF @ROLE= 'COSO' OR @ROLE= 'TRUONG'
  BEGIN 
    EXEC sp_addsrvrolemember @LGNAME, 'SecurityAdmin'
  END
  IF @ROLE = 'COSO'
  BEGIN
      EXEC ('USE msdb; CREATE USER [' + @USERNAME + '] FOR LOGIN [' + @LGNAME + ']')
      EXEC ('USE msdb; EXEC sp_addrolemember N''COSO'', ''' + @USERNAME + '''')
  END
  IF @ROLE = 'TRUONG'
  BEGIN
      EXEC ('USE msdb; CREATE USER [' + @USERNAME + '] FOR LOGIN [' + @LGNAME + ']')
      EXEC ('USE msdb; EXEC sp_addrolemember N''TRUONG'', ''' + @USERNAME + '''')
  END
  IF @ROLE = 'GIANGVIEN'
  BEGIN
      EXEC ('USE msdb; CREATE USER [' + @USERNAME + '] FOR LOGIN [' + @LGNAME + ']')
      EXEC ('USE msdb; EXEC sp_addrolemember N''GIANGVIEN'', ''' + @USERNAME + '''')
  END
return 0  -- THANH CONG
GO
/****** Object:  StoredProcedure [dbo].[SP_TaoBaiThi]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[SP_TaoBaiThi]
@masv char(8), @malop NCHAR(15), @maMH nchar(5), @lan smallint
AS
SET XACT_ABORT ON
BEGIN TRAN
BEGIN TRY
	DECLARE @ngayThi datetime, @soCauThi int, @trinhDo nchar(1), @soluong int, @soluongCSkhac int, @trinhDoDuoi nchar(1), @soLuongMoi int

	--Uu tien lay de cua giao vien o co so  ma lop do dang hoc
	--khong phai la lay de theo giao vien day lop do!!!
	SELECT  @ngayThi = NGAYTHI, @soCauThi = SOCAUTHI, @trinhDo = TRINHDO FROM GIAOVIEN_DANGKY WHERE MAMH = @maMH AND MALOP = @maLop AND LAN = @lan	

	EXEC SP_KiemTraSoLuongCau @maMH, @trinhDo, @soCauThi

	IF (@trinhDo = 'A')
		SET @trinhDoDuoi = 'B'
	ELSE IF (@trinhDo = 'B')
		SET @trinhDoDuoi = 'C'

	--Tu dong tao bang diem khi thi, diem = null
	DECLARE @maBangDiem nchar(10) = TRIM(@masv) + TRIM(@maMH) + STR(@lan,1,0), @giothi datetime = DATEADD(MINUTE, 1, CURRENT_TIMESTAMP)
	IF EXISTS (select 1 from BANGDIEM where BANGDIEM.MABANGDIEM=@maBangDiem)
		BEGIN
			RAISERROR('Bang diem nay da ton tai',16,1)
			ROLLBACK
		END
	INSERT INTO BANGDIEM(MASV, MAMH, LAN, NGAYTHI, DIEM, MABANGDIEM)
	VALUES (@masv, @maMH, @lan, @giothi, NULL, @maBangDiem)

	IF (@trinhDo = 'C')
		BEGIN
			SELECT @soluong = COUNT(CAUHOI) FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
			IF (@soluong > @soCauThi)
				BEGIN				
					--Tao bai thi (duoc luu trong CTBAITHI)
					INSERT INTO CTBAITHI (CAUHOI, MABANGDIEM)
					SELECT TOP (@soCauThi) CAUHOI, @maBangDiem FROM BODE
					WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
					ORDER BY NEWID()			
					--Danh sach cau hoi cua bai thi
					SELECT BAITHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM=@maBangDiem) BAITHI, BODE WHERE BODE.CAUHOI = BAITHI.CAUHOI				
				END
			ELSE
				BEGIN
					SELECT @soluongCSkhac = COUNT(CAUHOI) FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
			
					IF (@soluong + @soluongCSkhac < @soCauThi)
						BEGIN
							RAISERROR ('So luong cau hoi khong du',16,1)
							ROLLBACK
						END
					ELSE
						BEGIN 		
							--Tao bai thi (duoc luu trong CTBAITHI)
							--Lay cau hoi o co so hien tai
							INSERT INTO CTBAITHI (CAUHOI, MABANGDIEM)
							SELECT TOP (@soluong) CAUHOI, @maBangDiem FROM BODE
							WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
							ORDER BY NEWID()

							--Lay cau hoi o co so khac
							INSERT INTO CTBAITHI (CAUHOI, MABANGDIEM)
							SELECT TOP (@soCauThi-@soluong) CAUHOI, @maBangDiem FROM BODE
							WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA))
							ORDER BY NEWID()			
							--Danh sach cau hoi cua bai thi
							SELECT BAITHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM=@maBangDiem) BAITHI,
																			(SELECT * FROM BODE WHERE BODE.MAMH = @maMH) DE
							WHERE DE.CAUHOI = BAITHI.CAUHOI				
						END
				END
		END
	ELSE --trinh do A hoac B
		BEGIN
			--Luu toan boan cau hoi cung trinh do vao bang tam #DETHI
			SELECT CAUHOI, NOIDUNG, A, B, C, D INTO #DETHI FROM BODE
			WHERE MAMH = @maMH AND  TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
			--So luong cau hoi
			SELECT @soluong = COUNT(CAUHOI)  FROM #DETHI

			IF (@soluong >= @soCauThi) 
				BEGIN
					INSERT INTO CTBAITHI(CAUHOI, MABANGDIEM)
					SELECT TOP (@soCauThi) CAUHOI, @maBangDiem FROM #DETHI
					ORDER BY NEWID()

					SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
					WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
				END
			ELSE IF (@soluong >= @soCauthi*0.7)
				BEGIN
					INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D) --Luu them nhung cau hoi duoi trinh do 1 bac CUNG CO SO
					SELECT TOP (@soCauThi - @soluong) CAUHOI, NOIDUNG, A, B, C, D FROM BODE
					WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
					ORDER BY NEWID()

					SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI

					
					IF (@soLuongMoi >= @soCauThi)
						BEGIN
							INSERT INTO CTBAITHI(CAUHOI, MABANGDIEM)
							SELECT TOP (@soCauThi) CAUHOI, @maBangDiem FROM #DETHI
							ORDER BY NEWID()

							SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
							WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
						END
					ELSE --chuyen co so
						BEGIN
							INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D) --Luu them cau hoi cung bac nhung KHAC CO SO
							SELECT TOP (@soCauThi - @soLuongMoi) CAUHOI, NOIDUNG, A, B, C, D FROM BODE
							WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA))
							ORDER BY NEWID()

							SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI
							IF (@soLuongMoi >= @soCauThi)
								BEGIN
									INSERT INTO CTBAITHI(CAUHOI, MABANGDIEM)
									SELECT TOP (@soCauThi) CAUHOI, @maBangDiem FROM #DETHI
									ORDER BY NEWID()

									SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
									WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
								END
							ELSE
								BEGIN
									INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D) --Luu them cau hoi duoi 1 bac nhung KHAC CO SO
									SELECT TOP (@soCauThi - @soLuongMoi) CAUHOI, NOIDUNG, A, B, C, D FROM BODE
									WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA))
									ORDER BY NEWID()
									
									SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI
									SELECT COUNT(CAUHOI) FROM #DETHI
									IF (@soLuongMoi >= @soCauThi)
										BEGIN
											INSERT INTO CTBAITHI(CAUHOI, MABANGDIEM)
											SELECT TOP (@soCauThi) CAUHOI, @maBangDiem FROM #DETHI
											ORDER BY NEWID()

											SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI
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
					INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D) --luu them cau hoi cung bac NHUNG KHAC CO SO
					SELECT TOP (@soCauThi - @soluong) CAUHOI, NOIDUNG, A, B, C, D FROM BODE
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
					ORDER BY NEWID()

					SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI
					
					IF (@soLuongMoi >= @soCauThi)
						BEGIN						
							INSERT INTO CTBAITHI(CAUHOI, MABANGDIEM)
							SELECT TOP (@soCauThi)CAUHOI, @maBangDiem FROM #DETHI
							ORDER BY NEWID()

							SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
							
						END
					ELSE IF (@soLuongMoi >= @soCauThi*0.7)
						BEGIN
							INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D) --luu them cau hoi duoi 1 bac CUNG CO SO
							SELECT TOP (@soCauThi - @soLuongMoi) CAUHOI, NOIDUNG, A, B, C, D FROM BODE
							WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
							ORDER BY NEWID()

							SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI

							IF (@soLuongMoi >= @soCauThi)
								BEGIN
									INSERT INTO CTBAITHI(CAUHOI, MABANGDIEM)
									SELECT TOP (@soCauThi) CAUHOI, @maBangDiem FROM #DETHI
									ORDER BY NEWID()

									SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
								END
							ELSE 
								BEGIN
									INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D) --luu them cau hoi duoi 1 bac KHAC CO SO
									SELECT TOP (@soCauThi - @soLuongMoi) CAUHOI, NOIDUNG, A, B, C, D FROM BODE
									WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
									ORDER BY NEWID()

									SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI

									IF (@soLuongMoi >= @soCauThi)
										BEGIN
											INSERT INTO CTBAITHI(CAUHOI, MABANGDIEM)
											SELECT TOP (@soCauThi) CAUHOI, @maBangDiem FROM #DETHI
											ORDER BY NEWID()

											SELECT #DETHI.CAUHOI, NOIDUNG, A, B, C, D FROM (SELECT CAUHOI FROM CTBAITHI WHERE CTBAITHI.MABANGDIEM = @maBangDiem) BAITHI, #DETHI WHERE BAITHI.CAUHOI = #DETHI.CAUHOI
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
/****** Object:  StoredProcedure [dbo].[SP_ThiSinhXemKetQua]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SP_ThiSinhXemKetQua]
    @MASV CHAR(10),
    @MAMH CHAR(10),
    @LAN INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Bảng 1: Thông tin sinh viên, môn học, lớp, ngày thi và lần thi
    SELECT 
        CONCAT(s.HO, ' ', s.TEN) AS HO_TEN,
        m.TENMH,
        m.MAMH,
        l.TENLOP,
        bd.NGAYTHI,
        bd.LAN,
		bd.DIEM
    FROM 
        BANGDIEM bd
    JOIN 
        SINHVIEN s ON bd.MASV = s.MASV
    JOIN 
        MONHOC m ON bd.MAMH = m.MAMH
    JOIN 
        LOP l ON s.MALOP = l.MALOP
    WHERE 
        bd.MASV = @MASV 
        AND bd.MAMH = @MAMH 
        AND bd.LAN = @LAN;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_ThiThu]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ThiThu] @malop NCHAR(15), @maMH nchar(5), @lan smallint
AS
SET XACT_ABORT ON
BEGIN TRAN
BEGIN TRY
	DECLARE @soCauThi int, @trinhDo nchar(1), @soluong int, @soluongCSkhac int, @trinhDoDuoi nchar(1), @soLuongMoi int

	--Uu tien lay de cua giao vien o co so  ma lop do dang hoc
	--khong phai la lay de theo giao vien day lop do!!!
	SELECT  @soCauThi = SOCAUTHI, @trinhDo = TRINHDO FROM GIAOVIEN_DANGKY WHERE MAMH = @maMH AND MALOP = @maLop AND LAN = @lan	

	EXEC SP_KiemTraSoLuongCau @maMH, @trinhDo, @soCauThi

	IF (@trinhDo = 'A')
		SET @trinhDoDuoi = 'B'
	ELSE IF (@trinhDo = 'B')
		SET @trinhDoDuoi = 'C'

	--Tu dong tao bang diem khi thi, diem = null
	DECLARE @giothi datetime = DATEADD(MINUTE, 1, CURRENT_TIMESTAMP)

	CREATE TABLE #CTBAITHI (
		CAUHOI INT,
		NOIDUNG NTEXT,
		A NTEXT,
		B NTEXT,
		C NTEXT,
		D NTEXT,
		DAPAN CHAR(1)
	)

	IF (@trinhDo = 'C')
		BEGIN
			SELECT @soluong = COUNT(CAUHOI) FROM BODE 
			WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
			IF (@soluong > @soCauThi)
				BEGIN				
					--Tao bai thi (duoc luu trong CTBAITHI)
					INSERT INTO #CTBAITHI (CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
					SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
					WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
					ORDER BY NEWID()			
					--Danh sach cau hoi cua bai thi
					SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI			
				END
			ELSE
				BEGIN
					SELECT @soluongCSkhac = COUNT(CAUHOI) FROM BODE 
						WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
			
					IF (@soluong + @soluongCSkhac < @soCauThi)
						BEGIN
							RAISERROR ('So luong cau hoi khong du',16,1)
							ROLLBACK
						END
					ELSE
						BEGIN 		
							--Tao bai thi (duoc luu trong CTBAITHI)
							--Lay cau hoi o co so hien tai
							INSERT INTO #CTBAITHI (CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
							SELECT TOP (@soluong) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
							WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
							ORDER BY NEWID()

							--Lay cau hoi o co so khac
							INSERT INTO #CTBAITHI (CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
							SELECT TOP (@soCauThi-@soluong) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
							WHERE BODE.MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA))
							ORDER BY NEWID()			
							--Danh sach cau hoi cua bai thi
							SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI		
						END
				END
		END
	ELSE --trinh do A hoac B
		BEGIN
			--Luu toan boan cau hoi cung trinh do vao bang tam #DETHI
			SELECT CAUHOI, NOIDUNG, A, B, C, D, DAP_AN INTO #DETHI FROM BODE
			WHERE MAMH = @maMH AND  TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
			--So luong cau hoi
			SELECT @soluong = COUNT(CAUHOI)  FROM #DETHI

			IF (@soluong >= @soCauThi) 
				BEGIN
					INSERT INTO #CTBAITHI(CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
					SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM #DETHI
					ORDER BY NEWID()

					SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI
				END
			ELSE IF (@soluong >= @soCauthi*0.7)
				BEGIN
					INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D, DAP_AN) --Luu them nhung cau hoi duoi trinh do 1 bac CUNG CO SO
					SELECT TOP (@soCauThi - @soluong) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
					WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
					ORDER BY NEWID()

					SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI

					
					IF (@soLuongMoi >= @soCauThi)
						BEGIN
							INSERT INTO #CTBAITHI(CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
							SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM #DETHI
							ORDER BY NEWID()

							SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI
						END
					ELSE --chuyen co so
						BEGIN
							INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D, DAP_AN) --Luu them cau hoi cung bac nhung KHAC CO SO
							SELECT TOP (@soCauThi - @soLuongMoi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
							WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA))
							ORDER BY NEWID()

							SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI
							IF (@soLuongMoi >= @soCauThi)
								BEGIN
									INSERT INTO #CTBAITHI(CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM #DETHI
									ORDER BY NEWID()

									SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI
								END
							ELSE
								BEGIN
									INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D, DAP_AN) --Luu them cau hoi duoi 1 bac nhung KHAC CO SO
									SELECT TOP (@soCauThi - @soLuongMoi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
									WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH NOT IN (SELECT MAKH FROM KHOA))
									ORDER BY NEWID()
									
									SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI
									SELECT COUNT(CAUHOI) FROM #DETHI
									IF (@soLuongMoi >= @soCauThi)
										BEGIN
											INSERT INTO #CTBAITHI(CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
											SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM #DETHI
											ORDER BY NEWID()

											SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI
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
					INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D, DAP_AN) --luu them cau hoi cung bac NHUNG KHAC CO SO
					SELECT TOP (@soCauThi - @soluong) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
					WHERE MAMH = @maMH AND TRINHDO = @trinhDo AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
					ORDER BY NEWID()

					SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI
					
					IF (@soLuongMoi >= @soCauThi)
						BEGIN						
							INSERT INTO #CTBAITHI(CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
							SELECT TOP (@soCauThi)CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM #DETHI
							ORDER BY NEWID()

							SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI
						END
					ELSE IF (@soLuongMoi >= @soCauThi*0.7)
						BEGIN
							INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D, DAP_AN) --luu them cau hoi duoi 1 bac CUNG CO SO
							SELECT TOP (@soCauThi - @soLuongMoi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
							WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
							ORDER BY NEWID()

							SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI

							IF (@soLuongMoi >= @soCauThi)
								BEGIN
									INSERT INTO #CTBAITHI(CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
									SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM #DETHI
									ORDER BY NEWID()

									SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI
								END
							ELSE 
								BEGIN
									INSERT INTO #DETHI (CAUHOI, NOIDUNG, A, B, C, D, DAP_AN) --luu them cau hoi duoi 1 bac KHAC CO SO
									SELECT TOP (@soCauThi - @soLuongMoi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM BODE
									WHERE MAMH = @maMH AND TRINHDO = @trinhDoDuoi AND MAGV NOT IN (SELECT MAGV FROM GIAOVIEN WHERE MAKH IN (SELECT MAKH FROM KHOA))
									ORDER BY NEWID()

									SELECT @soLuongMoi = COUNT(CAUHOI) FROM #DETHI

									IF (@soLuongMoi >= @soCauThi)
										BEGIN
											INSERT INTO #CTBAITHI(CAUHOI, NOIDUNG, A, B, C, D, DAPAN)
											SELECT TOP (@soCauThi) CAUHOI, NOIDUNG, A, B, C, D, DAP_AN FROM #DETHI
											ORDER BY NEWID()

											SELECT CAUHOI, NOIDUNG, A, B, C, D, DAPAN FROM #CTBAITHI
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
/****** Object:  StoredProcedure [dbo].[SP_TimKiemBoDe]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_TimKiemBoDe]
    @input nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT BD.*
    FROM BODE BD
    LEFT JOIN MONHOC MH ON BD.MAMH = MH.MAMH
    WHERE
        BD.CAUHOI LIKE '%' + @input + '%'
        OR BD.MAMH LIKE '%' + @input + '%'
        OR MH.TENMH COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%'
		OR BD.TRINHDO LIKE '%' + @input + '%'
        OR BD.NOIDUNG COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TimKiemGiaoVien]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_TimKiemGiaoVien]
    @input nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT GV.*
    FROM GIAOVIEN GV
    LEFT JOIN KHOA kh ON GV.MAKH = kh.MAKH
    WHERE
        GV.MAGV LIKE '%' + @input + '%'
        OR GV.HO COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%'
        OR GV.TEN COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%'
        OR CONCAT(GV.HO, ' ', GV.TEN) COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%'
        OR GV.MAKH LIKE '%' + @input + '%'
        OR kh.TENKH COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TimKiemLop]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_TimKiemLop]
    @input nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM LOP
    LEFT JOIN KHOA KH ON LOP.MAKH = KH.MAKH
    WHERE
        LOP.MALOP LIKE '%' + @input + '%'
        OR LOP.TENLOP COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%'
        OR LOP.MAKH LIKE '%' + @input + '%'
		OR KH.TENKH COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TimKiemMonHoc]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_TimKiemMonHoc]
    @input nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM MONHOC
    WHERE
        MAMH LIKE '%' + @input + '%'
        OR TENMH COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_TimKiemSinhVien]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[SP_TimKiemSinhVien]
    @input nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT sv.*
    FROM sinhvien sv
    LEFT JOIN lop lp ON sv.MALOP = lp.MALOP
    WHERE
        sv.MASV LIKE '%' + @input + '%'
        OR sv.HO COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%'
        OR sv.TEN COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%'
        OR CONCAT(sv.HO, ' ', sv.TEN) COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%'
        OR sv.MALOP LIKE '%' + @input + '%'
        OR lp.TENLOP COLLATE Vietnamese_CI_AI LIKE '%' + @input + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[SP_XemKetQua]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[SP_XemKetQua]
    @MASV CHAR(10),
    @MAMH CHAR(10),
    @LAN INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT 
        b.CAUHOI,
        b.NOIDUNG,
        b.A,
        b.B,
        b.C,
        b.D,
        b.DAP_AN as 'DAPAN',
        c.DAPANSV
    FROM 
        BODE b
    JOIN 
        CTBAITHI c ON b.CAUHOI = c.CAUHOI
    WHERE 
        c.MABANGDIEM = (
            SELECT MABANGDIEM 
            FROM BANGDIEM 
            WHERE MASV = @MASV AND MAMH = @MAMH AND LAN = @LAN
        );
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_XOA_LOGIN]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SP_XOA_LOGIN]
  @LGNAME VARCHAR(50),
  @USRNAME VARCHAR(50)
  
AS
  EXEC SP_DROPUSER @USRNAME
  EXEC SP_DROPLOGIN @LGNAME
GO
/****** Object:  StoredProcedure [dbo].[SP_XoaKhoa]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_XoaKhoa] @MAKH nchar(8)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Lop WHERE MAKH = @MAKH)
        raiserror ('Khoa này đã có lớp, Không thể xóa',16,1)
    ELSE
        DELETE FROM Khoa WHERE MAKH = @MAKH
END
GO
/****** Object:  StoredProcedure [dbo].[SP_XoaLop]    Script Date: 04/08/2024 00:37:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_XoaLop] @MALOP nchar(15)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM SINHVIEN WHERE MALOP = @MALOP)
        raiserror ('Lớp này đã có sinh viên, Không thể xóa',16,1)
    ELSE
        DELETE FROM LOP WHERE MALOP = @MALOP
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ms"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 288
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "mp"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 322
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2790
         Alias = 2370
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_DanhSachPhanManh'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_DanhSachPhanManh'
GO
USE [master]
GO
ALTER DATABASE [TN_CSDLPT] SET  READ_WRITE 
GO
