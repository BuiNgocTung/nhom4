/**
 * Người làm: Nguyễn Đình Quốc
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


import database.ConectDatabase;
import entities.DiaChi;
import entities.NhanVien;
import entities.PhongBan;
import entities.TaiKhoan;

public class NhanVienDAO {
	Connection con;
	PreparedStatement preStm;
	ResultSet rs;

	public NhanVienDAO() {
	}

	
	public ArrayList<NhanVien> getAllTBNhanVien() {
		ArrayList<NhanVien> dsNhanVien = new ArrayList<NhanVien>();
		try {
			ConectDatabase.getInstance();
			Connection con = ConectDatabase.getConnection();
			
			String sql = "select * from NhanVien";
			Statement statement = con.createStatement();
			
			// Thực thi câu lệnh SQL trả về ResultSet
			ResultSet rs = statement.executeQuery(sql);

			// Duyệt trên kết quả trả về
			while (rs.next()) { // Di chuyển con trỏ xuống bản ghi kế tiếp
				int maNV = rs.getInt(1);				
			    String ho = rs.getString(2);
				String ten = rs.getString(3);
				Date ngaySinh = rs.getDate(4);
				String gioiTinh = rs.getString(5);
				String CMND = rs.getString(6);
				String soDT = rs.getString(7);
				int maDiaChi = rs.getInt(8);
				String maPhong = rs.getString(9);
				String tenTK = rs.getString(10);
				String loaiNV = rs.getString(11);
				String trangThai = rs.getString(12);
				DiaChi diaChi = new DiaChi();
				diaChi.setMaDiaChi(maDiaChi);
				TaiKhoan taiKhoan = new TaiKhoan();
				taiKhoan.setTenTaiKhoan(tenTK);		
				PhongBan phongBan = new PhongBan();
				phongBan.setMaPhongBan(maPhong);
			NhanVien nv = new NhanVien(maNV, ho, ten, ngaySinh, gioiTinh, CMND, soDT, diaChi, phongBan, taiKhoan, loaiNV, trangThai);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dsNhanVien;
	}

	public ArrayList<NhanVien> getAllNhanVien() {
		ArrayList<NhanVien> dsNhanVien = new ArrayList<NhanVien>();
		NhanVien nv;
		try {
			ConectDatabase.getInstance();
			 con = ConectDatabase.getConnection();
			String sql = "select *from NhanVien";
           preStm = con.prepareStatement(sql);
			// Thực thi câu lệnh SQL trả về ResultSet
		        rs = preStm.executeQuery(sql);
			
			while (rs.next()) {
				int maNV = rs.getInt(1);				
			    String ho = rs.getString(2);
				String ten = rs.getString(3);
				Date ngaySinh = rs.getDate(4);
				String gioiTinh = rs.getString(5);
				String CMND = rs.getString(6);
				String soDT = rs.getString(7);
				int maDiaChi = rs.getInt(8);
				String maPhong = rs.getString(9);
				String tenTK = rs.getString(10);
				String loaiNV = rs.getString(11);
				String trangThai = rs.getString(12);
				DiaChi diaChi = new DiaChi();
				diaChi.setMaDiaChi(maDiaChi);
				TaiKhoan taiKhoan = new TaiKhoan();
				taiKhoan.setTenTaiKhoan(tenTK);		
				PhongBan phongBan = new PhongBan();
				phongBan.setMaPhongBan(maPhong);
			nv = new NhanVien(maNV, ho, ten, ngaySinh, gioiTinh, CMND, soDT, diaChi, phongBan, taiKhoan, loaiNV, trangThai);
	
				dsNhanVien.add(nv);
			}
		} catch (Exception e2) {
			e2.printStackTrace();
		} finally {
		}
		return dsNhanVien;
	}

	/**
	 * add TaiKhoan
	 * 
	 * @param tk
	 * @return true/false
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@SuppressWarnings("static-access")
	public boolean addTaiKhoan(TaiKhoan tk) throws ClassNotFoundException, SQLException {
		con = ConectDatabase.getInstance().getConnection();
		int n = 0;
		try {
			preStm = con.prepareStatement("insert into TaiKhoan values\r\n" + "(?,?)");
			preStm.setString(1, tk.getTenTaiKhoan());
			preStm.setString(2, tk.getMatKhau());
			n = preStm.executeUpdate();
		} catch (Exception e3) {
			e3.printStackTrace();
		} finally {
		}
		return n > 0;
	}

	/**
	 * get all TenTaiKhoan
	 * 
	 * @return List<String>
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public List<String> getAllTenTaiKhoan() throws Exception {
		List<String> result = null;
		try {
			con = ConectDatabase.getInstance().getConnection();
			String sql = "select [TenTaiKhoan] from [dbo].[TaiKhoan]";
			preStm = con.prepareStatement(sql);
			rs = preStm.executeQuery();
			result = new ArrayList<>();
			while (rs.next()) {
				String taiKhoan = rs.getString(1);
				result.add(taiKhoan);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return result;
	}

	/**
	 * add DiaChi
	 * 
	 * @param dc
	 * @return true/false
	 * @throws SQLException
	 */
	@SuppressWarnings("static-access")
	public boolean addDiaChi(DiaChi dc) throws SQLException {
		con = ConectDatabase.getInstance().getConnection();
		boolean check = false;
		try {
			preStm = con.prepareStatement("insert into dbo.DiaChi values\r\n" + "(?,?,?,?,?,?)");
			preStm.setString(1, dc.getSoNha());
			preStm.setString(2, dc.getTenDuong());
			preStm.setString(3, dc.getPhuong());
			preStm.setString(4, dc.getQuan());
			preStm.setString(5, dc.getThanhPho());
			preStm.setString(6, dc.getQuocGia());
			check = preStm.executeUpdate() > 0;
		} catch (Exception e3) {
			System.out.println("loi sql them dia chi");
			e3.printStackTrace();
		} finally {
		}
		return check;
	}

	/**
	 * get all MaDiaChi
	 * 
	 * @return List<Integer>
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public List<Integer> getAllMaDiaChi() throws Exception {
		List<Integer> result = new ArrayList<Integer>();
		con = ConectDatabase.getInstance().getConnection();
		try {
			String sql = "select [MaDiaChi] from [dbo].[DiaChi]";
			preStm = con.prepareStatement(sql);
			ResultSet rs = preStm.executeQuery();
			while (rs.next()) {
				int maDC = rs.getInt(1);
				result.add(maDC);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Lỗi lấy all MaDiaChi");
		} finally {
		}
		return result;
	}

	/**
	 * get MaDiaChiMax
	 * 
	 * @param maDiaChiMax
	 * @return maDiaChiMax
	 */
	@SuppressWarnings("static-access")
	public int getMaDiaChiMax() {
		int maDiaChiMax = 0;
		con = ConectDatabase.getInstance().getConnection();
		try {
			String sql = "select MAX(MaDiaChi)\r\n" + "from dbo.DiaChi";
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			while (rs.next()) {
				maDiaChiMax = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return maDiaChiMax;
	}

	/**
	 * get maNhanVienMax
	 * 
	 * @return maNhanVienMax
	 * @throws SQLException
	 */
	@SuppressWarnings("static-access")
	public int getMaNhanVienMax() throws SQLException {
		int maNhanVienMax = 0;
		con = ConectDatabase.getInstance().getConnection();
		try {
			String sql = "select MAX(MaNhanVien)\r\n" + "from dbo.NhanVien";
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			while (rs.next()) {
				maNhanVienMax = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return maNhanVienMax;
	}

	/**
	 * get all maNhanVien
	 * 
	 * @return List<Integer>
	 * @throws Exception
	 */
	@SuppressWarnings("static-access")
	public List<Integer> getAllMaNV() throws Exception {
		List<Integer> result = new ArrayList<Integer>();
		try {
			Connection con = ConectDatabase.getInstance().getConnection();
			PreparedStatement stmt = null;
			String sql = "select MaNhanVien from NhanVien";
			stmt = con.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			int maNV;
			while (rs.next()) {
				maNV = rs.getInt(1);
				result.add(maNV);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
		return result;
	}

	/**
	 * get information DiaChi
	 * 
	 * @param maDC
	 * @return DiaChi
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	@SuppressWarnings("static-access")
	public DiaChi layThongTinDiaChi(int maDC) throws ClassNotFoundException, SQLException {
		DiaChi dto = null;
		try {
			con = ConectDatabase.getInstance().getConnection();
			String sql = "Select * from DiaChi where MaDiaChi = ?";
			preStm = con.prepareStatement(sql);
			preStm.setInt(1, maDC);
			rs = preStm.executeQuery();
			if (rs.next()) {
				String soNha = rs.getString("SoNha");
				String tenDuong = rs.getString("TenDuong");
				String phuong = rs.getString("Phuong");
				String quan = rs.getString("Quan");
				String thanhPho = rs.getString("ThanhPho");
				String quocGia = rs.getString("QuocGia");
				int maDiaChi = rs.getInt("MaDiaChi");
				dto = new DiaChi(maDiaChi, soNha, tenDuong, phuong, quan, thanhPho, quocGia);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	/**
	 * get full name NhanVien by tenTaiKhoan
	 * 
	 * @param tenTaiKhoan
	 * @return String
	 */
	@SuppressWarnings("static-access")
	public String getTenNhanVienByTenTaiKhoan(String tenTaiKhoan) {
		String tenTaiKhoan1 = null;

		try {
			con = ConectDatabase.getInstance().getConnection();
			String sql = "select Ho + ' '+Ten\r\n"
					+ "from dbo.NhanVien n join dbo.TaiKhoan t on n.TenTaiKhoan = t.TenTaiKhoan\r\n"
					+ "where t.TenTaiKhoan = ?";
			preStm = con.prepareStatement(sql);
			preStm.setString(1, tenTaiKhoan);
			rs = preStm.executeQuery();
			while (rs.next()) {
				tenTaiKhoan1 = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error getTenNhanVienByTenTaiKhoan SQL !");
		}
		return tenTaiKhoan1;
	}
}
