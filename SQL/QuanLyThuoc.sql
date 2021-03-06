USE [master]
GO
/****** Object:  Database [QuanLyThuoc]    Script Date: 6/2/2021 9:59:01 PM ******/
CREATE DATABASE [QuanLyThuoc]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyThuoc', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QuanLyThuoc.mdf' , SIZE = 5312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyThuoc_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QuanLyThuoc_log.ldf' , SIZE = 4224KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QuanLyThuoc] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyThuoc].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyThuoc] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyThuoc] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyThuoc] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuanLyThuoc] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyThuoc] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyThuoc] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyThuoc] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyThuoc] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyThuoc] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyThuoc] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuanLyThuoc] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QuanLyThuoc] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuanLyThuoc', N'ON'
GO
ALTER DATABASE [QuanLyThuoc] SET QUERY_STORE = OFF
GO
USE [QuanLyThuoc]
GO
/****** Object:  UserDefinedFunction [dbo].[autoMaHD]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[autoMaHD]()
returns nvarchar(255)
as
	begin 
	declare @id nvarchar(255),@maNV int
	select @maNV = MaNhanVien from dbo.HoaDon
	if (select COUNT(MaHoaDon) from dbo.HoaDon) = 0
		set @id= '0'
	else 
		select @id = MAX(RIGHT(LEFT(MaHoaDon,7),5)) from dbo.HoaDon
		select @id = CASE
				WHEN @id = 99999 then 'HD00001'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 0 and @id < 9 then 'HD0000'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 9 then 'HD000'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 99 then 'HD00'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 999 then 'HD0'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				WHEN @id >= 9999 then 'HD'+CONVERT(nvarchar,CONVERT(int,@id)+1) + 'NV'+CONVERT(nvarchar(255),@maNV) + CONVERT(nvarchar(255),GETDATE(),112)
				end
	return @id
	end
GO
/****** Object:  Table [dbo].[CT_HoaDon]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_HoaDon](
	[MaHoaDon] [nvarchar](50) NOT NULL,
	[MaThuoc] [int] NOT NULL,
	[DonGia] [float] NULL,
	[GiamGia] [float] NULL,
	[SoLuong] [int] NULL,
	[DonViTinh] [nvarchar](50) NULL,
 CONSTRAINT [PK_CT_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC,
	[MaThuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiaChi]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaChi](
	[MaDiaChi] [int] IDENTITY(1,1) NOT NULL,
	[SoNha] [nvarchar](50) NULL,
	[TenDuong] [nvarchar](50) NULL,
	[Phuong] [nvarchar](50) NULL,
	[Quan] [nvarchar](50) NULL,
	[ThanhPho] [nvarchar](50) NULL,
	[QuocGia] [nvarchar](50) NULL,
 CONSTRAINT [PK_DiaChi] PRIMARY KEY CLUSTERED 
(
	[MaDiaChi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[MaHoaDon] [nvarchar](50) NOT NULL,
	[NgayLap] [datetime] NOT NULL,
	[MaNhanVien] [int] NOT NULL,
	[MaKhachHang] [int] NULL,
	[TongTien] [float] NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[MaHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKhachHang] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[Ho] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nchar](10) NULL,
	[CMND] [nvarchar](50) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[MaDiaChi] [int] NOT NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNhaCungCap] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](50) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[Gmail] [nvarchar](50) NULL,
	[MaDiaChi] [int] NULL,
 CONSTRAINT [PK_NhaCungCap] PRIMARY KEY CLUSTERED 
(
	[MaNhaCungCap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNhanVien] [int] IDENTITY(1,1) NOT NULL,
	[CaLamViec] [nvarchar](50) NULL,
	[Ten] [nvarchar](50) NULL,
	[Ho] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [nchar](10) NULL,
	[CMND] [nvarchar](50) NULL,
	[SoDienThoai] [nvarchar](50) NULL,
	[MaDiaChi] [int] NOT NULL,
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[LoaiNhanVien] [nvarchar](50) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNhanVien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenTaiKhoan] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Thuoc]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thuoc](
	[MaThuoc] [int] IDENTITY(1,1) NOT NULL,
	[SoDangKi] [nvarchar](50) NOT NULL,
	[TenThuoc] [nvarchar](50) NULL,
	[PhanLoai] [nvarchar](50) NULL,
	[NhomThuoc] [nvarchar](50) NULL,
	[HoatChat] [nvarchar](100) NULL,
	[HamLuong] [nvarchar](50) NULL,
	[DangBaoChe] [nvarchar](50) NULL,
	[QuyCachDongGoi] [nvarchar](50) NULL,
	[TieuChuan] [nvarchar](50) NULL,
	[MaNhaCungCap] [int] NOT NULL,
	[NgaySanXuat] [date] NULL,
	[HanSuDung] [date] NULL,
	[DonViTinh] [nvarchar](50) NULL,
	[GiaNhap] [float] NULL,
	[DonGia] [float] NULL,
	[SoLuongNhap] [int] NULL,
	[HinhAnh] [image] NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_Thuoc] PRIMARY KEY CLUSTERED 
(
	[MaThuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00002NV620191212', 171, 50000, 0, 3, N'Gói')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00002NV620191212', 173, 2500, 0, 5, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00003NV620191212', 170, 23000, 0, 4, N'Tuýt')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00003NV620191212', 198, 115000, 0, 3, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00004NV620191212', 197, 84000, 0, 5, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00004NV620191212', 203, 37500, 0, 13, N'Bơm tiêm')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00005NV620191212', 202, 12000, 0, 3, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00005NV620191212', 206, 1000, 0, 13, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00006NV620191212', 177, 1100, 0, 33, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00006NV620191212', 190, 1900, 0, 15, N'Gói')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00007NV620191212', 172, 50000, 0, 5, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00007NV620191212', 196, 1100, 0, 7, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00008NV620191212', 184, 16500, 0, 6, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00008NV620191212', 194, 2800, 0, 8, N'')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00009NV620191212', 170, 23000, 0, 14, N'Tuýt')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00009NV620191212', 192, 5200, 0, 8, N'Tuýt')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00010NV620191212', 180, 30000, 0, 13, N'Lọ')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00010NV620191212', 203, 37500, 0, 13, N'Bơm tiêm')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00011NV620191212', 173, 2500, 0, 5, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00011NV620191212', 207, 4500, 0, 7, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00012NV620191212', 183, 11000, 0, 12, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00012NV620191212', 188, 4750, 0, 9, N'Gói')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00013NV620191212', 168, 50000, 0, 15, N'tuýt')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00013NV620191212', 193, 290, 0, 8, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00014NV620191212', 173, 2500, 0, 15, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00014NV620191212', 201, 4400, 0, 2, N'Ống')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00015NV620191212', 178, 800, 0, 6, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00016NV620191212', 178, 800, 0, 4, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00016NV620191212', 193, 290, 0, 6, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00017NV620191212', 169, 45000, 0, 7, N'Ống')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00017NV620191212', 195, 2570000, 0, 6, N'Bơm tiêm')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00018NV620191212', 205, 7000, 0, 4, N'Hộp')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00018NV620191212', 206, 1000, 0, 65, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00019NV620191212', 188, 4750, 0, 13, N'Gói')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00019NV620191212', 189, 1000, 0, 13, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00020NV620191212', 170, 23000, 0, 6, N'Tuýt')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00020NV620191212', 183, 11000, 0, 13, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00021NV620191212', 191, 9000, 0, 3, N'Chai')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00021NV620191212', 198, 115000, 0, 22, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00022NV620191212', 191, 9000, 0, 4, N'Chai')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00022NV620191212', 194, 2800, 0, 3, N'')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00023NV620191212', 180, 30000, 0, 2, N'Lọ')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00023NV620191212', 189, 1000, 0, 16, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00024NV620191212', 173, 2500, 0, 5, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00024NV620191212', 203, 37500, 0, 17, N'Bơm tiêm')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00025NV620191212', 168, 50000, 0, 33, N'tuýt')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00025NV620191212', 178, 800, 0, 15, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00026NV620191212', 182, 4300, 0, 13, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00026NV620191212', 197, 84000, 0, 12, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00027NV620191212', 191, 9000, 0, 12, N'Chai')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00027NV620191212', 198, 115000, 0, 12, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00028NV620191212', 188, 4750, 0, 4, N'Gói')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00028NV620191212', 190, 1900, 0, 6, N'Gói')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00029NV620191212', 169, 45000, 0, 13, N'Ống')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00029NV620191212', 199, 5900, 0, 12, N'Lọ')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00030NV620191212', 196, 1100, 0, 6, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00031NV620191212', 196, 1100, 0, 3, N'Viên')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00031NV620191212', 204, 51000, 0, 6, N'Lọ')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00032NV620191212', 169, 45000, 0, 6, N'Ống')
INSERT [dbo].[CT_HoaDon] ([MaHoaDon], [MaThuoc], [DonGia], [GiamGia], [SoLuong], [DonViTinh]) VALUES (N'HD00032NV620191212', 174, 2600, 0, 14, N'Viên')
GO
SET IDENTITY_INSERT [dbo].[DiaChi] ON 

INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (1, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (3, N'245', N'Quang Trung', N'P.11', N'Gò Vấp', N'Hồ Chí Minh', N'Viet Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (4, N'245', N'Quang Trung', N'P.11', N'Gò Vấp', N'Hồ Chí Minh', N'Viet Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (5, N'21', N'Quang Trung', N'P.11', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (6, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (7, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (8, N'21', N'Quan Trung', N'P.11', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (9, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (10, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (11, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (12, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (13, N'56', N'Nguyen Van Bao', N'P.11', N'Go Vap', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (14, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (15, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (16, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (17, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (18, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (19, N'21', N'Quang Trung', N'12', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (20, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (21, N'56', N'Nguyen Van Bao', N'P.11', N'Go Vap', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (22, N'56', N'Le Duc Tho', N'P.11', N'Go Vap', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (23, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (24, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (25, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (26, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (27, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (28, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (29, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (30, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (31, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (32, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (33, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (34, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (35, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (36, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (37, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (38, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (39, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (40, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (41, N'12', N'Quy Cap', N'P.10', N'Go Vap', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (42, N'34', N'Tran Duy Hung', N'11', N'Q.11', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (43, N'23', N'Khanh Pho', N'P11', N'Go Vap', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (44, N'21', N'hnd', N'12', N'5', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (45, N'21', N'Phan', N'P23', N'nd', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (46, N'123', N'123', N'123', N'123', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (47, N'123', N'123', N'132', N'123', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (48, N'123', N'123', N'123', N'123', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (49, N'209/34', N'Quốc Lộ 13', N'26', N'Bình Thạnh', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (50, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (51, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (52, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (53, N'34', N'Quang Trung', N'P.10', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (54, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (55, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (56, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (57, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (58, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (59, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (60, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (61, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (62, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (63, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (64, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (65, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (66, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (67, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (68, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (69, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (70, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (71, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (72, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (73, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (74, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (75, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (76, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (77, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (78, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (79, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (80, N'21', N'Nguyễn Văn Bảo', N'21', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (81, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (82, N'34/23', N'Quang Trung', N'P.15', N'Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
INSERT [dbo].[DiaChi] ([MaDiaChi], [SoNha], [TenDuong], [Phuong], [Quan], [ThanhPho], [QuocGia]) VALUES (83, N'145', N'Trần Bá Giao', N'phường 5', N'quận Gò Vấp', N'Hồ Chí Minh', N'Việt Nam')
SET IDENTITY_INSERT [dbo].[DiaChi] OFF
GO
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00001NV620191117', CAST(N'2019-12-12T00:17:02.443' AS DateTime), 6, NULL, 20000)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00002NV620191212', CAST(N'2019-12-12T00:17:25.433' AS DateTime), 6, 27, 170625)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00003NV620191212', CAST(N'2019-12-12T00:18:40.770' AS DateTime), 6, NULL, 684075)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00004NV620191212', CAST(N'2019-12-12T00:19:03.940' AS DateTime), 6, 27, 952875)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00005NV620191212', CAST(N'2019-12-12T00:19:30.813' AS DateTime), 6, 27, 51450)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00006NV620191212', CAST(N'2019-12-12T00:20:05.007' AS DateTime), 6, 27, 68040)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00007NV620191212', CAST(N'2019-12-12T00:21:10.170' AS DateTime), 6, 27, 270585)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00008NV620191212', CAST(N'2019-12-12T00:21:40.193' AS DateTime), 6, 27, 127470)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00009NV620191212', CAST(N'2019-12-12T00:22:07.513' AS DateTime), 6, 27, 381780)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00010NV620191212', CAST(N'2019-12-12T00:22:40.427' AS DateTime), 6, 6, 921375)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00011NV620191212', CAST(N'2019-12-12T00:23:14.697' AS DateTime), 6, 27, 46200)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00012NV620191212', CAST(N'2019-12-12T00:24:08.560' AS DateTime), 6, 6, 183487.5)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00013NV620191212', CAST(N'2019-12-12T00:24:36.380' AS DateTime), 6, 27, 789936)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00014NV620191212', CAST(N'2019-12-12T00:26:07.373' AS DateTime), 6, 6, 48615)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00015NV620191212', CAST(N'2019-12-12T00:27:05.890' AS DateTime), 6, NULL, 5040)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00016NV620191212', CAST(N'2019-12-12T00:27:44.133' AS DateTime), 6, NULL, 5187)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00017NV620191212', CAST(N'2019-12-12T00:28:10.770' AS DateTime), 6, 27, 16521750)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00018NV620191212', CAST(N'2019-12-12T00:28:43.157' AS DateTime), 6, 27, 97650)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00019NV620191212', CAST(N'2019-12-12T00:29:18.833' AS DateTime), 6, NULL, 93187.5)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00020NV620191212', CAST(N'2019-12-12T00:30:18.437' AS DateTime), 6, 27, 295050)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00021NV620191212', CAST(N'2019-12-12T00:37:14.630' AS DateTime), 6, NULL, 2684850)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00022NV620191212', CAST(N'2019-12-12T00:37:53.623' AS DateTime), 6, NULL, 46620)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00023NV620191212', CAST(N'2019-12-12T00:38:15.883' AS DateTime), 6, NULL, 79800)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00024NV620191212', CAST(N'2019-12-12T00:38:40.447' AS DateTime), 6, 27, 682500)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00025NV620191212', CAST(N'2019-12-12T00:39:07.273' AS DateTime), 6, 27, 1745100)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00026NV620191212', CAST(N'2019-12-12T00:39:30.093' AS DateTime), 6, 27, 1117095)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00027NV620191212', CAST(N'2019-12-12T00:39:49.510' AS DateTime), 6, NULL, 1562400)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00028NV620191212', CAST(N'2019-12-12T00:40:29.177' AS DateTime), 6, NULL, 31920)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00029NV620191212', CAST(N'2019-12-12T00:41:18.150' AS DateTime), 6, 27, 688590)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00030NV620191212', CAST(N'2019-12-12T00:41:48.417' AS DateTime), 6, 6, 6930)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00031NV620191212', CAST(N'2019-12-12T00:42:29.713' AS DateTime), 6, 27, 324765)
INSERT [dbo].[HoaDon] ([MaHoaDon], [NgayLap], [MaNhanVien], [MaKhachHang], [TongTien]) VALUES (N'HD00032NV620191212', CAST(N'2019-12-12T00:43:03.607' AS DateTime), 6, 27, 321720)
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (3, N'Văn Hoang', N'Nguyễn', CAST(N'1999-11-21' AS Date), N'Nam       ', N'225684528', N'089815621', 1)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (4, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'0898156222', 1)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (5, N'An', N'Nguyễn', CAST(N'1999-09-19' AS Date), N'Nam       ', N'2267311', N'018332122', 1)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (6, N'Văn Hoàng', N'Nguyễn', CAST(N'1999-11-19' AS Date), N'Nam       ', N'22567817', N'01227023317', 5)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (7, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 6)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (8, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 7)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (9, N'Văn Hoang', N'Nguyễn ', CAST(N'1999-11-19' AS Date), N'Nam       ', N'22445643', N'01233211', 8)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (10, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 9)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (11, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 10)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (12, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 11)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (13, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 12)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (14, N'Nam', N'Nguyen ', CAST(N'1998-11-19' AS Date), N'Nam       ', N'2235543', N'012278963', 13)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (15, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 14)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (16, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 15)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (17, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 16)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (18, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 17)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (19, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 18)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (20, N'Hoang', N'Bao', CAST(N'1999-09-19' AS Date), N'Nam       ', N'233321233', N'089815621', 19)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (21, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 20)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (22, N'Nam', N'Nguyen ', CAST(N'1998-11-19' AS Date), N'Nam       ', N'2235543', N'012278963', 21)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (23, N'Hoai Nam', N'Nguyen', CAST(N'1997-11-20' AS Date), N'Nam       ', N'23456664', N'012313412', 22)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (24, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 23)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (25, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 24)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (26, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 25)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (27, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nữ        ', N'2267333', N'0898136946', 26)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (28, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 27)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (29, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 28)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (30, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 29)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (31, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 30)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (32, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 31)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (33, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 32)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (34, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 33)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (35, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 34)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (36, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 35)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (37, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 36)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (38, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 37)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (39, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 38)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (40, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 39)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (41, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 40)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (42, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 50)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (43, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 51)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (44, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 52)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (45, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 54)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (46, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 55)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (47, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 56)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (48, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 57)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (49, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 58)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (50, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 59)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (51, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 60)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (52, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 61)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (53, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 62)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (54, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 63)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (55, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 64)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (56, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 65)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (57, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 66)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (58, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 67)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (59, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 68)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (60, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 69)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (61, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 70)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (62, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 71)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (63, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 72)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (64, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 73)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (65, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 74)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (66, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 75)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (67, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 76)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (68, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 77)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (69, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 78)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (70, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 79)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (71, N'Nam', N'Nguyễn ', CAST(N'1998-11-18' AS Date), N'Nam       ', N'22446654', N'01227023317', 80)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (72, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 81)
INSERT [dbo].[KhachHang] ([MaKhachHang], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi]) VALUES (73, N'Hoài Bảo An', N'Nguyễn ', CAST(N'1999-10-28' AS Date), N'Nam       ', N'2267333', N'0898136946', 82)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[NhaCungCap] ON 

INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [Ten], [SoDienThoai], [Gmail], [MaDiaChi]) VALUES (1, N'Công ty cổ phần dược phẩm 32', NULL, NULL, NULL)
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [Ten], [SoDienThoai], [Gmail], [MaDiaChi]) VALUES (2, N'TNHH Quốc Chiến', N'0988555454', N'quocnguyen@gmail.com', 1)
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [Ten], [SoDienThoai], [Gmail], [MaDiaChi]) VALUES (3, N'TNHH Hiệp Tân', N'0988747234', N'hieptann@gmail.com', 1)
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [Ten], [SoDienThoai], [Gmail], [MaDiaChi]) VALUES (4, N'TNHH Chiến Thắng', N'0988123759', N'chienthangn@gmail.com', 1)
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [Ten], [SoDienThoai], [Gmail], [MaDiaChi]) VALUES (5, N'TNHH Hoàng Mỹ', N'0988658123', N'hoangmy@gmail.com', 1)
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [Ten], [SoDienThoai], [Gmail], [MaDiaChi]) VALUES (6, N'TNHH Văn Phong', N'0988638459', N'vanphong@gmail.com', 1)
SET IDENTITY_INSERT [dbo].[NhaCungCap] OFF
GO
SET IDENTITY_INSERT [dbo].[NhanVien] ON 

INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (2, N'Ca 2', N' Nguyen Hoang', N'Hoang', CAST(N'2001-11-20' AS Date), N'Nam       ', N'225735813', N'0898345678', 1, N'NV1', N'NV', N'Đang làm việc')
INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (3, N'Ca 1', N'An', N'Nguyen', CAST(N'2001-11-20' AS Date), N'Nữ        ', N'245676542', N'0898342334', 1, N'NV2', N'QL', N'Đang làm việc')
INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (5, N'Ca 2', N'Nguyen', N'Hoai', CAST(N'2001-11-20' AS Date), N'Nữ        ', N'245676544', N'0898345623', 3, N'QL1', N'QL', N'Đang làm việc')
INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (6, N'2', N'ADMIN', N'ADMIN', CAST(N'2001-11-21' AS Date), N'Nam       ', N'245676540', N'0898345612', 3, N'ADMIN', N'QL', N'Đang làm việc')
INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (13, N'1', N'Nhật', N'Nguyễn Hữu', CAST(N'2000-05-01' AS Date), N'Nam       ', N'54125415', N'0879546857', 16, N'QL2', N'QL', N'Đang làm việc')
INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (66, N'1', N'Anh', N'Nguyễn Tuấn', CAST(N'2001-09-09' AS Date), N'Nam       ', N'99999999', N'0999999999', 48, N'anhdeptrai', N'NV', N'Nghỉ việc')
INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (67, N'1', N'Quyền', N'Phan Văn', CAST(N'1995-11-06' AS Date), N'Nam       ', N'82387878', N'0987898789', 49, N'Quyen', N'QL', N'Nghỉ việc')
INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (68, N'1', N'An', N'Trần', CAST(N'1998-09-24' AS Date), N'Nam       ', N'090332332', N'0777892377', 53, N'TranAn', N'NV', N'Đang làm việc')
INSERT [dbo].[NhanVien] ([MaNhanVien], [CaLamViec], [Ten], [Ho], [NgaySinh], [GioiTinh], [CMND], [SoDienThoai], [MaDiaChi], [TenTaiKhoan], [LoaiNhanVien], [TrangThai]) VALUES (69, N'1', N'Đạt', N'Phạm Thành', CAST(N'2001-01-02' AS Date), N'Nam       ', N'072201000', N'0339686430', 83, N'DAT', N'NV', N'Đang làm việc')
SET IDENTITY_INSERT [dbo].[NhanVien] OFF
GO
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'000', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'00000000', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'999', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'AAA', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'ADMIN', N'ADMIN')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'Anh', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'Anhdeptrai', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'DAT', N'02012001')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'HoaiAn', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'HoaiANNNANANANNA', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'HoaiThuong', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'HoangNam', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'KhanhNguyen', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'LongAn', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'Nam', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'NV1', N'')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'NV2', N'12345')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'QL1', N'12345')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'QL2', N'12345')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'Quyen', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'ssss', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'TranAn', N'12345678')
INSERT [dbo].[TaiKhoan] ([TenTaiKhoan], [MatKhau]) VALUES (N'ttt', N'12345678')
GO
SET IDENTITY_INSERT [dbo].[Thuoc] ON 

INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (168, N'VN-18307-14', N'Eumovate cream', N'Thuốc kê đơn', N'Thuốc điều trị bệnh da liễu', N'Clobetasol', N'0,05%', N'Kem bôi ngoài da', N'Hộp 1 tuýp 5g', N'NSX', 1, CAST(N'2018-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'tuýt', 20269, 50000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (169, N'VS-123-45', N'Viabiovit', N'Thuốc kê đơn', N'Thực phẩm chức năng', N'Bacillus Clausii', N' Bacillus clausii', N'Ống 10 ml', N'H?p 10 ?ng', N'CSS', 1, CAST(N'2018-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Ống', 40000, 45000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (170, N'VN-15377-12', N'Contractubex', N'Không kê đơn', N'Thuốc điều trị bệnh da liễu', N' Heparin', N'10g,5000IU,1g/100g', N'Gel bôi ngoài da', N'Hộp 1 tuýp 10g', N'CSS', 1, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Tuýt', 22000, 23000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (171, N'VN-0386-06', N'Gumas', N'Không kê đơn', N'Thuốc đường tiêu hóa', N'Nhôm hydroxyd', N'400mg', N'Hỗn dịch uống', N'Hộp 20 gói x 10ml', N'TCSS', 1, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Gói', 30000, 50000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (172, N'VN-4064-07', N'Sobelin', N'Không kê đơn', N'Thuốc điều trị đau nửa đầu', N'Flunarizine', N'5mg', N'Viên nang', N'Hộp 10 vỉ x 10 viên', N'NSX', 1, CAST(N'2018-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Viên', 22000, 50000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (173, N'VN-13044-11', N'Lelocin 5', N'Thuốc kê đơn', N'Flunarizin', N'Thuốc điều trị đau nửa đầu', N'5mg', N'Viên nang cứng', N'Hộp 3 vỉ x 10 viên', N'CSS', 1, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 2200, 2500, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (174, N'VN-5517-10', N'Myderison', N'Thuốc kê đơn', N'Tolperisone', N'Thuốc giãn cơ và tăng trương lực cơ', N'50mg', N'Viên nang cứng', N'Viên', N'CSS', 1, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 2500, 2600, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (175, N'VD-29288-18', N'Cetazin', N'Không kê đơn', N'Thuốc chống dị ứng', N'Cetirizin', N'10mg', N'Viên nang cứng', N'Hộp 10 vỉ x 10 viên', N'CSS', 1, CAST(N'2017-07-08' AS Date), CAST(N'2019-07-08' AS Date), N'Viên', 2200, 2500, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (176, N'VD-26046-17', N'Sibetinic', N'Thuốc kê đơn', N'Thuốc điều trị đau nửa đầu', N'Flunarizin', N'5mg', N'Viên nén bao phim', N'Hộp 10 vỉ x 10 viên', N'TCSS', 1, CAST(N'2017-07-08' AS Date), CAST(N'2019-07-08' AS Date), N'viên', 2300, 2500, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (177, N'VD-21189-14', N'Panadol extra', N'Thuốc kê đơn', N'thuốc giảm đâu', N'Paracetamol', N'500mg', N'Viên nén', N'Hộp 15 vỉ x 12 viên', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Viên', 1000, 1100, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (178, N'VN-17961-14', N'Panadol trẻ em', N'Không kê đơn', N'thuốc giảm đâu', N'Paracetamol (dạng Paracetamol vi nang)', N'120mg', N'Viên nhai', N'Hộp 8 vỉ x 12viên', N'NSX', 2, CAST(N'2020-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 600, 800, 200, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (179, N'VN-16488-13', N'Panadol Viên sủi', N'Không kê đơn', N'thuốc giảm đâu', N'Paracetamol', N'500mg', N'Viên sủi', N'Hộp 5 vỉ x 4 viên', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Viên', 2000, 2200, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (180, N'VN-22219-19', N'Ferlatum', N'Không kê đơn', N'thuốc tác dụng đối với máu', N'Sắt (III) (dưới dạng sắt protein succinylat 800 mg)', N'40mg', N'Dung dịch uống', N'Hộp 10 lọ x 15ml', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Lọ', 29500, 30000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (181, N'VD-4758-08', N'Fumarate', N'Không kê đơn', N'thuốc tác dụng đối với máu', N'Sắt (II) fumarate', N'40mg', N'Viên nang mềm', N'Hộp 10 vỉ x 10 viên', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Viên', 1000, 1100, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (182, N'VN-22050-19', N'Herbesser 60', N'Không kê đơn', N'Thuốc tim mạch', N'Diltiazem Hydrochloride ', N'60mg', N'Viên nén', N'Hộp 10 vỉ x 10 viên', N'NSX', 3, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Viên', 4100, 4300, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (183, N'VN-18870-15', N'Pinclos', N'Thuốc kê đơn', N'Thuốc tim mạch', N'Clopidogrel', N'75mg', N'Viên nén bao phim', N'Hộp 3 vỉ x 10 viên', N'NSX', 3, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Viên', 10000, 11000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (184, N'VN-18150-14', N'Crestor 10mg', N'Thuốc kê đơn', N'Thuốc tim mạch', N'Rosuvastatin ', N'10mg', N'Viên nén bao phim', N'Hộp 2 vỉ x 14 viên', N'NSX', 1, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Viên', 16000, 16500, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (185, N'VN-18151-14', N'Crestor 20mg', N'Thuốc kê đơn', N'Thuốc tim mạch', N'Rosuvastatin', N'20mg', N'Viên nén bao phim', N'Hộp 2 vỉ x 14 viên', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2019-07-08' AS Date), N'Viên', 170000, 175000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (186, N'VD-203156-13', N'Xuyên bỗi mẫu', N'Không kê đơn', N'Thuốc tác dụng trên đường hô hấp', N'Xuyên bối mẫu ', N'0.4g', N'Viên ngậm', N'Hộp 20 vỉ, mỗi vỉ 5 viên', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2020-07-08' AS Date), N'Viên', 2200, 2300, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (187, N'VN-10435-05', N'Nasonex', N'Không kê đơn', N'Thuốc tác dụng trên đường hô hấp', N'Mometasone', N'3000 mcg', N'Thuốc xịt định liều', N'Hộp 1 bình 60 lần xịt', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2019-07-08' AS Date), N'Hộp', 49000, 50000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (188, N'VD-28433-17', N'Desalmux', N'Không kê đơn', N'Thuốc tác dụng trên đường hô hấp', N'Carbocistein', N'375 mg', N'Thuốc bột uống', N'Hộp 12 gói x 3g', N'TCCS', 1, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Gói', 4650, 4750, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (189, N'VD-20729-14', N'Eucatopdein', N'Không kê đơn', N'Thuốc tác dụng trên đường hô hấp', N'Eucalyptol', N'15 mg', N'Viên nang mềm', N'Hộp 10 vỉ x 10 viên', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 900, 1000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (190, N'VD-24442-16', N'Picymuc', N'Không kê đơn', N'Thuốc tác dụng trên đường hô hấp', N': Acetylcystein', N'200 mg', N'Thuốc cốm', N'Hộp 10 gói, 18 gói, 30 gói x 2g', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Gói', 1840, 1900, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (191, N'VD-16725-12', N'Denicol', N'Không kê đơn', N'Thuốc sát khuẩn', N'Natri borat', N'3.87g', N'Dung dịch rơ miệng', N'Hộp 1 lọ x 15ml', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Chai', 8850, 9000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (192, N'VN-20577-17', N'Betadine Ointment 10% w/w', N'Thuốc kê đơn', N'Thuốc sát khuẩn', N' Povidon Iod', N'10g', N'Thuốc mỡ', N'Hộp 1 tuýp 40g', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Tuýt', 51200, 52000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (193, N'VD-26386-17', N'Pastitussin', N'Không kê đơn', N'Thuốc sát khuẩn', N'Menthol', N'3mg', N'Viên ngậm', N'Hộp 50 vỉ x 10 viên', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 285, 290, 1000, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (194, N'VN-21850-19', N'Efferalgan', N'Không kê đơn', N'Thuốc giảm đâu', N'Paracetamol', N'150 mg', N'Bột sủi bọt', N'Hộp 12 gói', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Gói', 2736, 2800, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (195, N'VN-8437-04', N'Zoladex', N'Thuốc kê đơn', N'Thuốc chống ung thư', N'Goserelin', N'3.6mg', N'Thuốc tiêm dưới da', N'Hộp 1 bơm tiêm có thuốc', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Bơm tiêm', 2568297, 2570000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (196, N'VN-17940-14', N'Tarceva', N'Thuốc kê đơn', N'Thuốc chống ung thư', N'Erlotinib', N'150mg', N'Viên nén bao phim', N'Hộp 3 vỉ x 10 viên', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 9850, 11000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (197, N'VN-18040-14', N'Femara', N'Thuốc kê đơn', N'Thuốc chống ung thư', N'Letrozole', N'2,5mg', N'Viên nén bao phim', N'Hộp 3 vỉ x 10 viên', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 83487, 84000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (198, N'VN-18040-14', N'Casodex', N'Không kê đơn', N'Thuốc chống ung thư', N'Bicalutamide', N'50mg', N'Viên nén bao phim', N'Hộp 2 vỉ x 14 viên', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 114128, 115000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (199, N'VN-10177-05', N'Saferon', N'Không kê đơn', N'Khoáng chất và Vitamin', N'Sắt', N'50mg/5ml', N'Dung dịch uốn', N'Hộp 1 lọ 15ml', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Lọ', 58000, 60000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (200, N'VD-19225-13', N'Phargington', N'Không kê đơn', N'Khoáng chất và Vitamin', N'Cao nhân sâm', N'30mg', N'Viên nang mềm', N'Hộp 6 vỉ x 10 viên', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 57800, 58000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (201, N'VD-26877-17', N'Fucalmax', N'Không kê đơn', N'Khoáng chất và Vitamin', N'Calci lactat', N'500 mg', N'Dung dịch uống', N'Hộp 20 ống nhựa x 10 ml', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Ống', 4400, 4400, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (202, N'VD-24075-16', N'Golheal 300', N'Thuốc kê đơn', N'Khoáng chất và Vitamin', N'Thioctic acid', N'300mg', N'Viên nang mềm', N'Hộp 2 vỉ, 4 vỉ x 15 viên', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 12000, 14000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (203, N'VN-17251-1', N'Diprivan', N'Thuốc kê đơn', N' Thuốc gây tê, mê', N'Propofol', N'10mg/ml (1%)', N'Nhũ tương tiêm/truyền tĩnh mạch', N'Hộp 1 bơm tiêm đóng sẵn 50ml', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Bơm tiêm', 375000, 375000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (204, N'VD-28602-17', N'V.Rohto cool', N'Không kê đơn', N'Thuốc dùng điều trị mắt, tai mũi họng', N' Tetrahydrozolin hydrochlorid', N'6mg', N'Dung dịch nhỏ mắt', N'Hộp 1 lọ 12 ml', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Lọ', 50900, 51000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (205, N'VD-25904-16', N'Meclonate', N'Thuốc kê đơn', N'Thuốc dùng điều trị mắt, tai mũi họng', N'Beclomethason', N'0,05mg/0,05 ml', N'Hỗn dịch xịt mũi', N'Hộp 1 lọ 150 liều 50 mcg', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Hộp', 70000, 75000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (206, N'VD-17896-12', N'Luckminesin', N'Thuốc kê đơn', N'Thuốc giãn cơ và tăng trương lực cơ', N'Mephenesin', N'500 mg', N'Viên nén bao phim', N'Hộp 2 vỉ x 10 viên', N'NSX', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 1000, 2000, 100, NULL, N'đang bán')
INSERT [dbo].[Thuoc] ([MaThuoc], [SoDangKi], [TenThuoc], [PhanLoai], [NhomThuoc], [HoatChat], [HamLuong], [DangBaoChe], [QuyCachDongGoi], [TieuChuan], [MaNhaCungCap], [NgaySanXuat], [HanSuDung], [DonViTinh], [GiaNhap], [DonGia], [SoLuongNhap], [HinhAnh], [TrangThai]) VALUES (207, N'VD-23849-15', N'Pycalis 20', N'Thuốc kê đơn', N'Thuốc giãn cơ và tăng trương lực cơ', N'Tadalafil', N'20 mg', N'Viên nén bao phim', N'Hộp 1 vỉ x 1 viên', N'TCCS', 2, CAST(N'2019-07-08' AS Date), CAST(N'2021-07-08' AS Date), N'Viên', 45000, 46000, 100, NULL, N'đang bán')
SET IDENTITY_INSERT [dbo].[Thuoc] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_NhanVien]    Script Date: 6/2/2021 9:59:02 PM ******/
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [IX_NhanVien] UNIQUE NONCLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [MaHoaDon_default]  DEFAULT ([dbo].[autoMaHD]()) FOR [MaHoaDon]
GO
ALTER TABLE [dbo].[HoaDon] ADD  CONSTRAINT [DF_HoaDon_NgayLap]  DEFAULT (getdate()) FOR [NgayLap]
GO
ALTER TABLE [dbo].[CT_HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_CT_HoaDon_HoaDon] FOREIGN KEY([MaHoaDon])
REFERENCES [dbo].[HoaDon] ([MaHoaDon])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CT_HoaDon] CHECK CONSTRAINT [FK_CT_HoaDon_HoaDon]
GO
ALTER TABLE [dbo].[CT_HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_CT_HoaDon_Thuoc] FOREIGN KEY([MaThuoc])
REFERENCES [dbo].[Thuoc] ([MaThuoc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CT_HoaDon] CHECK CONSTRAINT [FK_CT_HoaDon_Thuoc]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_KhachHang] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KhachHang] ([MaKhachHang])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_KhachHang]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_NhanVien] FOREIGN KEY([MaNhanVien])
REFERENCES [dbo].[NhanVien] ([MaNhanVien])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_NhanVien]
GO
ALTER TABLE [dbo].[KhachHang]  WITH CHECK ADD  CONSTRAINT [FK_KhachHang_DiaChi] FOREIGN KEY([MaDiaChi])
REFERENCES [dbo].[DiaChi] ([MaDiaChi])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhachHang] CHECK CONSTRAINT [FK_KhachHang_DiaChi]
GO
ALTER TABLE [dbo].[NhaCungCap]  WITH CHECK ADD  CONSTRAINT [FK_NhaCungCap_DiaChi] FOREIGN KEY([MaDiaChi])
REFERENCES [dbo].[DiaChi] ([MaDiaChi])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NhaCungCap] CHECK CONSTRAINT [FK_NhaCungCap_DiaChi]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_DiaChi] FOREIGN KEY([MaDiaChi])
REFERENCES [dbo].[DiaChi] ([MaDiaChi])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_DiaChi]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_TaiKhoan] FOREIGN KEY([TenTaiKhoan])
REFERENCES [dbo].[TaiKhoan] ([TenTaiKhoan])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NhanVien_TaiKhoan]
GO
ALTER TABLE [dbo].[Thuoc]  WITH CHECK ADD  CONSTRAINT [FK_Thuoc_NhaCungCap] FOREIGN KEY([MaNhaCungCap])
REFERENCES [dbo].[NhaCungCap] ([MaNhaCungCap])
GO
ALTER TABLE [dbo].[Thuoc] CHECK CONSTRAINT [FK_Thuoc_NhaCungCap]
GO
/****** Object:  StoredProcedure [dbo].[LocNgayTHongKeTinhTrang]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[LocNgayTHongKeTinhTrang]    
AS
BEGIN
	select  NgayLap --CONVERT (nvarchar(10), ngayban, 103)
	from HoaDon 
	order by  NgayLap desc-- CONVERT (nvarchar(10), ngayban, 103) desc
 END
GO
/****** Object:  StoredProcedure [dbo].[LocTenNhanVien]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[LocTenNhanVien] 
@ma nvarchar(50)
AS
	BEGIN
		select distinct MaNhanVien,TenNhanVien=nv.Ho+''+nv.Ten
		from NhanVien nv
		where @ma =MaNhanVien
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeBaoCao]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeBaoCao] 
@ngay nvarchar(50)
AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,t.DonGia,t.GiaNhap,SUM(t.SoLuongNhap) AS SoLuongNhap,sum(ct.SoLuong) as SoLuongBan,sum(ct.SoLuong*t.DonGia) as TienBan ,CONVERT (nvarchar(10), t.HanSuDung, 103) as HanSuDung,t.[SoDangKi]
		from CT_HoaDon ct join Thuoc t on ct.maThuoc= t.maThuoc join HoaDon h on  ct.MaHoaDon=h.MaHoaDon
		where h.NgayLap=@ngay
		group by  t.MaThuoc,t.TenThuoc,t.DonGia,t.GiaNhap,CONVERT (nvarchar(10), t.HanSuDung, 103),t.[SoDangKi]
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeNhanVien]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeNhanVien] 
 @ngay nvarchar(50)
 AS
	BEGIN
		select t.[MaThuoc],t.[TenThuoc],sum(ct.[SoLuong]) as SoLuong,t.DonGia,nv.[MaNhanVien],TenNhanVien=nv.Ho+''+nv.Ten,nv.[CaLamViec],h.[NgayLap],sum(ct.[SoLuong]*t.[DonGia])
		from [dbo].[CT_HoaDon] ct left join [dbo].[Thuoc] t on ct.[MaThuoc]= t.[MaThuoc] left join [dbo].[HoaDon] h on h.[MaHoaDon]= ct.[MaHoaDon] left join [dbo].[NhanVien] nv on h.[MaNhanVien] = nv.[MaNhanVien]
		where h.[NgayLap] = @ngay 
		group by t.MaThuoc,t.TenThuoc,ct.[SoLuong],t.[DonGia],t.PhanLoai,nv.[MaNhanVien],nv.Ho+''+nv.Ten,nv.[CaLamViec],h.[NgayLap]
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeNhanVien_CoDon]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[ThongKeNhanVien_CoDon] 
 @ngay nvarchar(50)
 AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,sum(ct.SoLuong) as SoLuong,t.DonGia,nv.MaNhanVien,TenNhanVien=nv.Ho+''+nv.Ten,nv.CaLamViec,h.NgayLap,sum(ct.SoLuong*t.DonGia)
		from CT_HoaDon ct left join Thuoc t on ct.MaThuoc = t.MaThuoc left join HoaDon h on h.MaHoaDon = ct.MaHoaDon left join NhanVien nv on h.MaNhanVien = nv.MaNhanVien
		where h.NgayLap = @ngay and  h.maKhachHang is not null
		group by  t.MaThuoc,t.TenThuoc,ct.SoLuong,t.DonGia,nv.MaNhanVien,nv.Ho+''+nv.Ten,nv.CaLamViec,h.NgayLap
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeNhanVien_KhongCoDon]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeNhanVien_KhongCoDon] 
@ngay nvarchar(50)
AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,sum(ct.SoLuong) as SoLuong,t.DonGia,nv.MaNhanVien,TenNhanVien=nv.Ho+''+nv.Ten,nv.CaLamViec,h.NgayLap,sum(ct.SoLuong*t.DonGia)
		from CT_HoaDon ct left join Thuoc t on ct.MaThuoc = t.MaThuoc left join HoaDon h on h.MaHoaDon = ct.MaHoaDon left join NhanVien nv on h.MaNhanVien = nv.MaNhanVien
		where h.NgayLap = @ngay and  h.MaKhachHang is null
		group by  t.MaThuoc,t.TenThuoc,ct.SoLuong,t.DonGia,nv.MaNhanVien,nv.Ho+''+nv.Ten,nv.CaLamViec,h.NgayLap
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeThuocConLai]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[ThongKeThuocConLai] 
AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,t.PhanLoai,t.SoLuongNhap,CONVERT (nvarchar(10), t.NgaySanXuat, 103) as NgaySanXuat,CONVERT (nvarchar(10), t.HanSuDung, 103) as HanSuDung
		from  Thuoc t
		where t.SoLuongNhap>0 
		group by t.MaThuoc,t.TenThuoc,t.PhanLoai,t.SoLuongNhap,CONVERT (nvarchar(10), t.NgaySanXuat, 103),CONVERT (nvarchar(10), t.HanSuDung, 103)
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeThuocDaBan]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeThuocDaBan] 
@ngay nvarchar(30)
AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,t.PhanLoai,SUM(ct.SoLuong) as SoLuong,CONVERT (nvarchar(10), t.NgaySanXuat, 103) as NgaySanXuat,CONVERT (nvarchar(10) , t.HanSuDung, 103) as HanSuDung,h.NgayLap
		from CT_HoaDon ct left join Thuoc t on t.MaThuoc = ct.MaThuoc  join HoaDon h on h.MaHoaDon=ct.MaHoaDon
		where ct.MaHoaDon is not null and h.NgayLap=@ngay
		group by t.MaThuoc,t.TenThuoc,t.PhanLoai,SoLuong,CONVERT (nvarchar(10), t.NgaySanXuat, 103),CONVERT (nvarchar(10) , t.HanSuDung, 103),h.NgayLap
END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeThuocHetHan]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ThongKeThuocHetHan] 
@ngay nvarchar(50)
 AS
	BEGIN
		select t.MaThuoc,t.TenThuoc,t.PhanLoai,t.SoLuongNhap,CONVERT (nvarchar(10), t.NgaySanXuat, 103)as NgaySanXuat,CONVERT (nvarchar(10), t.HanSuDung, 103)as HanSuDung
		from  Thuoc t
		where YEAR(t.HanSuDung)<=YEAR(@ngay) and MONTH(t.HanSuDung)<=MONTH(@ngay) 
		group by t.MaThuoc,t.TenThuoc,t.PhanLoai,t.SoLuongNhap,CONVERT (nvarchar(10), t.NgaySanXuat, 103),CONVERT (nvarchar(10), t.HanSuDung, 103)
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTinhTrang_TongLoaiThuocBan]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[ThongKeTinhTrang_TongLoaiThuocBan] 
@ngay nvarchar(50)
AS
	BEGIN
		select COUNT(distinct ct.MaThuoc) as TongThuocDaBan
		from CT_HoaDon ct join HoaDon h on ct.MaHoaDon=h.MaHoaDon
		where h.NgayLap=@ngay
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTinhTrang_TongLoaiThuocConLai]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[ThongKeTinhTrang_TongLoaiThuocConLai] 
 AS
	BEGIN
		select COUNT(distinct MaThuoc) as TongThuocConLai
		from Thuoc
		where SoLuongNhap>0
	END
GO
/****** Object:  StoredProcedure [dbo].[ThongKeTinhTrang_TongLoaiThuocHetHan]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  PROCEDURE [dbo].[ThongKeTinhTrang_TongLoaiThuocHetHan] 
 @ngay nvarchar(50)
 AS
	BEGIN
		select COUNT(distinct MaThuoc) as TongThuocHetHan
		from Thuoc
		where YEAR(HanSuDung)<=YEAR(@ngay) and MONTH(HanSuDung)<=MONTH(@ngay)  and DAY(HanSuDung)<  DAY(@ngay)
	END
GO
/****** Object:  StoredProcedure [dbo].[TongTienSLNhap]    Script Date: 6/2/2021 9:59:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TongTienSLNhap]
AS
BEGIN
   select SUM(t.[GiaNhap]*t.[SoLuongNhap])as TongTienSoLuongNhap from Thuoc t
 END
GO
USE [master]
GO
ALTER DATABASE [QuanLyThuoc] SET  READ_WRITE 
GO
