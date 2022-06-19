using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using shopthoitrang.Models;
using System.IO;
using System.Text.RegularExpressions;

namespace shopthoitrang.Controllers
{
    public class HomeController : Controller
    {
        DataClasses1DataContext data = new DataClasses1DataContext();

        public ActionResult TrangChu()
        {
            List<Sanpham> dssp = data.Sanphams.Take(6).ToList();
            return View(dssp);
        }

        public ActionResult HTLoaiHang()
        {
            List<Loaisanpham> dslh = data.Loaisanphams.ToList();
            return PartialView(dslh);
        }

        public ActionResult HTTheoLoaiHang(int id)
        {
            List<Sanpham> dssp = data.Sanphams.Where(n => n.Maloai == id).ToList();
            return View("TrangChu", dssp);
        }

        [HttpPost]
        public ActionResult XuLyTK(FormCollection c)
        {
            string tensp = c["txtSearch"].ToString();
            if (tensp == null)
            {
                return RedirectToAction("TrangChu", "Home");
            }
            List<Sanpham> ds = data.Sanphams.Where(n => n.Tensanpham.Contains(tensp) == true).ToList();
            return View("TrangChu", ds);
        }

        public ActionResult ChiTiet(string id)
        {
            int masp = int.Parse(id);
            Sanpham sanpham = data.Sanphams.FirstOrDefault(t => t.Masanpham == masp);

            List<Sanpham> ds1 = data.Sanphams.Where(t => t.Maloai == sanpham.Maloai).Take(6).ToList();
            ViewBag.list1 = ds1;
            Chitietsanpham ct = data.Chitietsanphams.FirstOrDefault(t => t.Masanpham == masp);
            if (ct == null)
            {
                Chitietsanpham ctsp = new Chitietsanpham();
                ctsp.Masanpham = masp;
                ctsp.Chitietsanpham1 = "Không có";
                data.Chitietsanphams.InsertOnSubmit(ctsp);
                data.SubmitChanges();
                ViewBag.ct1 = ctsp;
                return View(sanpham);
            }            
            ViewBag.ct1 = ct;

            return View(sanpham);
        }

        public ActionResult LienHe()
        {
            return View();
        }

        public ActionResult LichSuMuaHang()
        {
            Khachhang khach = Session["khachhang"] as Khachhang;
            if (khach == null)
            {
                return RedirectToAction("DangNhap", "Home");
            }
            List<Hoadon> ds = data.Hoadons.Where(t => t.Makh == khach.Makh).ToList();
            return View(ds);
        }

        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLDN(FormCollection col)
        {
            string ten = col["txtkh"];
            string p = col["txtpass"];
            Khachhang kh = data.Khachhangs.SingleOrDefault(k => k.Tendangnhap == ten && k.Matkhau == p);
            if (kh == null) //đăng nhập không thành công
            {
                SetAlert("Tên đăng nhập/mật khẩu không đúng hoặc bạn chưa đăng ký tài khoản!", 2);
                return RedirectToAction("DangNhap", "Home");
            }
            //tài khoản bị vô hiệu hóa hoạt động
            if (kh.Hoatdong == "False")
            {
                SetAlert("Tài khoản hiện không còn hoạt động", 2);
                return RedirectToAction("DangNhap", "Home");
            }
            //thành công
            Session["khachhang"] = kh;
            return RedirectToAction("TrangChu", "Home");
        }

        protected void SetAlert(string message, int type)
        {
            TempData["AlertMessage"] = message;
            if (type == 1)
            {
                TempData["AlertType"] = "alert-success";
            }
            else if (type == 2)
            {
                TempData["AlertType"] = "alert-warning";
            }
            else if (type == 3)
            {
                TempData["AlertType"] = "alert-danger";
            }
            else
            {
                TempData["AlertType"] = "alert-info";
            }
        }

        [HttpGet]
        public ActionResult DangKy()
        {
            return View();
        }

        public ActionResult XLDK(FormCollection col)
        {

            List<Khachhang> ds = data.Khachhangs.Where(n => n.Tendangnhap == col["txtkh"]).ToList();

            if (ds.Count != 0)
            {
                SetAlert("Tên đăng nhập đã tồn tại", 2);
                return RedirectToAction("DangKy", "Home");
            }

            if (col["txtpass"] == "" || col["txtkh"] == "")
            {
                SetAlert("Tên đăng nhập/mật khẩu không được để trống", 2);
                return RedirectToAction("DangKy", "Home");
            }

            if (col["ngaysinh"] == "")
            {
                SetAlert("Ngày sinh không được để trống", 2);
                return RedirectToAction("DangKy", "Home");
            }

            if (col["txtdt"].Length > 11)
            {
                SetAlert("Số điện thoại không hợp lệ!", 2);
                return RedirectToAction("DangKy", "Home");
            }

            if (!isEmail(col["txtemail"]))
            {
                SetAlert("Email không hợp lệ!", 2);
                return RedirectToAction("DangKy", "Home");
            }

            if (!isNumber(col["txtdt"]))
            {
                SetAlert("Số điện thoại hợp lệ!", 2);
                return RedirectToAction("DangKy", "Home");
            }

            Khachhang kh = new Khachhang();
            kh.Hoten = col["txtten"];
            kh.Tendangnhap = col["txtkh"];
            kh.Matkhau = col["txtpass"];
            kh.Gioitinh = col["gioitinh"];
            kh.Email = col["txtemail"];
            kh.Sodienthoai = col["txtdt"];
            kh.Diachi = col["txtdiachi"];
            kh.Ngaysinh = DateTime.Parse(col["ngaysinh"]);
            kh.Hoatdong = "True";
            data.Khachhangs.InsertOnSubmit(kh);
            data.SubmitChanges();

            //đăng ký thành công
            Session["khachhang"] = kh;
            return RedirectToAction("TrangChu", "Home");
        }

        public static bool isEmail(string inputEmail)
        {
            inputEmail = inputEmail ?? string.Empty;
            string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
                  @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
                  @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
            Regex re = new Regex(strRegex);
            if (re.IsMatch(inputEmail))
                return (true);
            else
                return (false);
        }

        public bool isNumber(string pValue)
        {
            foreach(Char c in pValue)
            {
                if (!Char.IsDigit(c))
                    return false;
            }
            return true;
        }

        public ActionResult HTGioHang()
        {
            GioHang gh = Session["gio"] as GioHang;
            return View(gh);
        }

        public ActionResult DangXuat()
        {
            Session["khachhang"] = null;
            return RedirectToAction("TrangChu", "Home");
        }

        public ActionResult ChonMua(int id)
        {
            GioHang gh = Session["gio"] as GioHang;
            if (gh == null)
            {
                gh = new GioHang();
            }

            //Thêm mặt hàng vào giỏ
            gh.Them(id);

            Session["gio"] = gh;


            return RedirectToAction("TrangChu", "Home");
        }

        public ActionResult Xoa1MatHang(int id)
        {
            GioHang gh = (GioHang)Session["gio"];
            gh.Xoa(id);
            return RedirectToAction("HTGioHang", "Home");
        }

        public ActionResult XacNhanThongTin()
        {
            Khachhang khach = Session["khachhang"] as Khachhang;

            if (khach == null)
            {
                return RedirectToAction("DangNhap", "Home");
            }


            return View(khach);
        }

        public ActionResult LuuDatHang(FormCollection col)
        {
            GioHang gh = (GioHang)Session["gio"];
            Khachhang kh = (Khachhang)Session["khachhang"];
            if (Session["khachhang"] == null)
                return RedirectToAction("DangNhap", "Home");
            if (Session["gio"] == null || gh.lst.Count == 0)
                return RedirectToAction("HTGioHang", "Home");

            if (col["txtdiachi"] == "")
            {
                SetAlert("Địa chỉ không được để trống!", 2);
                return RedirectToAction("XacNhanThongTin", "Home");
            }
            //cap nhat dia chi moi
            Khachhang kh1 = data.Khachhangs.SingleOrDefault(n => n.Makh == kh.Makh);
            if (kh1 != null)
            {
                kh1.Diachi = col["txtdiachi"];
                UpdateModel(kh1);
                data.SubmitChanges();
            }

            //lay thong tin ngay giao
            DateTime ngaygiao;
            if (col["txtNgayHen"] == "")
            {
                ngaygiao = DateTime.Now.AddDays(3);
            }
            else
            {
                ngaygiao = DateTime.Parse(col["txtNgayHen"]);
                if (ngaygiao < DateTime.Now)
                {
                    SetAlert("Ngày hẹn giao phải lớn hơn ngày đặt!", 2);
                    return RedirectToAction("XacNhanThongTin", "Home");
                }
                
            }

            //luu vao bang dat hang
            Hoadon hd = new Hoadon();
            DateTime d = DateTime.Now;
            hd.Mahd = "" + d.Hour + d.Minute + d.Second + d.Day + d.Month + d.Year; 
            hd.Makh = kh.Makh;
            hd.NgayHoaDon = DateTime.Now.Date;
            hd.NgayGiao = ngaygiao.Date;
            data.Hoadons.InsertOnSubmit(hd);
            data.SubmitChanges();
            //luu thong tin vao bang chi tiet dat hang
            foreach (CartItem sp in gh.lst)
            {
                Chitiet ct = new Chitiet();
                ct.Mahd = hd.Mahd;
                ct.Masanpham = sp.iMaSanPham;
                ct.Soluong = sp.iSoLuong;
                data.Chitiets.InsertOnSubmit(ct);
            }
            data.SubmitChanges();

            //luu vao bang thong ke doanh thu

            List<ThongKeDoanhThu> listdt = data.ThongKeDoanhThus.Where(n => n.Ngay == DateTime.Now).ToList();

            if (listdt.Count == 0)
            {
                ThongKeDoanhThu tk = new ThongKeDoanhThu();
                tk.Ngay = DateTime.Now;
                tk.TongTien = gh.TongThanhTien();
                data.ThongKeDoanhThus.InsertOnSubmit(tk);

            }
            else
            {
                foreach (ThongKeDoanhThu tk in listdt)
                {
                    tk.TongTien = tk.TongTien + gh.TongThanhTien();
                }
            }
            data.SubmitChanges();

            //làm trống giỏ hàng
            Session["gio"] = null;

            return RedirectToAction("TrangChu", "Home");
        }

        public ActionResult XoaGioHang()
        {
            Session["gio"] = null;
            return RedirectToAction("HTGioHang", "Home");
        }

        public ActionResult ThongKe(string mhd)
        {
            List<Chitiet> dsct = data.Chitiets.Where(c => c.Mahd == mhd).ToList();

            //thong ke thanh tien
            var thanhtien = dsct.Sum(ct => ct.Soluong * ct.Sanpham.Gia);

            ViewBag.tt = thanhtien;
            return PartialView(dsct);
        }

        public ActionResult LietKeHoaDon(string mhd)
        {
            List<Chitiet> dsct = data.Chitiets.Where(c => c.Mahd == mhd).ToList();


            return PartialView(dsct);
        }
    }
}