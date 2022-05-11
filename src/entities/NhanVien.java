package entities;

import java.sql.Date;
import java.util.Vector;

public class NhanVien {
	private int maNhanVien;
	private String ho;
	private String ten;	
	private Date ngaySinh;
	private String gioiTinh;
	private String cmnd;
	private String soDienThoai;
	private DiaChi diaChi;
	private PhongBan phongBan;
	private TaiKhoan taiKhoan;
	private String loaiNhanVien;
	private String trangThai;
	

	
	public int getMaNhanVien() {
		return maNhanVien;
	}



	public void setMaNhanVien(int maNhanVien) {
		this.maNhanVien = maNhanVien;
	}



	public String getHo() {
		return ho;
	}



	public void setHo(String ho) {
		this.ho = ho;
	}



	public String getTen() {
		return ten;
	}



	public void setTen(String ten) {
		this.ten = ten;
	}



	public Date getNgaySinh() {
		return ngaySinh;
	}



	public void setNgaySinh(Date ngaySinh) {
		this.ngaySinh = ngaySinh;
	}



	public String getGioiTinh() {
		return gioiTinh;
	}



	public void setGioiTinh(String gioiTinh) {
		this.gioiTinh = gioiTinh;
	}



	public String getCmnd() {
		return cmnd;
	}



	public void setCmnd(String cmnd) {
		this.cmnd = cmnd;
	}



	public String getSoDienThoai() {
		return soDienThoai;
	}



	public void setSoDienThoai(String soDienThoai) {
		this.soDienThoai = soDienThoai;
	}



	public DiaChi getDiaChi() {
		return diaChi;
	}



	public void setDiaChi(DiaChi diaChi) {
		this.diaChi = diaChi;
	}



	public PhongBan getPhongBan() {
		return phongBan;
	}



	public void setPhongBan(PhongBan phongBan) {
		this.phongBan = phongBan;
	}



	public TaiKhoan getTaiKhoan() {
		return taiKhoan;
	}



	public void setTaiKhoan(TaiKhoan taiKhoan) {
		this.taiKhoan = taiKhoan;
	}



	public String getLoaiNhanVien() {
		return loaiNhanVien;
	}



	public void setLoaiNhanVien(String loaiNhanVien) {
		this.loaiNhanVien = loaiNhanVien;
	}



	public String getTrangThai() {
		return trangThai;
	}



	public void setTrangThai(String trangThai) {
		this.trangThai = trangThai;
	}



	public NhanVien() {
		super();
		// TODO Auto-generated constructor stub
	}



	public NhanVien(int maNhanVien, String ho, String ten, Date ngaySinh,
			String gioiTinh, String cmnd, String soDienThoai, DiaChi diaChi,
			PhongBan phongBan, TaiKhoan taiKhoan, String loaiNhanVien,
			String trangThai) {
		super();
		this.maNhanVien = maNhanVien;
		this.ho = ho;
		this.ten = ten;
		this.ngaySinh = ngaySinh;
		this.gioiTinh = gioiTinh;
		this.cmnd = cmnd;
		this.soDienThoai = soDienThoai;
		this.diaChi = diaChi;
		this.phongBan = phongBan;
		this.taiKhoan = taiKhoan;
		this.loaiNhanVien = loaiNhanVien;
		this.trangThai = trangThai;
	}



	@Override
	public String toString() {
		return "NhanVien [maNhanVien=" + maNhanVien + ", ho=" + ho + ", ten="
				+ ten + ", ngaySinh=" + ngaySinh + ", gioiTinh=" + gioiTinh
				+ ", cmnd=" + cmnd + ", soDienThoai=" + soDienThoai
				+ ", diaChi=" + diaChi + ", phongBan=" + phongBan
				+ ", taiKhoan=" + taiKhoan + ", loaiNhanVien=" + loaiNhanVien
				+ ", trangThai=" + trangThai + "]";
	}



	public Vector<Object> toVector() {
		Vector<Object> v = new Vector<>();
		v.add("");
		v.add(maNhanVien);
		v.add(ho);
		v.add(ten);
		v.add(ngaySinh);
		v.add(gioiTinh);
		v.add(cmnd);
		v.add(soDienThoai);
		v.add(diaChi.getMaDiaChi());
		v.add(phongBan.getMaPhongBan());
		v.add(taiKhoan.getTenTaiKhoan());
		v.add(loaiNhanVien);
		v.add(trangThai);
		return v;
	}
}
	
