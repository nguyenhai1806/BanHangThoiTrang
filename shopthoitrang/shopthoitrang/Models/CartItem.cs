using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace shopthoitrang.Models
{
    public class CartItem
    {
        public int iMaSanPham { get; set; }
        public string sTenSanPham { get; set; }
        public int iMaLoai { get; set; }
        public int iMaNhaSX { get; set; }
        public string sHinhAnh { get; set; }
        public float fGia { get; set; }
        public int iSoLuong { get; set; }
        public double ThanhTien { get; set; }


        DataClasses1DataContext data = new DataClasses1DataContext();

        //Ham tao cho gio hang
        public CartItem(int mh)
        {
            Sanpham sanpham = data.Sanphams.Single(n => n.Masanpham == mh);
            if (sanpham != null)
            {
                iMaSanPham = mh;
                sTenSanPham = sanpham.Tensanpham;
                iMaLoai = int.Parse(sanpham.Maloai.ToString());
                iMaNhaSX = int.Parse(sanpham.Manhasx.ToString());
                sHinhAnh = sanpham.Hinhanh;
                fGia = float.Parse(sanpham.Gia.ToString());
                iSoLuong = 1;
                ThanhTien = iSoLuong * fGia;
            }
        }
    }


    public class GioHang
    {
        public List<CartItem> lst;
        //Ham tao cho gio hang
        public GioHang()
        {
            lst = new List<CartItem>();
        }

        public GioHang(List<CartItem> lstGH)
        {
            if (lstGH == null)
                lst = new List<CartItem>();
            else
                lst = lstGH;
        }

        //Tinh so mat hang
        public int SoMatHang()
        {
            if (lst == null)
                return 0;
            return lst.Count;
        }

        //Tinh tong so luong mat hang
        public int TongSLHang()
        {
            int iTongSoLuong = 0;
            if (lst != null)
            {
                iTongSoLuong = lst.Sum(n => n.iSoLuong);
            }
            return iTongSoLuong;
        }

        //Tinh tong thanh tien
        public double TongThanhTien()
        {
            double iTongTien = 0;
            if (lst != null)
            {
                iTongTien = lst.Sum(n => n.ThanhTien);
            }
            return iTongTien;
        }

        //Them san pham
        public int Them(int iMaSanPham)
        {
            //Kiem tra san pham co trong ds chua?
            CartItem sanpham = lst.Find(n => n.iMaSanPham == iMaSanPham);
            //Neu chua co
            if (sanpham == null)
            {
                //Tao moi
                CartItem sp = new CartItem(iMaSanPham);
                if (sp == null)
                    return -1;
                lst.Add(sp);
            }
            else //Neu co roi
            {
                sanpham.iSoLuong++; //Tang so luong len 1
                sanpham.ThanhTien = sanpham.iSoLuong * sanpham.fGia;
            }
            return 1;
        }

        //Xoa san pham
        public int Xoa(int iMaSanPham)
        {
            //Kiem tra san pham co trong ds chua?
            CartItem sanpham = lst.Find(n => n.iMaSanPham == iMaSanPham);
            //Neu chua co
            if (sanpham == null)
            {
                return -1;
            }
            else //Neu co
            {
                lst.Remove(sanpham);
            }
            return 1;
        }
      
    }
}