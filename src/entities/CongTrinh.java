package entities;

import java.util.Date;

public class CongTrinh{
	private String maCT;
	private String tenCT;
	private Date ngayCapPhepXayDung ;
	private Date ngayKhoiCong;
	private Date ngayDuKienHoanThanh;
	private int maNV;
	public CongTrinh() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CongTrinh(String maCT, String tenCT, Date ngayCapPhepXayDung,
			Date ngayKhoiCong, Date ngayDuKienHoanThanh, int maNV) {
		super();
		this.maCT = maCT;
		this.tenCT = tenCT;
		this.ngayCapPhepXayDung = ngayCapPhepXayDung;
		this.ngayKhoiCong = ngayKhoiCong;
		this.ngayDuKienHoanThanh = ngayDuKienHoanThanh;
		this.maNV = maNV;
	}
	public String getMaCT() {
		return maCT;
	}
	public void setMaCT(String maCT) {
		this.maCT = maCT;
	}
	public String getTenCT() {
		return tenCT;
	}
	public void setTenCT(String tenCT) {
		this.tenCT = tenCT;
	}
	public Date getNgayCapPhepXayDung() {
		return ngayCapPhepXayDung;
	}
	public void setNgayCapPhepXayDung(Date ngayCapPhepXayDung) {
		this.ngayCapPhepXayDung = ngayCapPhepXayDung;
	}
	public Date getNgayKhoiCong() {
		return ngayKhoiCong;
	}
	public void setNgayKhoiCong(Date ngayKhoiCong) {
		this.ngayKhoiCong = ngayKhoiCong;
	}
	public Date getNgayDuKienHoanThanh() {
		return ngayDuKienHoanThanh;
	}
	public void setNgayDuKienHoanThanh(Date ngayDuKienHoanThanh) {
		this.ngayDuKienHoanThanh = ngayDuKienHoanThanh;
	}
	public int getMaNV() {
		return maNV;
	}
	public void setMaNV(int maNV) {
		this.maNV = maNV;
	}
	@Override
	public String toString() {
		return "CongTrinh [maCT=" + maCT + ", tenCT=" + tenCT
				+ ", ngayCapPhepXayDung=" + ngayCapPhepXayDung
				+ ", ngayKhoiCong=" + ngayKhoiCong + ", ngayDuKienHoanThanh="
				+ ngayDuKienHoanThanh + ", maNV=" + maNV + "]";
	}
	
	
}
