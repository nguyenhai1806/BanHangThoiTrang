CREATE DATABASE QLSHOPTHOITRANG
GO
USE QLSHOPTHOITRANG
GO

--use master
--drop database QLSHOPTHOITRANG

CREATE TABLE Khachhang
(
	Makh int identity(1,1) not null,
	Hoten nvarchar(50),
	Ngaysinh date,
	Sodienthoai nchar(10),
	Gioitinh nvarchar(10),
	Email nchar(50),
	Diachi nvarchar(50),
	Tendangnhap nvarchar(50),
	Matkhau nvarchar(50),
	Hoatdong nchar(10),
	primary key (Makh)
)

CREATE TABLE Nhanvien
(
	Manv int identity(1,1) not null,
	Hoten nvarchar(50),
	Ngaysinh date,
	Gioitinh nvarchar(10),
	Email nchar(50),
	Sodienthoai nchar(10),
	Diachi nvarchar(50),
	Tendangnhap nvarchar(50),
	Matkhau nvarchar(50),
	Phanquyen nchar(20),
	primary key (Manv)
)

CREATE TABLE Loaisanpham
(
	Maloai int identity(1,1) not null,
	Tenloai nvarchar(50),
	primary key (Maloai)
)

CREATE TABLE Nhasanxuat
(
	Manhasx int identity(1,1) not null,
	Tennhasx nvarchar(50),
	Xuatxu nvarchar(50),
	primary key (Manhasx)
)

CREATE TABLE Sanpham
(
	Masanpham int identity(1,1) not null,
	Tensanpham nvarchar(200),
	Maloai int,
	Manhasx int,
	Hinhanh nchar(80),
	Gia float,
	Soluong int,
	primary key (Masanpham)
)
alter table Sanpham
add constraint fk_Sanpham_Loaisanpham foreign key (Maloai) references Loaisanpham(Maloai)
alter table Sanpham
add constraint fk_Sanpham_Nhasanxuat foreign key (Manhasx) references Nhasanxuat(Manhasx)

CREATE TABLE Chitietsanpham
(
	Masanpham int not null,
	Chitietsanpham nText,
	primary key (Masanpham)
)
alter table Chitietsanpham
add constraint fk_Chitietsanpham_Sanpham foreign key (Masanpham) references Sanpham(Masanpham)

CREATE TABLE Hoadon
(
	Mahd nchar(40) not null,
	Makh int,
	Manv int,
	NgayHoaDon date,
	NgayGiao date,
	NgayThanhToan date,
	primary key (Mahd)
)
alter table Hoadon
add constraint fk_Hoadon_Khachhang foreign key (Makh) references Khachhang(Makh)
alter table Hoadon
add constraint fk_Hoadon_Nhanvien foreign key (Manv) references Nhanvien(Manv)

CREATE TABLE Chitiet
(
	Mahd nchar(40) not null,
	Masanpham int not null,
	Soluong int,
	primary key (Mahd, Masanpham)
)
alter table Chitiet
add constraint fk_Chitiet_Hoadon foreign key (Mahd) references Hoadon(Mahd)
alter table Chitiet
add constraint fk_Chitiet_Sanpham foreign key (Masanpham) references Sanpham(Masanpham)

create table ThongKeDoanhThu
(
	Ngay Date,
	TongTien float,
	primary key (Ngay)
)

insert into Khachhang values (N'Huỳnh Kiến Phúc', '05/29/2001', '1234567890', N'Nam', 'huynhphuc@gmail.com', N'Đà Nẵng', 'huynhphuc', '123', 'True');
insert into Khachhang values (N'Nguyễn Văn Sơn', '05/29/2001', '1234567891', N'Nam', 'vanson@gmail.com', N'Hà Nội', 'vanson', '123', 'True');
insert into Khachhang values (N'Huỳnh Thị Thơ', '02/19/1998', '1234567892', N'Nữ', 'thohuynh@gmail.com', N'Huế', 'thohuynh', '123', 'False');
insert into Khachhang values (N'Nguyễn Thị Thanh Thúy', '10/22/2000', '1234567893', N'Nữ', 'thanhthuy@gmail.com', N'TP.HCM', 'thanhthuy', '123', 'True');
insert into Khachhang values (N'Tạ Tường Vân', '06/12/1999', '1234567894', N'Nữ', 'tuongvan@gmail.com', N'Bến Tre', 'tuongvan', '123', 'True');

insert into Nhanvien values (N'Huỳnh Kiến Phúc', '09/20/2000', N'Nam', 'phuc@gmail.com', '1234567890', N'Hải Phòng', 'kienphuc', '123', 'Employee');
insert into Nhanvien values (N'Lê Võ Tuyết Vy', '09/20/2000', N'Nữ', 'vy@gmail.com', '1234567891', N'TP.HCM', 'tuyetvy', '123', 'Employee');
insert into Nhanvien values (N'Nguyễn Minh Hải', '09/20/2000', N'Nam', 'hai@gmail.com', '1234567892', N'Vũng Tàu', 'minhhai', '123', 'Employee');
insert into Nhanvien values (N'Nguyễn Hải', '09/20/2000', N'Nam', 'nguyenhai@gmail.com', '1234567893', N'Hà Nội', 'nguyenhai', '123', 'Employee');
insert into Nhanvien values (N'Nguyễn Lê Phước Hậu', '09/20/2000', N'Nam', 'hau@gmail.com', '1234567894', N'Huế', 'phuochau', '123', 'Employee');
insert into Nhanvien values (N'Lê Hữu Phong', '09/20/2000', N'Nam', 'phong@gmail.com', '1234567895', N'Nam Định', 'huuphong', '123', 'Employee');

insert into Loaisanpham values (N'Áo khoác nam');
insert into Loaisanpham values (N'Áo khoác nữ');
insert into Loaisanpham values (N'Áo thun nam');
insert into Loaisanpham values (N'Áo sơ mi nam');
insert into Loaisanpham values (N'Quần short nam');
insert into Loaisanpham values (N'Quần dài nam');
insert into Loaisanpham values (N'Áo thun nữ');
insert into Loaisanpham values (N'Áo sơ mi nữ');
insert into Loaisanpham values (N'Quần short nữ');
insert into Loaisanpham values (N'Quần dài nữ');
insert into Loaisanpham values (N'Chân váy');
insert into Loaisanpham values (N'Đầm nữ');
insert into Loaisanpham values (N'Yếm');
insert into Loaisanpham values (N'Balo');
insert into Loaisanpham values (N'Túi xách');
insert into Loaisanpham values (N'Nón');
insert into Loaisanpham values (N'Dây nịt');

insert into Nhasanxuat values (N'YODY', N'Việt Nam'); --1
insert into Nhasanxuat values (N'Everest', N'Việt Nam'); --2
insert into Nhasanxuat values (N'Biluxury', N'Việt Nam'); --3
insert into Nhasanxuat values (N'GOKING', N'Việt Nam'); --4
insert into Nhasanxuat values (N'OEM', N'Việt Nam'); --5
insert into Nhasanxuat values (N'Chandi', N'Việt Nam'); --6
insert into Nhasanxuat values (N'iBasic', N'Việt Nam'); --7
insert into Nhasanxuat values (N'zakomi', N'Việt Nam'); --8

--Áo khoác nam
insert into Sanpham values (N'Áo Khoác Nam Vải Gió 5S', 1, 1, 'sanpham1.png', 239000, 100);
insert into Sanpham values (N'Áo khoác dù thoáng mát nam trơn LAVIC vải dù thoáng mát LV2019', 1, 3, 'sanpham2.png', 179000, 100);
insert into Sanpham values (N'Áo Khoác Nam Big Size Áo Khoác Kaki', 1, 6, 'sanpham3.png', 161000, 100);
insert into Sanpham values (N'Áo khoác kaki nam Hahaman thời trang cao cấp nhiều màu', 1, 7, 'sanpham4.png', 164000, 100);
insert into Sanpham values (N'Áo khoác nam JJ07', 1, 3, 'sanpham5.png', 89000, 100);
--Áo khoác nữ
insert into Sanpham values (N'Áo khoác kaki nữ form dài phong cách Hàn', 2, 1, 'sanpham6.png', 159000, 100);
insert into Sanpham values (N'Áo Khoác nữ King168', 2, 1, 'sanpham7.png', 149000, 100);
insert into Sanpham values (N'ÁO KHOÁC KAKI NỮ FORM DÀI', 2, 1, 'sanpham8.png', 117000, 100);
insert into Sanpham values (N'ÁO KHOÁC GIÓ NỮ FORM RỘNG CÁ TÍNH', 2, 1, 'sanpham9.png', 79000, 100);
insert into Sanpham values (N'ÁO KHOÁC NỮ KAKI 2 LỚP', 2, 1, 'sanpham10.png', 112000, 100);
--Áo thun nam
insert into Sanpham values (N'Áo thun nam ngắn tay có cổ ARISTINO', 3, 4, 'sanpham11.png', 239000, 100);
insert into Sanpham values (N'Aó Thun Nam SITAKI Có Cổ Thêu Logo ATN02', 3, 4, 'sanpham12.png', 95000, 100);
insert into Sanpham values (N'Áo Thun Nam Form Rộng HSANGHIU', 3, 4, 'sanpham13.png', 69000, 100);
insert into Sanpham values (N'Áo polo nam trơn cổ bẻ', 3, 4, 'sanpham14.png', 79000, 100);
insert into Sanpham values (N'Áo phông nam YODY', 3, 4, 'sanpham15.png', 139000, 100);
--Áo sơ mi nam
insert into Sanpham values (N'Áo Sơ Mi Nam Ngắn Tay Hoạ Tiết', 4, 2, 'sanpham16.png', 222000, 100);
insert into Sanpham values (N'Áo sơ mi nam trơn tay dài cao cấp Lados', 4, 2, 'sanpham17.png', 101000, 100);
insert into Sanpham values (N'Áo Sơ Mi Nam KOJIBA Dài Tay Công Sở', 4, 2, 'sanpham18.png', 73000, 100);
insert into Sanpham values (N'Áo Sơ Mi Nam Kẻ Caro Cổ Bẻ Dài Tay Phong Cách Hàn Quốc', 4, 2, 'sanpham19.png', 89000, 100);
insert into Sanpham values (N'Áo Sơ Mi Nam Cổ Tàu Dài Tay', 4, 2, 'sanpham20.png', 81000, 100);
--Quần short nam
insert into Sanpham values (N'Quần đùi short gió nam thể thao Basic', 5, 5, 'sanpham21.png', 139000, 100);
insert into Sanpham values (N'Quần Đùi Nam Chất Vải Cotton Thoáng Mát', 5, 5, 'sanpham22.png', 51000, 100);
insert into Sanpham values (N'Quần Short Nam Chất Gió Co Giãn Siêu Nhẹ', 5, 5, 'sanpham23.png', 50000, 100);
insert into Sanpham values (N'Quần Short Nam', 5, 5, 'sanpham24.png', 75000, 100);
insert into Sanpham values (N'Quần short nam mã TT12', 5, 5, 'sanpham25.png', 74000, 100);
--Quần dài nam
insert into Sanpham values (N'Quần âu nam Biluxury', 6, 7, 'sanpham26.png', 429000, 100);
insert into Sanpham values (N'Quần jogger thể thao nam', 6, 7, 'sanpham27.png', 56000, 100);
insert into Sanpham values (N'Quần Jogger Nam Kaki', 6, 7, 'sanpham28.png', 129000, 100);
insert into Sanpham values (N'quần nam dài chất đũi mềm mại', 6, 7, 'sanpham29.png', 64000, 100);
insert into Sanpham values (N'Quần Jogger kaki nam basic', 6, 7, 'sanpham30.png', 299000, 100);
--Áo thun nữ
insert into Sanpham values (N'Áo Thun Nữ Form Rộng', 7, 7, 'sanpham31.png', 200000, 100);
insert into Sanpham values (N'Áo Thun nữ Họa Tiết', 7, 7, 'sanpham32.png', 199000, 100);
insert into Sanpham values (N'Áo phông nữ đơn giản', 7, 7, 'sanpham33.png', 99000, 100);
insert into Sanpham values (N'Áo Thun Nữ Cổ Tròn Form Body Hàn Quốc', 7, 7, 'sanpham34.png', 79000, 100);
insert into Sanpham values (N'Áo thun UNISEX nữ', 7, 7, 'sanpham35.png', 89000, 100);
--Áo sơ mi nữ
insert into Sanpham values (N'Áo sơ mi nữ công sở thời trang SURI', 8, 7, 'sanpham36.png', 89000, 100);
insert into Sanpham values (N'Áo sơ mi nữ GUMAC AC03068 tay ngắn cánh dơi', 8, 7, 'sanpham37.png', 179000, 100);
insert into Sanpham values (N'Áo sơ mi nữ cổ đức form rộng', 8, 7, 'sanpham38.png', 170000, 100);
insert into Sanpham values (N'Áo sơ mi nữ kiểu công sở', 8, 7, 'sanpham39.png', 161000, 100);
insert into Sanpham values (N'Áo Sơ Mi Nữ Áo Nữ Áo Kiểu Phối Ren', 8, 7, 'sanpham40.png', 127000, 100);
--Quần short nữ
insert into Sanpham values (N'Quần đùi nữ short đũi thêu cao cấp', 9, 3, 'sanpham41.png', 37000, 100);
insert into Sanpham values (N'Quần short nữ vải Thái', 9, 3, 'sanpham42.png', 57000, 100);
insert into Sanpham values (N'quần đùi nữ ️ chất đũi Thái', 9, 3, 'sanpham43.png', 40000, 100);
insert into Sanpham values (N'Quần short nữ nhung tăm', 9, 3, 'sanpham44.png', 69000, 100);
insert into Sanpham values (N'Quần short thun Unisex', 9, 3, 'sanpham45.png', 69000, 100);
--Quần dài nữ
insert into Sanpham values (N'Quần Jogger Nữ Dài Ống Rộng', 10, 3, 'sanpham46.png', 39000, 100);
insert into Sanpham values (N'quần nữ ống suông dáng dài kaki', 10, 4, 'sanpham47.png', 86000, 100);
insert into Sanpham values (N'Quần Kẻ Nữ Cạp Chun Caro', 10, 5, 'sanpham48.png', 65000, 100);
insert into Sanpham values (N'quần ống rộng nữ', 10, 7, 'sanpham49.png', 85000, 100);
insert into Sanpham values (N'quần ống rộng nữ cạp chun chất da cá', 10, 1, 'sanpham50.png', 65000, 100);
--Chân váy
insert into Sanpham values (N'Chân váy chữ A', 11, 1, 'sanpham51.png', 65000, 100);
insert into Sanpham values (N'Chân váy GUMAC', 11, 3, 'sanpham52.png', 179000, 100);
insert into Sanpham values (N'chân váy nữ có túi kiểu hàn', 11, 2, 'sanpham53.png', 59000, 100);
insert into Sanpham values (N'chân váy công sở dáng dài xếp ly đính khuy', 11, 5, 'sanpham54.png', 385000, 100);
insert into Sanpham values (N'Chân Váy Tennis', 11, 7, 'sanpham55.png', 49000, 100);
--Đầm nữ
insert into Sanpham values (N'Đầm nữ GUMAC', 12, 7, 'sanpham56.png', 480000, 100);
insert into Sanpham values (N'ĐẦM XÒE HOA XANH CỔ SEN TRẮNG', 12, 5, 'sanpham57.png', 210000, 100);
insert into Sanpham values (N'Đầm cổ tròn xếp li', 12, 2, 'sanpham58.png', 49000, 100);
insert into Sanpham values (N'Đầm dáng xòe GUMAC', 12, 1, 'sanpham59.png', 520000, 100);
insert into Sanpham values (N'Đầm nữ GUMAC', 12, 4, 'sanpham60.png', 495000, 100);
--Yếm
insert into Sanpham values (N'Yếm jean dài nữ dáng baggy', 13, 4, 'sanpham61.png', 139000, 100);
insert into Sanpham values (N'Quần Yếm Jean Nữ Couple Tina', 13, 4, 'sanpham62.png', 139000, 100);
insert into Sanpham values (N'QUẦN YẾM JEAN SHORT NỮ', 13, 5, 'sanpham63.png', 89000, 100);
insert into Sanpham values (N'Set Yếm Nữ Dài Tay', 13, 6, 'sanpham64.png', 95000, 100);
insert into Sanpham values (N'Set Yếm Kaki Kèm Áo Tay Bồng', 13, 2, 'sanpham65.png', 89000, 100);
--Balo
insert into Sanpham values (N'Balo da cao cấp PU YME', 14, 3, 'sanpham66.png', 399000, 100);
insert into Sanpham values (N'Balo GUBAG thời trang công sở', 14, 3, 'sanpham67.png', 285000, 100);
insert into Sanpham values (N'Balo trơn Unisex', 14, 3, 'sanpham68.png', 67000, 100);
insert into Sanpham values (N'Balo nữ thời trang YUUMY', 14, 3, 'sanpham69.png', 189000, 100);
insert into Sanpham values (N'Balo CAMELIA BRAND Global Backpack', 14, 3, 'sanpham70.png', 450000, 100);
--Túi xách
insert into Sanpham values (N'Túi Xách Nữ Đẹp Đeo Chéo Thời Trang NAHA', 15, 3, 'sanpham71.png', 390000, 100);
insert into Sanpham values (N'Túi xách nữ công sở dáng đứng', 15, 3, 'sanpham72.png', 269000, 100);
insert into Sanpham values (N'Túi đeo chéo nữ YUUMY', 15, 3, 'sanpham73.png', 149000, 100);
insert into Sanpham values (N'Túi đeo chéo da nữ khóa nhấn Yuumy', 15, 3, 'sanpham74.png', 319000, 100);
insert into Sanpham values (N'Túi xách da trơn đeo chéo nữ', 15, 3, 'sanpham75.png', 65000, 100);
--Nón
insert into Sanpham values (N'Mũ tai bèo vành rộng nam', 16, 5, 'sanpham76.png', 55000, 100);
insert into Sanpham values (N'MŨ PHỚT CÓI GIẤY NÓN CÓI PANAMA', 16, 5, 'sanpham77.png', 139000, 100);
insert into Sanpham values (N'Mũ Bucket Its So Nice', 16, 5, 'sanpham78.png', 32000, 100);
insert into Sanpham values (N'Mũ lưỡi trai, nón kết thêu chữ M', 16, 5, 'sanpham79.png', 48000, 100);
insert into Sanpham values (N'Mũ lưỡi trai nam nữ thêu logo puma', 16, 5, 'sanpham80.png', 115000, 100);
--Dây nịt
insert into Sanpham values (N'Thắt lưng da nam cao cấp', 17, 5, 'sanpham81.png', 295000, 100);
insert into Sanpham values (N'Thắt lưng nam PAGINI DL07 khóa tự động', 17, 5, 'sanpham82.png', 79000, 100);
insert into Sanpham values (N'Thắt Lưng Dây Nịt Nam Da Bò', 17, 5, 'sanpham83.png', 192000, 100);
insert into Sanpham values (N'Thắt Lưng Nữ - Dây Nịt Nữ Da', 17, 5, 'sanpham84.png', 192000, 100);
insert into Sanpham values (N'Thắt lưng dây nịt nữ Nutushop', 17, 5, 'sanpham85.png', 154000, 100);

insert into Chitietsanpham values (1, N'- Chất liệu: 100% polyester
- Màu sắc: Đen, tím than tối, tím than sáng, ghi, xanh đá, xanh cổ vịt, ghi sáng
- Phom dáng:Slimfit hơi ôm
- Size: S-M-L-XL-2XL
- Xuất xứ: Việt Nam
Tính năng nổi bật:
-Áo gió 2 lớp nam 5S có phom Slim Fit vừa người, cử động thoải mái.
-Bo chun tay, gấu áo.
- Áo có mũ khóa rời tiện lợi . Có túi áo trong');
insert into Chitietsanpham values (2, N'Chất liệu: dù cao cấp, chất vải vừa vặn, cảm giác vô cùng ấm áp vào mùa đông mà vẫn mát mẻ vào mùa hè
- Hàng còn nguyên tem mác, cực sang chảnh (xem video trên ảnh sản phẩm).
- Khách hàng phối Jeans, Kaki, Short đều đẹp. Mặc dạo phố, du lịch hay đến các buổi tiệc đều mang đến sự tự tin đẳng cấp dành cho khách hàng.');
insert into Chitietsanpham values (3, N'Áo Khoác Khaki Phối Màu Nón Liền KATUSCO - D2039 với điểm nhấn phối màu trẻ trung tăng sự thu hút cho người mặc. 
Áo được sản xuất từ chất khaki lót dù dày dặn, vừa tạo sự thông thoáng cho người mặc, 
vừa tăng độ bền cho sản phẩm. Áo Khoác Khaki D2039 sẽ là item không thể thiếu cho các chàng trai yêu thích phong cách hàn quốc.');
insert into Chitietsanpham values (4, N'Áo khoác kaki nam thời trang
Thiết kế đơn giản với cổ bẻ; tay dài nút cài , 2 túi hong và trong , 2 túi ngực· chất liệu : kaki dầy
Kiểu dáng Trang nhã dễ dàng phối hợp cùng các trang phục khác như áo thun; áo sơ mi·
Với chất liệu kaki dầy, đường may tinh tế chắc chắn , kiểu dáng chuẩn phù hợp cho nhiều sự lựa chọn.
Màu sắc kaki cơ bản không phai, sản phẩm được phân phối độc quyền ở các kênh 
Màu sắc : 3 màu ( đen , xanh đen , vàng)
Size: XL: 55 - 62kg
Size: XXL: 63 - 70kg ,
Size: XXXL: 71 - 78kg');
insert into Chitietsanpham values (5, N'Chất liệu dù 2 lớp 
Bảo quản: Khô ráo tránh nơi ẩm ướt
Giặt: Chất liệu bền đẹp thoải mái giặc máy
- Kích cỡ áo dáng chuẩn quốc tế có 3SZ ( TỪ 45-78KG )
- Màu sắc đa dạng, thời trang
- Tay áo 2 lớp chùm toàn bộ bàn tay và có móc tay
- Cổ áo chùm toàn bộ cổ và gáy (Rất tiện dụng ngay cả khi ko sử dụng mũ)
- Áo có mũ che kín đầu, bảo vệ tối đa ánh nắng chiếu trực tiếp (Loại có mũ)
- Thân áo kéo khoá nhanh chóng (Loại có mũ kèm theo túi rất tiện dụng)
- Nó chỉ như chiếc áo thu của bạn và có thể mặc được vài mùa
-Bảo vệ sức khoẻ Cho bạn làn da tránh khỏi tia UV trong nắng hè oi bức.
-Có thể mặc đi làm, đi chơi, đi phượt, dã ngoạất tiện lợi
Áo khoác chống nắng với chất liệu vải dù thoải mái vận động nhưng vẫn thoáng mát. Cực kỳ phù hợp khi đi đường dài.
Lớp vải bên ngoài mịn mát bảo vệ tốt khỏi gió nắng và bụi.
Lớp trong mềm mại không kích ứng da.
Thiết kế 2 lớp đảm báo bảo vệ tối đa khỏi các tác nhân gây hại khi đi đường.');

insert into Chitietsanpham values (6, N'MÀU SĂC TRẺ TRUNG , DỄ THƯƠNG VÔ CÙNG 
CHẤT KAKI MỀM MẠI , MÀU SẮC BẮT MẮT 
KÍCH THƯỚC ÁO: RỘNG 112 CM, DÀI 66 CM 
FREE SIZE < 57KG ');
insert into Chitietsanpham values (7, N'- Thiết kế áo khoác nữ 2 lớp 
vừa có tác dụng chống nắng nhưng không hầm bí vẫn đảm bảo thoáng mát khi mặt.
- Chất liệu: thun cao cấp mềm mại thoải mái, nhưng cũng rất chắc chắn và bền bỉ đảm bảo cho sự vận động
- Đường may cẩn thận, tỉ mỉ nên bạn hoàn toàn an tâm trong từng hoạt động.
- Tình Trạng SP áo khoác nữ: SP mới, còn hàng
- Mặc mát và thoải mái');
insert into Chitietsanpham values (8, N'chất liệu kaki mềm mịn, mang lại cảm giác thoải mái và tự tin khi mặc.
Thiết kế theo phong cách trẻ trung và năng động cho bạn nam diện vào nhiều dịp khác nhau.
Form áo vừa vặn giúp lên dáng chuẩn, làm toát lên vẻ nam tính, sang trọng.
Màu sắc trung tính cho bạn nam dễ dàng phối cùng nhiều trang phục và phụ kiện khác nhau.
Kiểu dáng trẻ trung, cảm giác thoải mái Đường may sắc sảo tinh tế');
insert into Chitietsanpham values (9,N'Áo khoác nữ form rộng
Chất liệu : gió 2 lớp
Màu sắc như hình
Size : free size form rộng
Xưởng nhận ship hàng toàn quốc');
insert into Chitietsanpham values (10,N'chất liệu kaki mềm mịn, mang lại cảm giác thoải mái và tự tin khi mặc.
Thiết kế theo phong cách trẻ trung và năng động cho bạn nam diện vào nhiều dịp khác nhau.
Form áo vừa vặn giúp lên dáng chuẩn, làm toát lên vẻ nam tính, sang trọng.
Màu sắc trung tính cho bạn nam dễ dàng phối cùng nhiều trang phục và phụ kiện khác nhau.
Kiểu dáng trẻ trung, cảm giác thoải mái Đường may sắc sảo tinh tế');
--Áo thun nam
insert into Chitietsanpham values (11,N'- Áo polo phom dáng Slim Fit ôm nhẹ vừa vặn mà vẫn thoải mái vận động.
- Thiết kế basic với cổ dệt chỉn chu. Áo in hình Aristino phối vải khác màu ở phần nách trái tạo điểm nhấn ấn tượng. 
Màu sắc nam tính mang đến nhiều lựa chọn trang phục.
- Chất liệu Cotton giúp áo mềm nhẹ, thấm hút tốt, thoáng khí dù ở mùa nào trong năm, đồng thời vẫn giữ được độ đứng dáng vừa đủ. 
Kết hợp Polyester giúp áo siêu mỏng nhẹ, bề mặt vải trơn bóng, màu sắc sắc nét và bền màu qua quá trình sử dụng. 
Áo có độ co giãn vừa phải nhờ kết hợp sợi Spandex.');
insert into Chitietsanpham values (12,N'Những chiếc áo thun luôn là sự lựa chọn hàng đầu đối với hầu hết mọi người bởi sự  tiện lợi 
và tính thời trang của nó. Áo thun thêu logo được xem là chuẩn mực cho dòng áo ngắn tay có cổ.
Áo Thun Nam thêu logo Thời Trang với kiểu dáng thiết kế đơn giản, không cầu kì, dễ dàng để bạn phối đồ trong nhiều hoàn cảnh.
Logo thêu tỉ mỉ, tinh tế, bền đẹp.
- Chất liệu: Thun cá sấu co dãn, thấm hút mồ hôi cực tốt.
- Màu sắc: Xanh đen, Kem, Trắng, Đen, Xanh biển
- Kích cỡ: M (50-57 Kg), L (57-65 Kg), XL (65-75 Kg)');
insert into Chitietsanpham values (13,N'- Chất liệu : cotton mềm mịn, co giãn tốt, mát tay, không mỏng, 
không xù lông, thấm hút mồ hôi, mềm mại cho làn da mua là nghiện
- Màu sắc : Nhiều màu
- Style : Korea');
insert into Chitietsanpham values (14,N'Áo polo cao cấp được may gia công tỉ mỉ từ 100% 
vải cotton cao cấp được xử lý bằng công nghệ Coolmate pha Spandex mềm mát, thoáng khí, thấm hút mồ hôi tốt, 
co giãn nhẹ nhàng, tạo cảm giác thoải mái trong mọi hoạt động.Áo thun nam tay ngắn có thiết kế kiểu cơ bản với dáng suông 
nhưng vẫn đủ tinh tế, thanh lịch và khỏe khoắn. 6 màu sắc trẻ trung,thời thượng, dễ dàng phối cùng quần jeans hoặc shorts, 
giày thể thao hoặc giày lười, diện đi làm hay đi chơi, gặp gỡ bạn bè đều phù hợp:
Chất liệu: 100% Cotton
Đường may tinh tế, tỉ mỉ trong từng chi tiết
Phong cách lịch lãm
Chất lượng sản phẩm tốt, giá cả hợp lý');
insert into Chitietsanpham values (15,N'- Hàng chuẩn chính hãng tem mác của YODY OFFICIAL STORE
- Chất vải cotton mắt chim co giãn, đẹp, bền, không bai, không xù, không bám dính
- Đường may tinh tế, chỉnh chu, khéo léo');
--Áo sơ mi nam
insert into Chitietsanpham values (16,N'- Màu sắc: Hoa nâu
- Chất vải: Cotton
- Form dáng: Regular
- Size: M L XL XXL
Vải nhẹ , mát , thấm hút tốt , in trong công đoạn sản xuất vải, đã xử lí co rút');
insert into Chitietsanpham values (17,N'Chất liệu: vải kate lụa mịn mềm, thấm hút mồ hôi tốt.
Co giãn nhẹ, mặc cực thoải mái, ít nhăn
Chất vải đẹp, không xù lông, không phai màu
Đường may cực tỉ mỉ cực đẹp
Có thể mặc đi làm, đi chơi, dễ phối đồ, không kén người mặc
Kiểu dáng: Thiết kế theo form rộng vừa,đơn giản , dễ mặc ..
Tôn lên được sự trẻ trung năng động cho các bạn nam, kèm vào đó là sự hoạt động thoải mái khi mặc sản phẩm.');
insert into Chitietsanpham values (18,N'Áo Sơ Mi Nam Dài Tay KOJIBA  giúp bạn nam trông lịch lãm 
và sang trọng hơn với thiết kế sang trọng, gia công sắc sảo.
Thích hợp mặc trong nhiều môi trường khác nhau như công sở, tiệc, event, du lị
Chất liệu 80% Cotton 20% Polyester.
Được sử dụng nhiều nhất trên thị trường.
Thiết kế chi tiết, tỉ mỉ từng chi tiết dù là nhỏ.
Form áo sơ mi Regular Fit, dáng ôm.
Thiết kế cổ bẻ, áo sơ mi dài tay.
Màu sắc: Trắng, Đen, Xanh nhạt, Xanh đậm và Đỏ đô');
insert into Chitietsanpham values (19,N'Áo Sơ Mi Nam Caro Dài Tay  - Trắng 
giúp bạn nam trông lịch lãm và sang trọng hơn với thiết kế sang trọng, gia công sắc sảo.
Thích hợp mặc trong nhiều môi trường khác nhau như công sở, tiệc, event, du lị
Chất liệu 80% Cotton 20% Polyester.
Được sử dụng nhiều nhất trên thị trường.
Thiết kế chi tiết, tỉ mỉ từng chi tiết dù là nhỏ.
Form áo sơ mi Regular Fit, dáng ôm.
Thiết kế cổ bẻ, áo sơ mi dài tay');
insert into Chitietsanpham values (20,N'Áo Sơ Mi Cổ Tàu KOJIBA Dài Tay có thiết kế kiểu dáng hiện đại, 
form body Hàn Quốc ôm trọn bờ vai cực kỳ trẻ trung và phong cách, tôn lên vóc dáng cho người mặc. 
Cổ áo kiểu Tàu vừa mang tính thời trang vừa giúp phần da cổ tránh bị trầy xước. 
Áo tay dài thể hiện nét cá tính và lịch lãm cho các chàng trai khi diện áo đi tiệc, đi làm, …');
--Quần short nam
insert into Chitietsanpham values (21,N'- Kiểu dáng thể thao với độ dài vừa phải phù hợp 
với mọi hoạt động thể thao hoặc có thể mặc nhà như 1 chiếc quần ngủ đơn giản.
- Phần túi có khoá kéo để đựng đồ cá nhân tiện lợi mà không bị rơi.
- Phần chun đai quần co dãn tối đa, chống bai dão, kết hợp dây chun kéo phía trong 
giúp người mặc tinh chỉnh phù hợp với vòng bụng thêm sự chắc chắn.
- Ống quần có đường xẻ 3cm tạo sự thoải mái khi hoạt động thể thao.
- Logo thương hiệu in phản quang tạo điểm nhấn, chống bong tróc khi giặt.
- Đường may chắc chắn giúp quần không bị bung chỉ khi hoạt động mạnh.');
insert into Chitietsanpham values (22,N'Quần đùi nam được sản xuất bởi chất li-nen cotton, 
shop thiết kế với 5 màu đa dạng cho anh em lựa chọn : Trắng,đen,xanh lơ,vàng kem,hồng nhạt
Chất liệu : Linen-cotton
Quần đùi được thiết kế cho anh em từ 45-85kg
Chi tiết size quần short nam :
size M: 45-54kg
size L : 55-64kg
size XL : 65-74kg
size XXL :75-85kg');
insert into Chitietsanpham values (23,N'Thông tin chi tiết sản phẩm quần short nam chất gió :
Quần đùi nam được sản xuất bởi chất giãn gió ,shop thiết kế với 4 màu đa dạng cho anh em lựa chọn : đen,xám,xanh than,xanh
Chất liệu : gió giãn
Quần đùi được thiết kế cho anh em từ 45-85kg
Chi tiết size quần short nam:
size M: 45-54kg
size L : 55-64kg
size XL : 65-74kg
size XXL :75-85kg');
insert into Chitietsanpham values (24,N'CHI TIẾT:
- Quần gió thể thao 5S với thiết kế mạnh mẽ, khẻ khoắn trên nền chất liệu poly cao cấp, mềm mịn, 
thoáng mát luôn mang đến cảm giác dễ chịu cho các Anh trai.
- Đường may rất kỹ, Sắc sảo, đẹp mắt, tỉ mỉ trong từng chi tiết đạt tiêu chuẩn xuất khẩu, thể hiện được đẳng cấp của sản phẩm. 
- Quần gió 5S khá dễ dàng trong việc kết hợp với các loại áo thun, áo Phông để có được một sét đồ thể thao hoàn hảo. 
- Những Anh hay chơi thể dục thể thao, hay đi du lịch … thì không thể thiếu được những dòng quần gió truyền thống này.
CHẤT LIỆU:
- 95% Polyester + 5% spandex
- Chất liệu vải cao cấp: thấm hút mồ hôi và co giãn vừa phải, không bai không xù sau một thời gian dài sử dụng
MÀU SẮC: Xanh Biển Đậm, Đen
Size: 28/S - 29/M - 30/L - 31/XL - 32/2XL - 33/3XL');
insert into Chitietsanpham values (25,N'Trẻ trung năng động, cá tính
Phong cách: Quần Short nam thể thao chất thun lạnh thiết kế thời trang, hiện đại, năng động
Thiết kế trang nhã, có thể sử dụng đi trong nhiều bối cảnh khác nhau
Đường May kỹ, tỉ mỉ từng chi tiết giúp chiếc Quần thể thao thêm sang trọng.
Kiểu dáng thể thao, năng động, hiện đại phù hợp mặc: Đi học, đi thể thao, đi dạo, đi chơi,du lịch, tắm biển… tạo ấn tượng tốt
Chất liệu: Vải thun lạnh co giãn mềm mại, dày dặn, phù hợp thời tiết mùa hè nóng nực
Xuất Xứ: Việt Nam, Nguồn gốc rõ ràng');
--Quần dài nam
insert into Chitietsanpham values (26,N'- Form Slimfit: dáng quần ôm vừa, tôn dáng người mặc
- Thiết kế cơ bản gồm 2 túi xẻ 2 bên thân trước, 2 túi sau cài khuy tiện dụng. Phần cạp có cúc cài trước, 
bên trong đầu - cạp có móc cài ẩn giúp định vị phần cạp chắc chắn hơn, tránh ảnh hưởng đến phom dáng sau thời gian dài sử dụng
- Thuê B bên trái túi quần trước khẳng định thương hiệu
Thành phần
- 70% Polyester: bền màu, dễ làm sạch, chống nhăn nhàu, hạn chế hấp thụ chất bẩn, tiết kiệm thời gian là ủi
- 28% Rayon: thấm hút mồ hôi, tạo cảm giác thoải mái, dễ chịu
- 2% Spandex: co giãn 2 chiều giúp cử động thoải mái nhưng vẫn giữ được phom dáng ban đầu');
insert into Chitietsanpham values (27,N'✧ Kiểu dáng thể thao, trẻ trung màu sắc đẹp dễ mix đồ với giày, áo ba lỗ, áo thun, mũ lưỡi trai,
✧ Chất gió dù đẹp, mềm mịn, thấm hút mồ hôi tốt tạo cảm giác thoải mái dễ chịu khi mặc
✧ Đường chỉ may tỉ mỉ, chắc chắn, không bai, không xù, không bám dính
✧ Bền màu vĩnh viễn, an toàn tuyệt đối với người mặc
✧ Phù hợp mặc đi chơi, đi dạo, chơi thể thao, tập thể dục,
Hướng Dẫn Chọn Size
✦ Size M từ 45Kg đến 57Kg
✦ Size L từ 58Kg đến 65Kg
✦ Size XL từ 66Kg đến 72Kg
✦ Size XXL từ 73Kg đến 80Kg');
insert into Chitietsanpham values (28,N'Tên Sản phẩm: Quần Jogger Nam Kaki Thời Trang 4 Màu Phong Cách Thể Thao VICERO
Chất liệu: vải kaki
Màu sắc: Đen, xanh than, xanh bộ đội, vàng be
Thương hiệu: VICERO
Xuất xứ: Việt Nam
Chất vải kaki mềm mịn, đẹp, bền, không bai, không xù, không bám dính
Đường may tinh tế, chỉn chu, khéo léo
Màu sắc đa dạng, trẻ trung
Chất lượng sản phẩm tốt
Bảng Size:
Size M-29:cao 1m6-1m65,nặng 50-57kg
Size L-30:Cao 1m66-1m70,nặng 57-61kg
Size XL-31:Cao 1m70-1m74,nặng 62-69kg
Size XXL-32:Cao 1m74-1m77,nặng 70-75kg');
insert into Chitietsanpham values (29,N'Quần đũi chuẩn đẹp, mềm, mặc lên dáng xuông phong cách nhẹ nhàng 
mang lại cảm giác mặc mà như ko mặc j cực kỳ dễ chịu và thoải mái.
Chất vải dày dặn, đẹp y hình S
Mn vui lòng đặt hàng đúng size Shop tư vấn và inbox cho Shop chọn màu
Lưu ý: Đồ đũi khách nên giặt bằng nước lã chút xíu xà phòng hoặc ko cũng dc và phơi râm mát 
tránh ánh nắng to để cho quần dc bền màu nhé!
màu sắc: xanh than, đen, tàn, rêu
size: 2XL<60kg
3XL<65kg
4XL<70kg
5XL<75kg');
insert into Chitietsanpham values (30,N'- Chất liệu: Chất kaki dày dặn phối túi hộp - phối kéo khoá
- Đường may được gia công tỉ mỉ, chắc chắn. 4 tổng màu basic cực dễ phối đồ
- Họa tiết : Trơn.
- Màu sắc: Màu Đen / Màu Vàng Bò/ Màu Xám / Kem
BẢNG SIZE:
+ Size 29: Chiều cao: 1m50-1m68, Cân nặng: 50-55kg
+ Size 30 : Chiều cao: 1m55-1m70, Cân nặng: 56-61kg
+ Size 31: Chiều cao: 1m60-1m72, Cân nặng: 62-67kg
+ Size 32: Chiều cao: 1m60-1m72, Cân nặng: 68-73kg
+ Size 34 : Chiều cao: 1m60-1m72, Cân nặng: 74-80kg
HƯỚNG DẪN SỬ DỤNG VÀ BẢO QUẢN
- Lần đầu đem về chỉ xả nước lạnh rồi phơi khô để sợi vải và màu quần không bị xù, phai màu nhé.
- Không nên ngâm bột giặt quá lâu.
- Lộn trái Quần khi giặt và phơi.
- Không giặt máy trong 10 ngày đầu.
- Không sử dụng thuốc tẩy - hóa chất.');
--Áo thun nữ
insert into Chitietsanpham values (31,N'Không có mô tả');
insert into Chitietsanpham values (32,N'Áo thun in hình
Form rộng, tay lỡ
Chất liệu thun co giãn
Đa dạng về màu sắc
Size hỗ trợ khách từ 42-80kg');
insert into Chitietsanpham values (33,N'Form áo :  
Tay lỡ nhõ ( Loại áo tay dài tới khuỷa tay - form rộng giâu quần ) - DƯỚI 50KG VỪA
Tay lỡ UNISEX ( Loại áo tay dài tới khuỷa tay - form rộng giâu quần ) - DƯỚI 60KG VỪA
Mẫu áo thun cực kì dễ mặc - có thể mặc cùng nhiều loại trang phục khác nhau như: 
Quần Jeans, Shorts Jeans, Váy ngắn, Quần Legging thể thao,
Lên form chuẩn store siêu đẹp - trẻ trung');
insert into Chitietsanpham values (34,N'- Chất liệu : cotton mềm mịn, co giãn tốt, mát tay, không mỏng, 
không xù lông, thấm hút mồ hôi, mềm mại cho làn da mua là nghiện
- Màu sắc : Nhiều màu
- Style : Korea
HƯỚNG DẪN BẢO QUẢN:
- Nên giặt với nước ở nhiệt độ thường.
- Không nên ngâm quá lâu hoặc sử dụng các chất có tính tẩy mạnh, 
tránh chà xát bằng bàn chải - Không xoắn vắt mạnh, nên giặt bằng tay hoặc máy giặt với lực quay nhẹ');
insert into Chitietsanpham values (35,N'thun thoáng mát
đa năng
unisex nam nữ đều mặc được
chất liệu: thun
xuất xứ: việt nam
size: one size.
1 size dưới tư 39kg đến dưới 65kg
Chất liệu thun mềm mại ,với sự co giãn tốt cực thoáng mát
Thiết kế thời trang trẻ phù hợp xu hướng hiện nay
Kiểu dáng trẻ trung.Đường may tinh tế, tỉ mỹ
Áo thun được thiết kế vể đẹp trẻ trung năng động nhưng cũng đầy cá tính.
Dễ dàng phối các trang phục , đi chơi đi làm đi dạo phố cực chất.
Thích hợp cho sự kết hợp vứi quần jean, sọt,kaki,jogger!');
--Áo sơ mi nữ
insert into Chitietsanpham values (36,N'➊ GIỚI THIỆU - Áo Sơ Mi Nữ thêu hoa hồng 2 bên tay thời trang cho nữ
Chiếc áo sơ mi kiểu với thiết kế trẻ trung, năng động kiểu dáng đẹp mắt ưa nhìn chắc chắn 
sẽ làm hài lòng các nàng cá tính phong cách.
+ CHẤT LIỆU: Vải lụa
Khả năng chống nhăn
➋ KÍCH THƯỚC/ BẢNG SIZE
** Size có thể thay đổi tùy vào chiều cao mỗi người, các bạn khó chọn SIZE 
hoặc phân vân đừng ngại ngần cứ chat với Shop để tư vấn chọn size chuẩn và hướng dẫn các vấn đề khi mua hàng nhé **');
insert into Chitietsanpham values (37,N'-Mã Sản Phẩm: AC03068
-Tên Sản Phẩm: Áo sơ mi nữ GUMAC AC03068 tay ngắn cánh dơi
-Màu Sắc: TRẮNG 
-Số Đo Ngực: 92CM
-Số Đo Lai: 92CM
-Số Đo Dài Tay: 23CM (TAY DƠI)
-Số Đo Cửa Tay: 36CM
-Số Đo Dài Áo: 61CM
-Chất Liệu Vải: LINEN
-Độ Co Giãn: KHÔNG
-ÁO 1 LỚP, KHÔNG TÚI
*ÁO SƠ MI FORM CƠ BẢN, TAY LIỀN CÁNH DƠI, BẢN CỬA TAY KHOẢNG 2.8CM*');
insert into Chitietsanpham values (38,N'Áo sơ mi nữ cổ đức form rộng chất vải thô đũi LAHstore, thời trang trẻ được thiết kế thanh nhã 
với kiểu áo form rộng trẻ trung.
Áo được may từ chất liệu đũi cao cấp cho cảm giác mềm mại, thoáng mát và vô cùng dễ chịu khi mặc.
Dễ dàng bảo quản giặt ủi, chất liệu mau khô, ít nhăn, không cần ủi.
Màu sắc tươi sáng, trẻ trung, giúp phái đẹp thêm tự tin mỗi khi xuống phố.
Có thể kết hợp cùng nhiều kiểu quần, váy, giày và các phụ kiện thời trang khác, 
thích hợp diện đi chơi, đi dạo phố, đi làm hay tham gia những buổi sự kiện, họp mặt cùng bạn bè');
insert into Chitietsanpham values (39,N'-Thiết kế trẻ trung, tinh tế hợp thời trang phù hợp với nhiều lứa tuổi
-Đường may tinh tế, tỉ mỉ, chắc chắn
-Form suông rộng tạo cảm giác thoải mái khi mặc
-Chất liệu tơ nhung cao cấp, mềm mịn, mát và thấm hút mồ hôi tốt
-Kiểu dáng hiện đại, đường nét cách điệu
-Mang phong cách nữ tính, thanh lịch
Gợi ý phối đồ: Dễ dàng phối hợp cùng nhiều phụ kiện khác mang đến phong cách thời trang riêng cho bạn nữ, 
khéo léo lựa chọn trang phục cùng phụ kiện phù hợp, bạn sẽ có set đồ đẹp mắt như ý.
Bạn có thể kết hợp cùng giày sandals, giày búp bê, giày cao gót hoặc các kiểu dép khác nhau giúp bạn thêm tự tin khi ra đường.
Hướng dẫn chọn size:  
- Size S: 40-48kg - ngực áo 85cm
- Size M: 49-53kg - ngực áo 90cm
- Sie L: 54-64kg - ngực áo 95cm');
insert into Chitietsanpham values (40,N'Họa tiết tạo điểm nhấn, thể hiện gu thẩm mỹ tinh tế.
Đường may tinh xảo tạo form dáng đẹp cùng cảm giác thoải mái khi mặc.
Dễ dàng kết hợp với các trang phục và phụ kiện.');
--Quần short nữ
insert into Chitietsanpham values (41,N'- Quần short đũi nữ cạp cao co giãn thoải mái
-màu:đen-trắng
-xuất xứ:hàng việt nam xk
-thông số free sz từ 40-56 kg');
insert into Chitietsanpham values (42,N'Quần short vải thái siêu thoáng cho mùa hè, 
được sản xuất bởi thời trang cao cấp evadesign, evadesign gia nhập phân khúc bình dân nhưng chất lượng vẫn hết sức tuyệt vời
Bảng size chuẩn:
Size XS<40kg
size S: từ 40 tới 48
size M từ 49 tới 54
size L từ 55 tới 60
size XL từ 61 tới 65
XXL từ 66 tới 70');
insert into Chitietsanpham values (43,N'Quần short đùi chất đũi mát hót năm 2020
Chất liêu; đũi thô
Chất đũi cực mát mặc ở nhà hay ra đường đều xinhh.
Các tông màu em đã đánh số rồi nhé . Ai thích mặc hẳn kiểu ống rộng to thì lên 1 size giúp em , 
quần cạp chun chả lo rộng chật bụng đâu ạ
Sắm quần đũi thui các chế. Vừa mát vừa thoáng chừa chất , siêu dễ mix đồ lun nhé. Lên vs áo thun, hai dây, croptop auto xinh
Cạp chun co giãn thoải mái.
Size S, M, L,XL, 2XL
Bảng size tham khảo:
Size S<45kg
Size M<50kg
Size L<55kg
Size XL<60kg
Size 2XL<65kg
Full màu:đen,trắng,cam,nâu,tím than,hồng,rêu,tàn
Tất cả sp bên shop là mẫu mới ra nên sl có nhiều nhé các nàng');
insert into Chitietsanpham values (44,N'- Vải nhung tăm mềm nhẹ thích hợp mùa thu
- Chỉ cần mix thêm áo len , áo kiểu sơ vin, mùa lạnh thêm quần tất da chân thì quá xinh ạ
- Màu: đen, kem, nâu nhạt, nâu đậm
S eo <66cm, mông < 89cm dưới 47kg
M eo < 72cm mông < 92cm dưới 52kg
L eo <77cm mông < 95cm dưới 56kg
XL eo <88cm mông < 105cm, dưới 65kg
- Quần k kèm đai. đơn hàng từ 250k tặng đai lưng');
insert into Chitietsanpham values (45,N'Tên sản phẩm: Quần short thun unisex
Xuất xứ: Việt Nam
Chất liệu: Thun nỉ da cá DÀY MỀM MỊN MÁT không xù lông. Form chuẩn UNISEX cực đẹp.
Size M: Lưng: 66cm - Dài: 41cm - Ống quần: 27.5cm (Dưới 1m65 - 55kg)
Size L: Lưng: 73cm - Dài: 48cm - Ống quần: 31.5cm (Dưới 1m75 - 70kg)');
--Quần dài nữ
insert into Chitietsanpham values (46,N'Quần jogger chất thun dày dặn form rộng siêu xinh, thấm hút mồ hôi cực tốt. 
Hè đến chỉ có mặc croptop với jogger vừa năng động lại thoải mái thôi.
Free size dưới 68kg mặc đẹp
Hiện nay trên thị trường có rất nhiều Shop khác sử dụng hình ảnh sản phẩm của SHOP để bán các sản phẩm không đảm bảo chất lượng. 
Cùng 1 sản phẩm, cùng 1 màu, ảnh giống nhau nhưng chất lượng sản phẩm, chất lượng dịch vụ sẽ khác nhau.
Do vậy các bạn hãy CỰC KÌ cân nhắc khi mua để tránh trường hợp sản phẩm không chất lượng nhé. 
Shop tự tin là nhà bán hàng tận tâm để Quý shop gửi gắm niềm tin:
➊ 100% hình ảnh là chụp thật do shop tự chụp.
➋ Giá luôn tốt nhất, xứng tiền. Tư vấn tận tâm chi tiết nhất.');
insert into Chitietsanpham values (47,N'+ Chất vải KAKI DÀY DẶN, không xù lông.
+ Chất lượng và Mẫu mã Sản phẩm giống với hình ảnh.
+ Đường may kỹ đẹp.
+ Nam Nữ Couple đều mặc được.
+ Hàng lấy tận xưởng, không trung gian.
+ Giao hàng tận nơi.
+ Nhận hàng rồi thanh toán.
+ Vải đẹp, không co rút, mềm mịn, mặc siêu mát.
BẢNG SIZE:
(Bảng size mang tính chất tham khảo và phù hợp 80-90% sở thích các cậu ạ. Các bạn muốn chọn size phù hợp có thể inbox cho ạ)
-Size M: 45 - 55kg, 1m50 - 1m60
-Size L: 50 - 60kg, 1m60 - 1m70
-Size XL: 60 - 70kg, 1m65 - 1m75
Số đo chi tiết:
M dài 92cm, ống rộng 22cm, vòng đùi 56cm, đáy 29cm, eo thun 64 - 70cm
L dài 94cm, ống rộng 23cm, vòng đùi 58cm, đáy 30cm, eo thun 68 - 75cm
XL dài 96cm, ống rộng 24cm, vòng đùi 60cm, đáy 31cm, eo thun 72 - 80cm');
insert into Chitietsanpham values (48,N'Thiết kế nữ tính thanh lịch, cho bạn hình ảnh tươi mới đầy sức sống mỗi khi xuống phố.
Kiểu dáng tinh tế, thời trang mang lại sự trẻ trung duyên dáng cho phái đẹp.
Kết hợp với chất liệu vải mềm mại, thông thoáng đem lại cảm giác thoải mái cho người mặc.
Phù hợp với nhiều hoàn cảnh, đi làm, đi chơi, dạo phố');
insert into Chitietsanpham values (49,N'- Quần suông ống rộng sẽ giúp các nàng có 1 đôi chân siêu mẫu dài tít tắp
- Quần suông ống rộng sẽ là mẫu quần sẽ có thể giúp nàng che đi được những khuyết điểm trên cơ thể của bản thân, 
đặc biệt là về phần đùi
- Quần suông dễ phối đồ: sơmi,thun, 2 dây, croptop đều đẹp
- Quần có thể mặc đi làm (quần công sở) hoặc đi chơi đều rất đẹp cho người phụ nữ hiện đại.
- Chất Liệu Vải vitex co giãn nhẹ, mềm mịn ( Các loại sợi thành phần đảm bảo an toàn cho làn da, không gây kích ứng. 
Chất vải nhẹ, thoải mái khi vận động)
- Chất vải đảm bảo không nhăn nhàu, lên form đứng dáng
- Form Chuẩn, khoá giữa, có túi dễ mặc và tiện dụng.
Quần suông ống rộng đủ size từ S đến XL cho khách từ 43-58 kg mặc vừa
- Size S (43-47 kg), Eo ( trên rốn) 66, Mông 96, Đùi 56, Dài 95, Ống 24
- Size M (48-50 kg), Eo ( trên rốn) 69, Mông 98, Đùi 57, Dài 95, Ống 24
- Size L (51-54 kg), Eo ( trên rốn) 72, Mông 100, Đùi 58, Dài 96, Ống 24
- Size XL (55-58 kg), Eo ( trên rốn) 75 , Mông 102, Đùi 59, Dài 96, Ống 24
- Có 2 màu cơ bản: Đen và Be');
insert into Chitietsanpham values (50,N'Quần ống rộng nữ vải đũi cạp cao 2 cúc suông dài tôn dán chun sau co dãn thoải mái 
Thời trang BANAMO sớ đũi 2khuy 922
Vừa đẹp vừa tiện thì sao ko hot chứ c e nhỉ
nhất là khi Quần ống rộng nữ vải đũi cạp cao 2 cúc suông dài tôn dán chun sau co dãn thoải mái Thời trang BANAMO 
sớ đũi 2khuy 922 được làm từ chất vải đũi nhật thì hết xảy luôn rùi nè
>>>> ĐẸP + MÁT + CHUN SAU CO DÃN THOẢI MÁI
4 màu đen kem trắng nâu đều xinh. riêng màu trắng sẽ dễ bị lộ hơn nên c e cân nhắc mua thêm quần chống lộ màu trắng giúp e nhá
dài quần khoảng 95cm');
--Chân váy
insert into Chitietsanpham values (51,N'CHÂN VÁY A LÓT QUẦN
thiết kế dáng chữ A k xoè quá , mặc lên vô cùng gọn gàng - năng động - trẻ trung mà tiện lợi
nhìn ngoài là chân váy bt nhưng bên trong may 1 lớp lót là quần giúp ce vận động thoải mái , kín đáo , lịch sự
1 màu đen duy nhất cực dễ mix đồ
chất liệu chân váy ngoài đanh - mềm - mịn , quần phía trong ce thoải mái vận động nhé');
insert into Chitietsanpham values (52,N'-Mã Sản Phẩm: VC03052
-Tên Sản Phẩm: Chân váy GUMAC VC03052 dập ly
-Màu Sắc: ĐEN, NÂU
-Số Đo Eo: 63CM
-Số Đo Dài Váy: 65CM
-Thông Số Size XS
-Chất Liệu Vải: FORD
-Độ Co Giãn: KHÔNG
-CHÂN VÁY 1 LỚP, KHÔNG TÚI
*CHÂN VÁY XẾP LY CƠ BẢN, BẢN LƯNG KHOẢNG 4CM, DÂY KÉO PHÍA SAU*');
insert into Chitietsanpham values (53,N'Không có mô tả');
insert into Chitietsanpham values (54,N'chất liệu: tuyết mưa
màu sắc : đen, trắng, nâu tây
size : S<47kg
M<54kg
L<62kg
váy các b mix với áo cánh dơi, áo bánh bèo, áo thun , vest hay sơ mi đều ok hết ạ');
insert into Chitietsanpham values (55,N'Kích thước:
Vòng eo S: 64 cm, chiều dài váy: 37 cm, chu vi hông: 96 cm
Vòng eo M: 68 cm, chiều dài váy: 38 cm, chu vi hông: 100 cm
Vòng eo L: 72 cm, chiều dài váy: 39 cm, chu vi hông: 104 cm
Lưu ý:
* Vui lòng cho phép sai số 1-3cm do đo lường thủ công.
* Màu sắc sản phẩm thực có thể hơi khác so với hình ảnh do độ phân giải, độ sáng, độ tương phản của màn hình máy tính,');
--Đầm nữ
insert into Chitietsanpham values (56,N'-Mã Sản Phẩm: DC03032
-Tên Sản Phẩm: Đầm cổ V phối phụ kiện 
-Màu Sắc: ĐỎ, TÍM
-Số Đo Vai: 34CM
-Số Đo Ngực: 86CM
-Số Đo Eo: 67CM
-Số Đo Hạ V: 17.5CM
-Số Đo Ngang Cổ: 18CM
-Số Đo Dài Tay: 22CM
-Số Đo Cửa Tay: 28CM
-Số Đo Dài Đầm: 101CM
-Thông Số Size S
-Chất Liệu Vải:  COTTON CHÉO
-Độ Co Giãn: KHÔNG
-ĐẦM CÓ 1 LỚP, CÓ TÚI, ĐẦM ĐÍNH KÈM NƠ PHỤ KIỆN CÓ THỂ THÁO RỜI
*ĐẦM FORM A CƠ BẢN, CỔ V, TAY PHỒNG NGẮN, CỬA TAY XẾP LY TẠO KIỂU, ĐẦM RÃ CÚP NGỰC, RÃ EO, DÂY KÉO PHÍA SAU,*');
insert into Chitietsanpham values (57,N'Không có mô tả');
insert into Chitietsanpham values (58,N'2 màu trắng, kem
Freesize dưới 55kg
Chất liệu: chéo thái
Vòng ngực: 90cm
Vòng eo: 70cm
Chiều dài: 110cm');
insert into Chitietsanpham values (59,N'Mã Sản Phẩm: DB12010
- Tên Sản Phẩm: Đầm sọc phối nút
- Màu Sắc: XANH
- Số Đo Vai: 37CM
- Số Đo Hạ V: 15CM
- Số Đo Ngực: 85CM
- Số Đo Eo: 62CM
- Số Đo Dài Tay: 23CM
- Số Đo Cửa Tay: 24CM
- Số Đo Dài Đầm: 90CM
- Thông Số Size XS
- Chất Liệu Vải:
CHÍNH: COTTON SỌC
LÓT: THUN
- Có 1 Lớp Thân Trên
- Có 2 Lớp Thân Dưới
- Không Có Túi
*ĐẦM FORM A, CỔ V, TAY NGẮN, BẢN CỬA TAY KHOẢNG 3.8CM, XẾP LY Ở ĐỈNH VAI VÀ CỬA TAY, 
GIỮA ĐẦM CÓ ĐÍNH NÚT TẠO KIỂU, ĐẦM RÃ EO, DÂY KÉO PHÍA SAU.');
insert into Chitietsanpham values (60,N'Mã Sản Phẩm: DA856
- Màu Sắc: XANH ĐEN
- Số Đo Ngực: 85CM
- Số Đo Eo: 64CM
- Chiều Dài Đầm: 89CM
- Thông Tin Size: XS
- Số Size: XS, S, M, L
- Chất Liệu Vải: Gấm
- Đầm Có 2 Lớp
(Không giặt chung với các đồ màu khác, không ngâm quá lâu và giặt với chất tẩy mạnh)');
--Yếm
insert into Chitietsanpham values (61,N'QUẦN YẾM JEAN NỮ COUPLE TINA
Chất vải jean loại 1 dày dặn mềm mịn ko thô cứng
Size S eo dưới 91 mông dưới 100
Size M eo dưới 95 mông dưới 104
Size L eo dưới 99 mông dưới 108
KHÁCH LƯU Ý: màu sắc hàng jean thường chênh lệch 1 ít tùy điều kiện ánh sáng, 
khi chụp hàng jean khó lên đúng 100% màu (đậm hoặc nhạt hơn tí xíu xiu, ko chênh lệch nhiều đâu khách nha)');
insert into Chitietsanpham values (62,N'QUẦN YẾM JEAN NỮ COUPLE TINA
Chất vải jean loại 1 dày dặn mềm mịn ko thô cứng
Size S eo dưới 91 mông dưới 100
Size M eo dưới 95 mông dưới 104
Size L eo dưới 99 mông dưới 108
KHÁCH LƯU Ý: màu sắc hàng jean thường chênh lệch 1 ít tùy điều kiện ánh sáng, 
khi chụp hàng jean khó lên đúng 100% màu (đậm hoặc nhạt hơn tí xíu xiu, ko chênh lệch nhiều đâu khách nha)');
insert into Chitietsanpham values (63,N'Chất Liệu: Jean Dày Dặn, Mềm Mại, Thoáng Mát
Màu Sắc: Xanh
Kiểu Dáng: Thiết Kế 2 Dây Tạo Nét Đáng Yêu Cho Bạn Gái, Form Dáng Ôm Duyên Dáng, Wash Cào Cá Tính, Kết Hợp Thêu Logo Ấn Tượng, Dễ Thương, Phối Túi Tiện Lợi
Đơn Vị: Cm
Kích Thước: Size M - ( Phù Hợp Với Bạn Nữ Dưới 50kg, Chiều Cao Dưới 1,65 mét)
Size L - ( Phù Hợp Với Bạn Nữ Dưới 55kg, Chiều Cao Dưới 1,65 mét)
Size XL - ( Phù Hợp Với Bạn Nữ Dưới 60kg, Chiều Cao Dưới 1,65 mét)
Lưu Ý: Sản Phẩm Không Kèm Áo Lót Trong');
insert into Chitietsanpham values (64,N'Đây là các sản phẩm bán chạy và Hot của thời trang PONIVA.
Chất liệu vải cát hàn tự nhiên, chất dày dặn, không pha nilon; rất thông thoáng và dễ chịu, 
thấm mồ hôi cực tốt: đồ bộ quần lửng, bộ mặc nhà nữ quần lửng.
Vải co giãn tốt nên khá bền: Giặt là máy thoải mái không phai, không xù, không bong tróc … 
Thoải mái và thư giãn,hài lòng ngoài mong đợi.
Freesize cho người dưới 56kg
Xuất xứ: Việt Nam');
insert into Chitietsanpham values (65,N'Kiểu dáng: áo cổ tròn, gấu tay áo bo chun co giãn, dọc sống tay bo chun nhún cực đẹp;
yếm dáng suông , 2 dây chắc chắn. 
Set yếm ulzzang cực đẹp của nhà em luôn ạ, mua 1 đc 2 , mại zô ^^
Chất liệu: áo đũi thô mềm bay bay; yếm chất đũi thô kaki đứng dáng
Form freesize; áo ( dài 47cm, v1,2 < 94cm); yếm ( dài 88cm, v1 < 96cm, v2 < 100cm, v3< 106cm). Tầm dưới 60-65kg đổ lại mặc ok ạ
Sỉ sll ib');
--Balo
insert into Chitietsanpham values (66,N'+ Kích thước: 25cm x 20cm x 10cm
+ Balo da thời trang được may bằng da PU cao cấp, giúp cho balo trông rất sang trọng, 
balo da thời trang chống thấm nước. Và giúp cho ba lo không bám bụi, vệ sinh dễ dàng.
+ Balo da thời trang có tất cả 5 ngăn, giúp bạn xếp được nhiều đồ và gọn gàng các vị trí trong balo.
+ Khóa và tay khóa cao cấp thể hiện sự xịn xò, đặc biệt là đẹp, bền, dùng được lâu. 
Bạn không còn gặp sự cố hỏng khóa như nhiều dòng balo khác.
+ Quai đeo balo da thời trang được may bằng 2 lớp da thân chính giúp cho sự đồng bộ, đẹp và đặc biệt rất bền. 
Quai đeo có thể tăng giảm tùy theo ý muốn của bạn, và phù hợp với nhiều người.
+ Balo được may đầy đủ lót ở các ngăn.');
insert into Chitietsanpham values (67,N'Không có mô tả');
insert into Chitietsanpham values (68,N'♪ Kích thước :BALO:40X12X30 CM
♪ Thiết kế hiện đại, trẻ trung,tiện dụng,vừa đơn giản, vừa sang trọng. Sản phẩm chắc chắn');
insert into Chitietsanpham values (69,N'- Chất liệu: da tổng hợp cao cấp (mềm mại, không bong tróc, không thấm nước )
- Kích thước: dài 19.5cm x rộng 8cm x cao 22cm
- Trọng lượng: 508g
- Số ngăn: 4 ngăn ( 1 ngăn chính, 3 ngăn phụ )
- Màu sắc: Màu Hồng phấn – Màu Kem – Màu Xanh Ngọc  – Màu Đen – Màu Bò.
- Công dụng: balo phù hợp đi chơi, đi làm, đi shopping, đi du lịch.
- Đựng vừa tối đa: Balo đựng vừa sổ tay, ví tiền mini , điện thoại,… các vật dụng tùy thân cần thiết.');
insert into Chitietsanpham values (70,N'Một chiếc balo với thiết kế hiện đại mà vẫn có thể chứa vừa laptop 15,6” 
cùng với chất liệu vải Polyester Canvas cao cấp chống thấm nước có đủ làm hài lòng những tín đồ thời trang & công nghệ? ');
--Túi xách
insert into Chitietsanpham values (71,N'- Kích thước: Ngang 24cm (tính chiều ngang phần eo của túi ) x Cao 17cm x Rộng 10cm
- Khối lượng sản phẩm: 0.6kg
- Chất liệu da tổng hợp mới siêu bền nên chất lượng đồng đều và ổn định
- Thiết kế hiện đại và thời trang        
- Kiểu dáng phong cách
- Đường may tỉ mỉ chắc chắn
- Dễ dàng phối đồ
- Bảo quản đơn giản');
insert into Chitietsanpham values (72,N'- Chất liệu: Da tổng hợp cao cấp
- Kích thước: Dài 29cm x rộng 9.5cm x Cao 36cm
- Số ngăn: 3 ngăn ( 1 ngăn chính + 2 ngăn phụ )
- Công dụng: đựng sổ tay, điện thoại, ví tiền 
- Trọng lượng: 816 grams
- Xuất xứ: Việt Nam
(*) Chất liệu da tổng hợp cao cấp không bong tróc tự nhiên và không thấm nước. 
Lớp lót phía trong làm bằng vải mềm mại. Chất liệu dễ bảo quản, khả năng chống chịu tốt với môi trường khắc nghiệt');
insert into Chitietsanpham values (73,N'Túi đeo chéo YN58 thích hợp cho mọi cô nàng yêu thích thời trang. 
Chiếc túi da được thiết kế tối ưu ngăn đựng giúp nàng thoải mái trong các bữa tiệc, vui chơi. 
Túi đeo chéo nữ YUUMY YN58 với chất da bền bỉ , sẽ là người bạn đồng hành lâu dài cùng nàng theo năm tháng.
-Kích thước : Dài 17cm x Rộng 8cm x Cao 15cm
-Dây dài tối đa 120cm (có thể điều chỉnh)
-Chất liệu : da tổng hợp cao cấp
-Màu sắc : Hồng phấn, Hồng ruốc, Xanh dương, Xanh đen, Đen.');
insert into Chitietsanpham values (74,N'- Chất liệu: da tổng hợp cao cấp (mềm mại, không bong tróc, không thấm nước )
- Kích thước: dài 20cm x rộng 9cm x cao 15cm
- Trọng lượng: 450g
- Số ngăn: 9 ngăn ( 2 ngăn chính, 1 ngăn phụ, 6 ngăn đựng thẻ )
- Màu sắc: Màu Xanh Ngọc – Màu Xanh Dương – Màu Đen – Màu Vàng
- Công dụng: túi phù hợp đi chơi, đi shopping, đi du lịch, picnic.');
insert into Chitietsanpham values (75,N'- Kích thước:
- Màu sắc:
- Chất liệu: Da PU
- Style: Hàn Quốc
Vì sao bạn nên sở hữu ít nhất một chiếc TÚI ĐEO CHÉO?
Những lưu ý khi sử dụng TÚI XÁCH!
chuyên nhận sỉ, nhận đặt hàng sản xuất các mẫu túi đeo chéo, túi xách, ví cầm tay, ví clutch, ví nam, balo thời trang, balo học
cam kết những hình ảnh về chất lượng sản phẩm là hoàn toàn chính xác');
--Nón
insert into Chitietsanpham values (76,N'Nhiều đường may chắc chắn, giúp nón bền chắc
Chất liệu vải oát bền đẹp, thoáng mát, hợp thời trang
Nón giúp chống nắng tốt, bảo vệ da trước nắng nóng
Nón có dây quai cài giúp giữ nón chống bay trước gió
Dây cài quai nón dễ dàng tăng giảm kích thước như ý
Nón có nút bấm giúp gài vành nón vào bên hông tạo kiểu
Nón có đục các lỗ thoáng khí tạo sự mát mẻ cho người đội');
insert into Chitietsanpham values (77,N'Chất liệu: cói tự nhiên, mềm, có thể gấp nhỏ cho vào balo, vali, túi xách
Kích thước vành mũ 6cm
Mũ freesize cho vòng đầu trung bình từ 56-60cm
vành mũ có thể uốn tạo nhiều kiểu
Màu sắc: màu nâu đậm , phối viền đen hoặc viền trắng
Kiểu dáng: mũ cao bồi nữ, nam điều đội đẹp
sống ảo chất phối đồ rất dễ, chất cói màu nâu làm sáng da mặt');
insert into Chitietsanpham values (78,N'Thêu chữ "Its So Nice" cá tính
Vành rộng thời trang, dễ dàng phối đồ
Mũ bucket vải cotton siêu Hot trong mùa hè');
insert into Chitietsanpham values (79,N'Chất liệu: Vải cotton kaki bền chắc và siêu thấm hút mồ hôi, 
giúp mái tóc bạn khô khoáng suốt cả ngày.
Màu sắc: Đen, Cam Carrot, Xanh Navy, Trắng, Vàng
Kiểu dáng Unisex - đa phong cách, gọn nhẹ, năng động, phù hợp cả nam lẫn nữ.
Thiết kế may thêu tinh tế, sắc nét, hợp thời trang.
Phần mũi nón bo cong vừa cho bạn cảm giác trẻ trung vừa giúp bạn tránh được cái nắng hè gay gắt.
Phía sau có khóa điều chỉnh giúp phù hợp nhiều kích thước người dùng.
Dễ phối, phù hợp cho những chuyến đi chơi du lịch, dã ngoại ngoài trời.');
insert into Chitietsanpham values (80,N'Chất liệu: vải kaki dày dặn cao cấp, lên from chuẩn đẹp vừa đầu
Logo 3d thêu sắc nét, chuẩn kích thước
Kích thước: freesize, nón dành cho cả nam và nữ - mũ lưỡi trai unisex
Mọi thông tin cần hỗ trợ xin liên hệ đến CAPMEN
Store: Số 5 ngõ 217 trần phú – hà đông');
--Dây nịt
insert into Chitietsanpham values (81,N'Mã sản phẩm: mặt vuông
Chất liệu: PU
Chiều rộng bản: 3.5 cm
Hoạ tiết: trơn
Tình trạng: mới
Phù hợp: mọi lứa tuổi
Mặt khoá được làm từ hợp kim bọc bởi lớp phủ cực kỳ sang trọng.
Đường vân trên bề mặt sản phẩm trong rất tự nhiên, mềm dẻo và không thấm nước.
Sản phẩm có kiểu dáng đơn giản nhưng tinh tế dễ dàng phối hợp với các kiểu quần jeans & kaki');
insert into Chitietsanpham values (82,N'Thắt lưng nam PAGINI DL07 khóa tự động 
Dây lưng nam mặt khóa bằng thép không gỉ cao cấp, độ bền tới 10.000 lần khóa
Tặng thêm 1 mặt khóa cao cấp giúp bạn dễ dàng phối đồ và thay đổi phong cách
Với thắt lưng PAGINI sản xuất trên công nghê hiện đại nhất hiện nay với chất lương da cao cấp giúp kéo dài tuổi thọ của dây lưng');
insert into Chitietsanpham values (83,N'Thắt lưng là phụ kiện không thể thiếu của phái mạnh, 
ngoài nhiệm vụ cơ bản là giữ quần thì thắt lưng còn có tác dụng tạo điểm nhấn cho trang phục , góp phần tạo nên phong cách của bạn.');
insert into Chitietsanpham values (84,N'Chất liệu: Da Bò
Màu sắc: Nhiều Màu
Xuất xứ: Nhập Khẩu');
insert into Chitietsanpham values (85,N'Không có mô tả');

--select* from Khachhang