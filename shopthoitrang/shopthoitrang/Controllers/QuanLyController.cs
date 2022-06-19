using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using shopthoitrang.Models;
using System.IO;

namespace shopthoitrang.Controllers
{
    public class QuanLyController : Controller
    {
        //
        // GET: /QuanLy/

        DataClasses1DataContext data = new DataClasses1DataContext();

        public ActionResult QLyDonHang()
        {
            Nhanvien nv = Session["nhanvien"] as Nhanvien;

            if (nv == null)
            {
                return RedirectToAction("DangNhap", "QuanLy");
            }

            List<Hoadon> dshd = data.Hoadons.ToList();

            return View(dshd);
        }

        public ActionResult ThongKe(string mhd)
        {
            List<Chitiet> dsct = data.Chitiets.Where(c => c.Mahd == mhd).ToList();

            //thong ke thanh tien
            var thanhtien = dsct.Sum(ct => ct.Soluong * ct.Sanpham.Gia);

            ViewBag.tt = thanhtien;
            return PartialView(dsct);
        }

        [HttpPost]
        public ActionResult GiaoHang(FormCollection c)
        {
            Nhanvien nv = Session["nhanvien"] as Nhanvien;
            int sopt = int.Parse(c["tong"]);
            for (int i = 1; i <= sopt; i++)
            {
                if (c[i.ToString()] != null)
                {
                    string mhd = c[i.ToString()];
                    Hoadon hd = data.Hoadons.SingleOrDefault(h => h.Mahd == mhd);
                    hd.NgayThanhToan = DateTime.Now;
                    hd.Manv = nv.Manv;
                    UpdateModel(hd);
                }
                data.SubmitChanges();
            }
            return RedirectToAction("QLyDonHang", "QuanLy");
        }

        public ActionResult LietKeHoaDon(string mhd)
        {
            List<Chitiet> dsct = data.Chitiets.Where(c => c.Mahd == mhd).ToList();


            return PartialView(dsct);
        }

        [HttpPost]
        public ActionResult CapNhatGiaoHang(FormCollection c)
        {
            int n = int.Parse(c["tong"]);

            for (int i = 0; i <= n; i++)
            {
                string tenck = i.ToString();
                if (c[tenck] != null)//duoc chon
                {
                    //cap nhat tinh trang giao hang tai hoa don co ma hoa don la gia tri nut checkbox
                    string mhd = c[tenck];
                    Hoadon hd = data.Hoadons.SingleOrDefault(h => h.Mahd == mhd);
                    hd.NgayThanhToan = hd.NgayGiao;

                    UpdateModel(hd);
                    data.SubmitChanges();
                }
            }


            return RedirectToAction("QLyDonHang", "QuanLy");
        }

        public ActionResult SanPham()
        {
            Nhanvien nv = Session["nhanvien"] as Nhanvien;

            if (nv == null)
            {
                return RedirectToAction("DangNhap", "QuanLy");
            }

            List<Sanpham> ds = data.Sanphams.ToList();
            
            return View(ds);
        }

        [HttpGet]
        public ActionResult ThemSanPham()
        {
            ViewBag.Maloai = new SelectList(data.Loaisanphams.ToList(), "Maloai", "Tenloai");
            ViewBag.Manhasx = new SelectList(data.Nhasanxuats.ToList(), "Manhasx", "Tennhasx");
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Them(Sanpham sp, HttpPostedFileBase upHinh)
        {

            sp.Hinhanh = upHinh.FileName;
            upHinh.SaveAs(Server.MapPath("/Content/Images/" + upHinh.FileName));

            if (sp.Gia < 0)
            {
                SetAlert("Giá phải lớn hơn 0", 2);
                return RedirectToAction("ThemSanPham", "QuanLy");
            }

            if (sp.Soluong < 0)
            {
                SetAlert("Số lượng phải lớn hơn 0", 2);
                return RedirectToAction("ThemSanPham", "QuanLy");
            }

            data.Sanphams.InsertOnSubmit(sp);
            data.SubmitChanges();           
           

            return RedirectToAction("SanPham", "QuanLy");
        }

        public ActionResult ChiTietSanPham(int id)
        {
           
            Chitietsanpham ctsp = data.Chitietsanphams.SingleOrDefault(n => n.Masanpham == id);          
            if (ctsp == null)
            {
                Chitietsanpham ct = new Chitietsanpham();
                ct.Masanpham = id;
                ct.Chitietsanpham1 = "Không có chi tiết";
                data.Chitietsanphams.InsertOnSubmit(ct);
                data.SubmitChanges();
                ViewBag.Masanpham = ct.Masanpham;
                return View(ct);
            }

            ViewBag.Masanpham = ctsp.Masanpham;
            return View(ctsp);
        }

        [HttpGet]
        public ActionResult SuaChiTietSanPham(int id)
        {
            Chitietsanpham ctsp = data.Chitietsanphams.SingleOrDefault(n => n.Masanpham == id);                     

            if (ctsp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(ctsp);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult SuaChiTietSanPham(Chitietsanpham ctsp)
        {
            Chitietsanpham ct = data.Chitietsanphams.SingleOrDefault(n => n.Masanpham == ctsp.Masanpham);
            if (ct != null)
            {
                ct.Chitietsanpham1 = ctsp.Chitietsanpham1;
            }
            data.SubmitChanges();
            return RedirectToAction("SanPham");
        }

        [HttpGet]
        public ActionResult XoaSanPham(int id)
        {
            Sanpham sp = data.Sanphams.SingleOrDefault(n => n.Masanpham == id);
            ViewBag.Masanpham = sp.Masanpham;
            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(sp);
        }

        [HttpPost, ActionName("XoaSanPham")]
        public ActionResult XacNhanXoa(int id)
        {
            Sanpham sp = data.Sanphams.SingleOrDefault(n => n.Masanpham == id);
            List<Chitietsanpham> dsct = data.Chitietsanphams.Where(n => n.Masanpham == id).ToList();
            ViewBag.Masanpham = sp.Masanpham;
            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            if (dsct != null)
            {
                foreach (Chitietsanpham ct in dsct)
                {
                    data.Chitietsanphams.DeleteOnSubmit(ct);
                    data.SubmitChanges();
                }
            }
            data.Sanphams.DeleteOnSubmit(sp);
            data.SubmitChanges();
            return RedirectToAction("SanPham");
        }

        [HttpGet]
        public ActionResult SuaSanPham(int id)
        {

            Sanpham sp = data.Sanphams.SingleOrDefault(n => n.Masanpham == id);
            ViewBag.Maloai = new SelectList(data.Loaisanphams.ToList(), "Maloai", "Tenloai");
            
            //ViewBag.MaLoai = new SelectList(data.LoaiHangs.ToList().OrderBy(n => n.TenLoai), "MaLoai", "TenLoai");

            if (sp == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            
            ViewBag.Masanpham = sp.Masanpham;
            return View(sp);
        }


        [HttpPost]
        [ValidateInput(false)]
        public ActionResult SuaSanPham(Sanpham sp, HttpPostedFileBase fileUpload)
        {
            ViewBag.Maloai = new SelectList(data.Loaisanphams.ToList().OrderBy(n => n.Tenloai), "Maloai", "Tenloai");
            if (fileUpload == null)
            {
                SetAlert("Vui lòng chọn ảnh bìa!", 2);
                return View(sp);
            }                  
            //Them vao CSDL
            else
            {
                if (ModelState.IsValid)
                {
                    //Luu ten file, luu y bo sung thu vien using System.IO
                    var fileName = Path.GetFileName(fileUpload.FileName);
                    //Luu duong dan cua file
                    var path = Path.Combine(Server.MapPath("~/Content/Images"), fileName);
                    //Kiem tra hinh anh co ton tai khong?
                    if (System.IO.File.Exists(path))
                        ViewBag.Thongbao = "Hình ảnh đã tồn tại";
                    else
                    {
                        //Luu hinh anh vao duong dan
                        fileUpload.SaveAs(path);
                    }
                    if (sp != null)
                        sp.Hinhanh = fileName;
                    //Luu vao CSDL
                    Sanpham sp1 = data.Sanphams.SingleOrDefault(t => t.Masanpham == sp.Masanpham);
                    if (sp1 != null)
                    {
                        sp1.Tensanpham = sp.Tensanpham;
                        sp1.Maloai = sp.Maloai;
                        sp1.Hinhanh = sp.Hinhanh;
                        if (sp1.Gia <= 0)
                        {
                            SetAlert("Giá của sản phẩm phải lớn hơn 0!", 2);
                            return View(sp);
                        }
                        else
                            sp1.Gia = sp.Gia;
                        if (sp1.Soluong <= 0)
                        {
                            SetAlert("Số lượng của sản phẩm phải lớn hơn 0!", 2);
                            return View(sp);
                        }
                        else
                            sp1.Soluong = sp.Soluong;
                        //data.SubmitChanges();
                    }
                    //UpdateModel(sp);
                    data.SubmitChanges();
                    
                }
                return RedirectToAction("SanPham");
            }           

        }

        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLDN(FormCollection col)
        {
            string ten = col["txtnv"];
            string p = col["txtpass"];
            Nhanvien nv = data.Nhanviens.SingleOrDefault(k => k.Tendangnhap == ten && k.Matkhau == p);
            if (nv == null) // đăng nhập không thành công
            {
                SetAlert("Tên đăng nhập hoặc mật khẩu không đúng", 2);
                return RedirectToAction("DangNhap", "QuanLy");
            }

            //thành công
            Session["nhanvien"] = nv;
            return RedirectToAction("QLyDonHang", "QuanLy");
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

        public ActionResult KhachHang()
        {

            Nhanvien nv = Session["nhanvien"] as Nhanvien;

            if (nv == null)
            {
                return RedirectToAction("DangNhap", "QuanLy");
            }

            List<Khachhang> ds = data.Khachhangs.ToList();
            return View(ds);
        }

        [HttpGet]
        public ActionResult DangKy()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLDK(FormCollection col)
        {
            Nhanvien nv = new Nhanvien();

            List<Nhanvien> ds = data.Nhanviens.Where(n => n.Tendangnhap == col["txtnv"]).ToList();

            if (ds.Count != 0)
            {
                SetAlert("Tên đăng nhập đã tồn tại", 2);
                return RedirectToAction("DangKy", "QuanLy");
            }

            if (col["txtnv"] == "" || col["txtpass"] == "")
            {
                SetAlert("Tên đăng nhập/mật khẩu không được để trống", 2);
                return RedirectToAction("DangKy", "QuanLy");
            }

            nv.Hoten = col["txtten"];
            nv.Tendangnhap = col["txtnv"];
            nv.Matkhau = col["txtpass"];
            nv.Gioitinh = col["gioitinh"];
            nv.Sodienthoai = col["txtdt"];
            nv.Email = col["txtemail"];
            nv.Diachi = col["txtdiachi"];
            nv.Phanquyen = col["phanquyen"];
            data.Nhanviens.InsertOnSubmit(nv);
            data.SubmitChanges();



            // đăng ký thành công
            Session["nhanvien"] = nv;

            return RedirectToAction("QLyDonHang", "QuanLy");
        }

        public ActionResult DangXuat()
        {
            Session["nhanvien"] = null;
            return RedirectToAction("DangNhap", "QuanLy");
        }

        public ActionResult ThongKeDoanhThu()
        {
            return View();
        }

        public ActionResult QLyDonHangChuaGiao()
        {
            List<Hoadon> dshd = data.Hoadons.Where(n => n.NgayThanhToan == null).ToList();

            return View(dshd);
        }

        public ActionResult QLyDonHangGiaoHT()
        {
            List<Hoadon> dshd = data.Hoadons.Where(n => n.NgayGiao == DateTime.Now).ToList();

            return View(dshd);
        }

        public ActionResult QLyDonHangDaGiao()
        {
            List<Hoadon> dshd = data.Hoadons.Where(n => n.NgayThanhToan != null).ToList();

            return View(dshd);
        }

        public ActionResult ThongKeBanHang()
        {
            List<ThongKeDoanhThu> ds = data.ThongKeDoanhThus.ToList();
            return View(ds);
        }

        protected void SetAlert(string message, Int64 type)
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
        public ActionResult ThemKH()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLThemKH(FormCollection c)
        {
            Khachhang kh = new Khachhang();

            List<Khachhang> ds = data.Khachhangs.Where(n => n.Tendangnhap == c["tendn"]).ToList();

            if (ds.Count != 0)
            {             
                SetAlert("Tên đăng nhập đã tồn tại", 2);
                return RedirectToAction("ThemKH", "QuanLy");
            }

            kh.Hoten = c["tenkh"];
            kh.Tendangnhap = c["tendn"];
            kh.Matkhau = c["matkhau"];
            kh.Gioitinh = c["gioitinh"];
            kh.Sodienthoai = c["dienthoai"];
            kh.Email = c["email"];
            kh.Diachi = c["diachi"];
            data.Khachhangs.InsertOnSubmit(kh);
            data.SubmitChanges();

            return RedirectToAction("KhachHang", "QuanLy");
        }

        [HttpGet]
        public ActionResult SuaKH(int? id)
        {
            if (id != null)
                Session["idkh"] = id;
            return View();
        }

        [HttpPost]
        public ActionResult XLSuaKH(FormCollection c)
        {

            List<Khachhang> ds = data.Khachhangs.Where(n => n.Tendangnhap == c["tendn"]).ToList();

            if (ds.Count != 0)
            {
                SetAlert("Tên đăng nhập đã tồn tại", 2);
                return RedirectToAction("SuaKH", "QuanLy");
            }

            if (Session["idkh"] != null)
            {
                int idkh = int.Parse(Session["idkh"].ToString());

                List<Khachhang> ds1 = data.Khachhangs.Where(n => n.Makh == idkh).ToList();

                if (ds1.Count == 0)
                {
                    SetAlert("Khách hàng không tồn tại", 2);
                    return RedirectToAction("SuaKH", "QuanLy");
                }
                else
                {
                    foreach (Khachhang kh in ds1)
                    {
                        kh.Hoten = c["tenkh"];
                        kh.Tendangnhap = c["tendn"];
                        kh.Matkhau = c["matkhau"];
                        kh.Gioitinh = c["gioitinh"];
                        kh.Sodienthoai = c["dienthoai"];
                        kh.Email = c["email"];
                        kh.Diachi = c["diachi"];
                    }
                }

                data.SubmitChanges();
            }

            

            return RedirectToAction("KhachHang", "QuanLy");
        }

        public ActionResult XoaKH(int id)
        {
            List<Khachhang> ds = data.Khachhangs.Where(n => n.Makh == id).ToList();
            List<Hoadon> dshd = data.Hoadons.Where(n => n.Makh == id).ToList();
            foreach (Khachhang kh in ds)
            {
                data.Khachhangs.DeleteOnSubmit(kh);
                data.SubmitChanges();
            }
            foreach (Hoadon hd in dshd)
            {
                data.Hoadons.DeleteOnSubmit(hd);
                data.SubmitChanges();
            }
            return RedirectToAction("KhachHang", "QuanLy");
        }
	}
}