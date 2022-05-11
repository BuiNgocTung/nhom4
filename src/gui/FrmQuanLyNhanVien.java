package gui;

import java.awt.Color;
import java.awt.EventQueue;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.ScrollPaneConstants;
import javax.swing.SwingConstants;
import javax.swing.UIManager;
import javax.swing.border.TitledBorder;
import javax.swing.table.DefaultTableModel;

import com.toedter.calendar.JDateChooser;



import dao.NhanVienDAO;
//import dao.NhanVienDAO;
import entities.DiaChi;
import entities.NhanVien;
import entities.TaiKhoan;

import java.awt.SystemColor;

public class FrmQuanLyNhanVien extends JFrame{ //implements ActionListener, MouseListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5201032984984305728L;
	private JTextField txtTimKiem;
	private JTextField txtMaNV;
	private static JTextField txtHo;
	private static JTextField txtTen;
	private static JTextField txtSoDT;
	public static JTextField txtMaDiaChi;
	private static JTextField txtCMND;
	public static JTextField txtTenTK;
	private static DefaultTableModel model;
	private static JTable table;
	private JButton btnTimKiem;
	public static JPanel pnlTabQLNV;
	private JRadioButton radMa;
	private JRadioButton radTen;
	private JRadioButton radSoDT;
	private JRadioButton radCaLamViec;
	public static JButton btnThem;
	private JButton btnXoa;
	private JButton btnThoat;
	private JButton btnXoaRong;
	private JButton btnCapNhat;
	private JButton btnLamMoi;
	@SuppressWarnings("rawtypes")
	private static JComboBox cboGioiTinh;
	@SuppressWarnings("rawtypes")
	private static JComboBox cboMaPBan;
	@SuppressWarnings("rawtypes")
	private JComboBox cboTrangThai;
	@SuppressWarnings("rawtypes")
	private static JComboBox cboLoaiNV;
	private static JDateChooser dateChooser;
	public static boolean check = false;
     static NhanVienDAO nvDao = new NhanVienDAO();
//	FrmThemTaiKhoan frmThemTaiKhoan = new FrmThemTaiKhoan();
//	FrmThemDiaChi frmThemDiaChi = new FrmThemDiaChi();
	public static JTextField txtDiaChi;

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public FrmQuanLyNhanVien() {
		pnlTabQLNV = new JPanel();
		pnlTabQLNV.setLayout(null);
		ButtonGroup buttonGroup = new ButtonGroup();

		/**
		 * Thoat tab quan ly nhan vien
		 */

		String[] tb = new String[] { "STT", "Mã NV", "Họ", "Tên", "Ngày sinh", "Giới tính", "CMND", "Số ĐT",
				"Mã địa chỉ",	"Mã phòng ban",  "Tên TK", "Loại NV", "Trạng thái" };
		model = new DefaultTableModel(tb, 0);

		JPanel panel = new JPanel();
		panel.setBounds(10, 11, 1317, 642);
		pnlTabQLNV.add(panel);
		panel.setLayout(null);

		JLabel lblMaNV = new JLabel("Mã NV:");
		lblMaNV.setBounds(25, 73, 50, 25);
		panel.add(lblMaNV);
		lblMaNV.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		txtMaNV = new JTextField();
		txtMaNV.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		txtMaNV.setBounds(103, 73, 185, 25);
		panel.add(txtMaNV);
		txtMaNV.setToolTipText("Nhập mã nhân viên");
		txtMaNV.setColumns(10);

		txtMaNV.setEditable(false);

		txtCMND = new JTextField();
		txtCMND.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		txtCMND.setBounds(452, 109, 185, 25);
		panel.add(txtCMND);
		txtCMND.setEditable(false);
		txtCMND.setToolTipText("Nhập chứng minh nhân dân");
		txtCMND.setColumns(10);
		txtCMND.setEditable(true);
		txtCMND.addKeyListener(new KeyAdapter() {
			@Override
			public void keyTyped(KeyEvent e) {
				if (!((e.getKeyChar() >= 48 && e.getKeyChar() <= 57) || e.getKeyChar() == 8)) {
					e.consume();
				}
			}
		});

		JLabel lblCMND = new JLabel("CMND:");
		lblCMND.setBounds(375, 109, 50, 25);
		panel.add(lblCMND);
		lblCMND.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		JLabel lblTenTK = new JLabel("Tên TK:");
		lblTenTK.setBounds(682, 147, 84, 25);
		panel.add(lblTenTK);
		lblTenTK.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		JLabel lblHo = new JLabel("Họ:");
		lblHo.setBounds(375, 73, 24, 25);
		panel.add(lblHo);
		lblHo.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		txtHo = new JTextField();
		txtHo.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		txtHo.setBounds(452, 73, 185, 25);
		panel.add(txtHo);
		txtHo.setEditable(false);
		txtHo.setToolTipText("Nhập họ");
		txtHo.setColumns(10);

		txtHo.setEditable(true);

		txtTenTK = new JTextField();
		txtTenTK.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		txtTenTK.setBounds(775, 147, 185, 25);
		panel.add(txtTenTK);
		txtTenTK.setEditable(false);
		txtTenTK.setColumns(10);

		JLabel lblLoaiNV = new JLabel("Loại NV:");
		lblLoaiNV.setBounds(1000, 109, 73, 25);
		panel.add(lblLoaiNV);
		lblLoaiNV.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		JLabel lblTen = new JLabel("Tên:");
		lblTen.setBounds(682, 75, 53, 25);
		panel.add(lblTen);
		lblTen.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		txtTen = new JTextField();
		txtTen.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		txtTen.setBounds(775, 75, 185, 25);
		panel.add(txtTen);
		txtTen.setEditable(false);
		txtTen.setToolTipText("Nhập tên");
		txtTen.setColumns(10);
		txtTen.setEditable(true);

		cboLoaiNV = new JComboBox<String>();
		cboLoaiNV.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		cboLoaiNV.setBounds(1101, 109, 185, 25);
		panel.add(cboLoaiNV);
		cboLoaiNV.setToolTipText("Chọn loại nhân viên");
		cboLoaiNV.addItem("Nhân viên");
		cboLoaiNV.addItem("Quản lý");

		JLabel lblNgaySinh = new JLabel("Ngày sinh:");
		lblNgaySinh.setBounds(1000, 73, 73, 25);
		panel.add(lblNgaySinh);
		lblNgaySinh.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		dateChooser = new JDateChooser();
		dateChooser.setBounds(1101, 73, 185, 25);
		panel.add(dateChooser);
		dateChooser.getCalendarButton().setEnabled(false);
		dateChooser.setLocale(Locale.forLanguageTag("vi-VN"));
		dateChooser.setDateFormatString("dd-MM-yyyy");
		dateChooser.getCalendarButton().setEnabled(true);

		txtMaDiaChi = new JTextField();
		txtMaDiaChi.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		txtMaDiaChi.setBounds(1101, 147, 185, 25);
		panel.add(txtMaDiaChi);
		txtMaDiaChi.setEditable(false);
		txtMaDiaChi.setToolTipText("Nhập địa chỉ");
		txtMaDiaChi.setColumns(10);

		JLabel lblMaDiaChi = new JLabel("Mã địa chỉ:");
		lblMaDiaChi.setBounds(1000, 147, 80, 25);
		panel.add(lblMaDiaChi);
		lblMaDiaChi.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		JLabel lblGioiTinh = new JLabel("Giới tính:");
		lblGioiTinh.setBounds(682, 111, 84, 25);
		panel.add(lblGioiTinh);
		lblGioiTinh.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		JLabel lblTrangThai = new JLabel("Trạng thái:");
		lblTrangThai.setBounds(375, 145, 73, 25);
		panel.add(lblTrangThai);
		lblTrangThai.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		cboTrangThai = new JComboBox();
		cboTrangThai.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		cboTrangThai.setBounds(452, 145, 185, 25);
		panel.add(cboTrangThai);
		cboTrangThai.addItem("Đang làm việc");
		cboTrangThai.addItem("Nghỉ việc");
		cboTrangThai.addItem("Tạm nghỉ việc");

		cboGioiTinh = new JComboBox<String>();
		cboGioiTinh.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		cboGioiTinh.setBounds(775, 111, 185, 25);
		panel.add(cboGioiTinh);
		cboGioiTinh.setToolTipText("Chọn giới tính");
		cboGioiTinh.addItem("Nam");
		cboGioiTinh.addItem("Nữ");
		cboGioiTinh.addItem("Khác");

		JLabel lblSoDT = new JLabel("Số ĐT:");
		lblSoDT.setBounds(25, 109, 50, 25);
		panel.add(lblSoDT);
		lblSoDT.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		txtSoDT = new JTextField();
		txtSoDT.setBounds(103, 109, 185, 25);
		panel.add(txtSoDT);
		txtSoDT.setEditable(false);
		txtSoDT.setToolTipText("Nhập số điện thoại");
		txtSoDT.setColumns(10);
		txtSoDT.setEditable(true);
		txtSoDT.addKeyListener(new KeyAdapter() {
			@Override
			public void keyTyped(KeyEvent e) {
				if (!((e.getKeyChar() >= 48 && e.getKeyChar() <= 57) || e.getKeyChar() == 8)) {
					e.consume();
				}
			}
		});

		JLabel lblCaLamViec = new JLabel("Mã PBan:");
		lblCaLamViec.setBounds(25, 147, 84, 25);
		panel.add(lblCaLamViec);
		lblCaLamViec.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		cboMaPBan = new JComboBox<String>();
		cboMaPBan.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		cboMaPBan.setBounds(104, 147, 185, 25);
		panel.add(cboMaPBan);
		cboMaPBan.setToolTipText("Chọn mã phòng ban");
		cboMaPBan.addItem("PHONG_KTOAN");
		cboMaPBan.addItem("PHONG_KDOANH");
		cboMaPBan.addItem("PHONG_KTHUAT");
		cboMaPBan.addItem("PHONG_TCHUC");
		cboMaPBan.addItem("PHONG_DUAN");
		cboMaPBan.addItem("PHONG_CMON");
		cboMaPBan.addItem("PHONG_PVU");
		JLabel lblTitle = new JLabel("QUẢN LÝ NHÂN VIÊN");
		lblTitle.setBounds(512, 11, 278, 38);
		panel.add(lblTitle);
		lblTitle.setFont(new Font("Times New Roman", Font.BOLD, 25));
		lblTitle.setForeground(Color.RED);
		lblTitle.setHorizontalAlignment(SwingConstants.CENTER);

		JPanel pnlDanhSachNhanVien = new JPanel();
		pnlDanhSachNhanVien.setBounds(10, 237, 1297, 257);
		panel.add(pnlDanhSachNhanVien);
		pnlDanhSachNhanVien.setLayout(null);
		pnlDanhSachNhanVien.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"),
				"Danh s\u00E1ch nh\u00E2n vi\u00EAn", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		pnlDanhSachNhanVien.setBackground(SystemColor.control);

		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		scrollPane.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
		scrollPane.setBounds(10, 20, 1277, 226);
		pnlDanhSachNhanVien.add(scrollPane);
		table = new JTable(model);
		table.setFont(new Font("Times New Roman", Font.PLAIN, 14));
		scrollPane.setViewportView(table);

		JLabel lblDiaChi = new JLabel("Địa chỉ:");
		lblDiaChi.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		lblDiaChi.setBounds(682, 181, 72, 25);
		panel.add(lblDiaChi);

		txtDiaChi = new JTextField();
		txtDiaChi.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		txtDiaChi.setEditable(false);
		txtDiaChi.setBounds(775, 182, 509, 25);
		panel.add(txtDiaChi);
		txtDiaChi.setColumns(10);

		btnThem = new JButton("Thêm");
		btnThem.setBounds(103, 196, 120, 30);
		panel.add(btnThem);
		btnThem.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		btnThem.setIcon(new ImageIcon("Hinh\\add.png"));

		btnXoa = new JButton("Xóa");
		btnXoa.setBounds(233, 196, 120, 30);
		panel.add(btnXoa);
		btnXoa.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		btnXoa.setIcon(new ImageIcon("Hinh\\delete.png"));

		btnCapNhat = new JButton("Cập nhật");
		btnCapNhat.setBounds(363, 196, 120, 30);
		panel.add(btnCapNhat);
		btnCapNhat.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		btnCapNhat.setIcon(new ImageIcon("Hinh\\edit.png"));

		btnXoaRong = new JButton("Xóa Trắng");
		btnXoaRong.setBounds(493, 196, 131, 30);
		panel.add(btnXoaRong);
		btnXoaRong.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		btnXoaRong.setIcon(new ImageIcon("Hinh\\empty.png"));

		JPanel panel_3 = new JPanel();
		panel_3.setBounds(10, 505, 1297, 114);
		panel.add(panel_3);
		panel_3.setBorder(
				new TitledBorder(null, "T\u00ECm ki\u1EBFm", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		panel_3.setLayout(null);

		JLabel lblTimKiem = new JLabel("Nhập thông tin tìm kiếm:");
		lblTimKiem.setBounds(10, 11, 161, 30);
		panel_3.add(lblTimKiem);
		lblTimKiem.setFont(new Font("Times New Roman", Font.PLAIN, 14));

		JLabel lblTimTheo = new JLabel("Tìm theo:");
		lblTimTheo.setBounds(10, 56, 63, 30);
		panel_3.add(lblTimTheo);
		lblTimTheo.setFont(new Font("Times New Roman", Font.PLAIN, 15));

		radMa = new JRadioButton("Mã");
		radMa.setBounds(79, 48, 63, 23);
		panel_3.add(radMa);
		radMa.setFont(new Font("Times New Roman", Font.PLAIN, 14));
		buttonGroup.add(radMa);

		radTen = new JRadioButton("Tên");
		radTen.setBounds(79, 74, 63, 23);
		panel_3.add(radTen);
		radTen.setFont(new Font("Times New Roman", Font.PLAIN, 14));
		buttonGroup.add(radTen);

		radCaLamViec = new JRadioButton("Mã phòng ban");
		radCaLamViec.setBounds(144, 76, 120, 23);
		panel_3.add(radCaLamViec);
		radCaLamViec.setFont(new Font("Times New Roman", Font.PLAIN, 14));
		buttonGroup.add(radCaLamViec);

		radSoDT = new JRadioButton("Số ĐT");
		radSoDT.setBounds(144, 48, 94, 23);
		panel_3.add(radSoDT);
		radSoDT.setFont(new Font("Times New Roman", Font.PLAIN, 14));
		buttonGroup.add(radSoDT);

		txtTimKiem = new JTextField();
		txtTimKiem.setBounds(165, 15, 232, 25);
		panel_3.add(txtTimKiem);
		txtTimKiem.setColumns(10);

		btnTimKiem = new JButton("Tìm kiếm");
		btnTimKiem.setBounds(277, 56, 120, 30);
		panel_3.add(btnTimKiem);
		btnTimKiem.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		btnTimKiem.setIcon(new ImageIcon("Hinh\\search.png"));

		btnLamMoi = new JButton("Làm Mới");
		btnLamMoi.setBounds(407, 56, 120, 30);
		panel_3.add(btnLamMoi);
		btnLamMoi.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		btnLamMoi.setIcon(new ImageIcon("Hinh\\refresh.png"));
		btnThoat = new JButton("Thoát");
		btnThoat.setBounds(537, 56, 120, 30);
		panel_3.add(btnThoat);
		btnThoat.setForeground(Color.BLACK);
		btnThoat.setBackground(UIManager.getColor("InternalFrame.inactiveTitleGradient"));
		btnThoat.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		btnThoat.setIcon(new ImageIcon("Hinh\\close.png"));

		JLabel lblXinChao = new JLabel("Xin chào !");
		lblXinChao.setForeground(Color.RED);
		lblXinChao.setFont(new Font("Times New Roman", Font.PLAIN, 15));
		lblXinChao.setBounds(1028, 44, 84, 22);
		panel.add(lblXinChao);

		JLabel lblTenNV = new JLabel("");
		lblTenNV.setForeground(Color.RED);
		lblTenNV.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		lblTenNV.setBounds(1122, 44, 185, 23);
		panel.add(lblTenNV);

//		String tenNhanVienHienTai = nvDao.getTenNhanVienByTenTaiKhoan(FrmDangNhap.taiKhoan.getTenTaiKhoan());
//		lblTenNV.setText(tenNhanVienHienTai);

//		btnThoat.addActionListener(this);
//		btnLamMoi.addActionListener(this);
//		btnTimKiem.addActionListener(this);
//		btnXoaRong.addActionListener(this);
//
//		btnCapNhat.addActionListener(this);
//		btnXoa.addActionListener(this);
//		btnThem.addActionListener(this);
//		table.addMouseListener(this);

		docDuLieu();
	}
	public static void docDuLieu() {
		try {
			ArrayList<NhanVien> dsNV = nvDao.getAllTBNhanVien();
			int i = 0;
			for (NhanVien nhanVien : dsNV) {
				i++;
				model.addRow(new Object[] { i + "", nhanVien.getMaNhanVien() + "", nhanVien.getHo(),
						nhanVien.getTen(), nhanVien.getNgaySinh(), nhanVien.getGioiTinh(),
						nhanVien.getCmnd(), nhanVien.getSoDienThoai(), 
						nhanVien.getDiaChi().getMaDiaChi() + "",nhanVien.getPhongBan().getMaPhongBan(),
						nhanVien.getTaiKhoan().getTenTaiKhoan(),
						nhanVien.getLoaiNhanVien(), nhanVien.getTrangThai() });
			}
			table.setModel(model);
		} catch (Exception e) {
			e.printStackTrace();

		}
	}
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					FrmQuanLyNhanVien frame = new FrmQuanLyNhanVien();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}	
	}


