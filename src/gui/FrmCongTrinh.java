package gui;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.border.BevelBorder;
import java.awt.Color;
import javax.swing.JSplitPane;
import javax.swing.border.TitledBorder;
import javax.swing.border.EtchedBorder;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import java.awt.Font;
import java.awt.Image;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFileChooser;
import javax.swing.JTable;
import javax.swing.JScrollPane;
import javax.swing.JScrollBar;
import javax.swing.table.DefaultTableModel;

import org.jdesktop.swingx.autocomplete.AutoCompleteDecorator;

//import dao.NhaCungCapDAO;
//import dao.ThuocDAO;
//import database.ConectDatabase;
//import entities.NhaCungCap;
//import entities.Thuoc;


import javax.swing.ScrollPaneConstants;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.awt.event.ActionEvent;

import javax.imageio.ImageIO;
import javax.swing.ButtonGroup;
import javax.swing.DefaultComboBoxModel;
import javax.swing.ImageIcon;
import javax.swing.UIManager;
import javax.swing.SwingConstants;
import java.awt.SystemColor;
import com.toedter.calendar.JDateChooser;
import com.toedter.calendar.JTextFieldDateEditor;

import java.util.Locale;
import javax.swing.JRadioButton;

public class FrmCongTrinh extends JFrame {

	public static JPanel contentPane;
	
	private JTextField txtMa;
	private JTextField txtNgayKC,txtNgayCPXD ;
	private JTextField txtNgayDKHT,txtTenCT,txtDiaDiem;
	private JTable tblHoaDon;
	private JTextField txtNVLap;
	private JTable tblThuoc;
	private JTextField txtThuoc_DBC;
	private DefaultTableModel tbModel = new DefaultTableModel();
	private JComboBox cmbDonViTinh,cmbPhanLoai,cmbTrangThai,cmbNhomThuoc,cmbTim;
	public static JComboBox cmbNCC;
	private JDateChooser dateNgaySX,dateHanSD;
	//private ThuocDAO dao= new ThuocDAO();
	//private NhaCungCapDAO dao_NCC= new NhaCungCapDAO();
	private JTextField txtHoatChat;
	private JTextField txtHamLuong;
	private String filename = null;
	private byte[] imageThuoc;
	private JLabel lblAnhThuoc;
	private JRadioButton radNgayCPXD,radMa,radNgayKC,radDD,radTenCT;
	private DefaultComboBoxModel cboModeNCC= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModePhanLoai= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeDonViTinh= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeTrangThai= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeNhomThuoc= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeTim= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeMa= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeTenThuoc= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeTimPhanLoai= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeTimNhomThuoc= new DefaultComboBoxModel();
	private DefaultComboBoxModel cboModeTimNCC= new DefaultComboBoxModel();
	
	
	private JButton btnLamMoi;
	private List<String> listPhanLoai= new ArrayList<>();
	private List<String> listDonViTinh= new ArrayList<>();
	private List<String> listNhomThuoc= new ArrayList<>();	
	private List<String> listTrangThai= new ArrayList<>();
	private List<String> listNCC= new ArrayList<>();
	private List<String> listMa= new ArrayList<>();
	private List<String> listTenThuoc= new ArrayList<>();
	private List<String> listTimPhanLoai= new ArrayList<>();
	private List<String> listTimNhomThuoc= new ArrayList<>();
	private List<String> listTimNCC= new ArrayList<>();
	
	///
	public static JButton btnThem,btnThemNCC,btnThemNhomThuoc,btnThemPhanLoai,btnThemTrangThai,btnThemDVT;
	public static JPanel pnlChucNang;
	public static JButton btnXoa;
	public static JButton btnLuu;
	public static JButton btnSua;
	private int trangThaiThem;
	private int trangThaiSua;
	//private FrmThemNhaCungCap frmthemNCC=new FrmThemNhaCungCap();

	/**
	 * Launch the application.
	 */


	/**
	 * Create the frame.
	 */
	public FrmCongTrinh() {
		trangThaiThem=0;
		trangThaiSua=0;

		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 1351,686);
		setLocationRelativeTo(null);
		contentPane = new JPanel();
		contentPane.setBackground(new Color(176, 224, 230));
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);

		JPanel pnl_Thuoc = new JPanel();
		pnl_Thuoc.setBackground(new Color(176, 224, 230));
		pnl_Thuoc.setBounds(10, -23, 1323, 684);
		contentPane.add(pnl_Thuoc);
		pnl_Thuoc.setLayout(null);

		JPanel pnlNoiDung = new JPanel();
		pnlNoiDung.setBackground(new Color(173, 216, 230));
		pnlNoiDung.setBorder(new TitledBorder(new EtchedBorder(EtchedBorder.LOWERED, new Color(255, 255, 255), new Color(160, 160, 160)), "Nội dung quản lý", TitledBorder.LEADING, TitledBorder.TOP, null, Color.BLACK));
		pnlNoiDung.setBounds(20, 70, 1300, 240);
		pnl_Thuoc.add(pnlNoiDung);
		pnlNoiDung.setLayout(null);

		JLabel lblMCT = new JLabel("Mã Công Trình :");
		lblMCT.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblMCT.setBounds(10, 22, 200, 20);
		 pnlNoiDung.add(lblMCT);
      int w=1050;
		txtMa = new JTextField();
		txtMa.setEnabled(false);
		txtMa.setBounds(220, 22, w, 30);
		 pnlNoiDung.add(txtMa);
		txtMa.setColumns(10);
		
		JLabel lblTenCT = new JLabel("Tên CT:");
		lblTenCT.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblTenCT.setBounds(10, 58, 200, 30);
		 pnlNoiDung.add(lblTenCT);

		txtTenCT = new JTextField();
		txtTenCT.setBounds(220, 58, w, 30);
		 pnlNoiDung.add(txtTenCT);
		txtTenCT.setColumns(10);
		
		JLabel lblDiaDiem = new JLabel("Đia Điểm:");
		lblDiaDiem.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblDiaDiem.setBounds(10, 98, 200, 30);
		 pnlNoiDung.add(lblDiaDiem);

		txtDiaDiem = new JTextField();
		txtDiaDiem.setBounds(220, 98, w, 30);
		 pnlNoiDung.add(txtDiaDiem);
		txtDiaDiem.setColumns(10);
		

		JLabel lblNgayCPXD = new JLabel("Ngày cấp phép xây dựng:");
		lblNgayCPXD.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblNgayCPXD.setBounds(10, 132, 200, 30);
		 pnlNoiDung.add(lblNgayCPXD);
		
		txtNgayCPXD = new JTextField();
		txtNgayCPXD.setColumns(10);
		txtNgayCPXD.setBounds(220, 132, w, 30);
		 pnlNoiDung.add(txtNgayCPXD);
		 
			JLabel lblNgayKC = new JLabel("Ngày khởi công:");
			lblNgayKC.setFont(new Font("Times New Roman", Font.PLAIN, 20));
			lblNgayKC.setBounds(10, 167, 200, 30);
			 pnlNoiDung.add(lblNgayKC);
			
			txtNgayKC = new JTextField();
			txtNgayKC.setBounds(220, 165, w, 30);
			 pnlNoiDung.add(txtNgayKC);
			txtNgayKC.setColumns(10);
		 
		JLabel lblNgayDKHT = new JLabel("Ngày dự kiến HT :");
		lblNgayDKHT.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblNgayDKHT.setBounds(10, 202, 200, 30);
       	 pnlNoiDung.add(lblNgayDKHT);

		
       	txtNgayDKHT = new JTextField();
		txtNgayDKHT.setBounds(220, 202, w, 30);
		 pnlNoiDung.add(txtNgayDKHT);
		txtNgayDKHT.setColumns(10);
		
		

		

		


		
	

		

		JPanel pnlDsthuoc = new JPanel();
		pnlDsthuoc.setBackground(new Color(176, 224, 230));
		pnlDsthuoc.setBounds(10, 313, 1313, 206);
		pnl_Thuoc.add(pnlDsthuoc);
		pnlDsthuoc.setLayout(null);
		cboModeTim.addElement("Tìm kiếm theo:");
		cboModeTim.addElement("Tìm theo mã công  trình.");
		cboModeTim.addElement("Tìm theo tên công trình.");
		cboModeTim.addElement("Tìm theo địa điểm.");
		cboModeTim.addElement("Tìm theo ngầy cấp phép.");
		cboModeTim.addElement("Tìm theo ngày khởi công.");

		JPanel pnl_4_Thuoc = new JPanel();

		pnl_4_Thuoc.setBounds(10, 11, 1293, 191);
		pnlDsthuoc.add(pnl_4_Thuoc);
		pnl_4_Thuoc.setLayout(null);
		/*
		 * Tạo Table
		 */

		JScrollPane scrollPaneThuoc = new JScrollPane();
		scrollPaneThuoc.setToolTipText("qq\r\n");
		scrollPaneThuoc.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		scrollPaneThuoc.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
		scrollPaneThuoc.setBounds(10, 11, 1273, 168);
		pnl_4_Thuoc.add(scrollPaneThuoc);
		String[] colsname= {"STT", "Mã công trình","Tên công trình" ,"Đia điểm","Ngày cấp phép xây dựng","Ngày khởi công" ,"Ngày dự kiến hoàn thành"};

		tbModel=new DefaultTableModel(colsname,0);
		tblThuoc = new JTable(tbModel);
		tblThuoc.setDefaultEditor(Object.class, null);
		scrollPaneThuoc.setViewportView(tblThuoc);
		tblThuoc.getColumnModel().getColumn(0).setPreferredWidth(100);
		tblThuoc.getColumnModel().getColumn(1).setPreferredWidth(220);
		tblThuoc.getColumnModel().getColumn(2).setPreferredWidth(220);
		tblThuoc.getColumnModel().getColumn(3).setPreferredWidth(220);
		tblThuoc.getColumnModel().getColumn(4).setPreferredWidth(220);
		tblThuoc.getColumnModel().getColumn(5).setPreferredWidth(220);
		tblThuoc.getColumnModel().getColumn(6).setPreferredWidth(220);


		tblThuoc.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

		tblThuoc.addMouseListener(new MouseListener() {

			@Override
			public void mouseReleased(MouseEvent e) {
				// TODO Auto-generated method stub
//				try {
//					hienTable();
//				} catch (Exception e2) {
//					// TODO: handle exception
//				}
				
			}

			@Override
			public void mousePressed(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			@Override
			public void mouseExited(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			@Override
			public void mouseEntered(MouseEvent e) {
				// TODO Auto-generated method stub

			}

			@Override
			public void mouseClicked(MouseEvent e) {
				// TODO Auto-generated method stub

			}
		});

		JPanel pnlTitile = new JPanel();
		pnlTitile.setBackground(new Color(176, 224, 230));
		pnlTitile.setBounds(18, 11, 1295, 48);
		pnl_Thuoc.add(pnlTitile);
		pnlTitile.setLayout(null);

		JLabel lblTitiel = new JLabel("Quản Lý Công Trình");
		lblTitiel.setBounds(0, 13, 1285, 28);
		pnlTitile.add(lblTitiel);
		lblTitiel.setForeground(Color.RED);
		lblTitiel.setFont(new Font("Tahoma", Font.BOLD, 20));
		lblTitiel.setHorizontalAlignment(SwingConstants.CENTER);
		lblTitiel.setBackground(Color.RED);

		pnlChucNang = new JPanel();
		pnlChucNang.setBackground(new Color(176, 224, 230));
		pnlChucNang.setBorder(new TitledBorder(null, "Ch\u1EE9c n\u0103ng", TitledBorder.LEADING, TitledBorder.TOP, null, null));
		pnlChucNang.setBounds(10, 521, 1303, 129);
		pnl_Thuoc.add(pnlChucNang);
		pnlChucNang.setLayout(null);

		btnThem = new JButton("Thêm ");
		btnThem.setBackground(Color.LIGHT_GRAY);
		btnThem.setHorizontalAlignment(SwingConstants.LEFT);
		btnThem.setIcon(new ImageIcon("Hinh\\add.png"));
		btnThem.setBounds(10, 93, 102, 30);
		pnlChucNang.add(btnThem);
		btnThem.setFont(new Font("Times New Roman", Font.BOLD, 12));

		btnXoa = new JButton("Xóa\r\n");
		btnXoa.setBackground(Color.LIGHT_GRAY);
		btnXoa.setIcon(new ImageIcon("Hinh\\delete.png"));
		btnXoa.setHorizontalAlignment(SwingConstants.LEFT);
		btnXoa.setBounds(122, 92, 106, 30);
		pnlChucNang.add(btnXoa);
		btnXoa.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnXoa.setFont(new Font("Times New Roman", Font.BOLD, 15));

		btnLuu = new JButton("Lưu");
		btnLuu.setBackground(Color.LIGHT_GRAY);
		btnLuu.setHorizontalAlignment(SwingConstants.LEFT);
		btnLuu.setEnabled(false);
		btnLuu.setBounds(354, 92, 106, 30);
		pnlChucNang.add(btnLuu);
		btnLuu.setIcon(new ImageIcon("Hinh\\yes.png"));
		btnLuu.setFont(new Font("Times New Roman", Font.BOLD, 15));

		JButton btnThoat = new JButton("Thoát");
		btnThoat.setBackground(Color.LIGHT_GRAY);
		btnThoat.setIcon(new ImageIcon("Hinh\\exit.png"));
		btnThoat.setHorizontalAlignment(SwingConstants.LEFT);
		btnThoat.setBounds(1175, 92, 118, 30);
		pnlChucNang.add(btnThoat);
		btnThoat.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnThoat.setFont(new Font("Times New Roman", Font.BOLD, 15));

		btnSua = new JButton("Sửa");
		btnSua.setBackground(Color.LIGHT_GRAY);
		btnSua.setHorizontalAlignment(SwingConstants.LEFT);
		btnSua.setIcon(new ImageIcon("Hinh\\edit.png"));
		btnSua.setFont(new Font("Times New Roman", Font.BOLD, 15));
		btnSua.setBounds(238, 92, 106, 30);
		pnlChucNang.add(btnSua);

		btnLamMoi = new JButton("LÀM MỚI");
		btnLamMoi.setBackground(Color.LIGHT_GRAY);
		btnLamMoi.setIcon(new ImageIcon("Hinh\\refresh.png"));
		btnLamMoi.setHorizontalAlignment(SwingConstants.LEFT);
		btnLamMoi.setFont(new Font("Times New Roman", Font.BOLD, 15));
		btnLamMoi.setBounds(483, 92, 132, 30);
		pnlChucNang.add(btnLamMoi);
		
		JPanel panel = new JPanel();
		panel.setLayout(null);
		panel.setBorder(new TitledBorder(UIManager.getBorder("TitledBorder.border"),

						"T\u00ECm ki\u1EBFm h\u00F3a \u0111\u01A1n", TitledBorder.LEADING, TitledBorder.TOP, null,

						new Color(255, 0, 0)));
		panel.setBackground(new Color(176, 224, 230));
		panel.setBounds(10, 13, 1283, 72);
		pnlChucNang.add(panel);
		
		JButton btnTim = new JButton("Tìm kiếm");
		btnTim.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		btnTim.setBounds(976, 16, 127, 25);
		panel.add(btnTim);
		
		JLabel label = new JLabel("Nhập thông tin tìm kiếm:");
		label.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		label.setBounds(20, 18, 162, 25);
		panel.add(label);
		
		JLabel label_1 = new JLabel("Tìm theo:");
		label_1.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		label_1.setBounds(30, 43, 63, 25);
		panel.add(label_1);
		
		radMa = new JRadioButton("Mã công trình");
		radMa.setSelected(true);
		radMa.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radMa.setBounds(174, 43, 184, 22);
		panel.add(radMa);
		
		radTenCT = new JRadioButton("Tên công trình");
		radTenCT.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radTenCT.setBounds(360, 43, 184, 22);	
		panel.add(radTenCT);
		
		radDD = new JRadioButton("Địa điểm");
		radDD.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radDD.setBounds(546, 43, 184, 22);
		panel.add(radDD);
		
		radNgayCPXD = new JRadioButton("Ngày cấp phép xây dựng");
		radNgayCPXD.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radNgayCPXD.setBounds(918, 43, 184, 22);
		panel.add(radNgayCPXD);
		
		
		
		radNgayKC = new JRadioButton("Ngày khởi công");
		radNgayKC.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radNgayKC.setBounds(732, 43, 184, 22);
		panel.add(radNgayKC);
		
		cmbTim = new JComboBox();
		cmbTim.setBounds(174, 18, 781, 22);
		panel.add(cmbTim);
		
		
		
		ButtonGroup group = new ButtonGroup();
		group.add(radMa);
		group.add(radDD);
		group.add(radNgayKC);
		group.add(radNgayCPXD);
		group.add(radTenCT);
		
	
	}
		
		
			
		
		
		
	/** Dùng để lấy dự liệu từ sql lên bảng
	 * 
	 */
//	public void docDuLieu() {
//		int d=1;
//		List<Thuoc> list = dao.getThuoc();
//		for(Thuoc x:list) {
//			SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
//			tbModel.addRow(new Object[] {
//					d++,x.getMaThuoc(),x.getSoDangky(),x.getTenThuoc(),x.getPhanLoai(),x.getNhomThuoc(),x.getHamLuong(),x.getHoatChat(),x.getDangBaoChe(),
//					x.getQuyCach(),x.getTieuChuan(),x.getNhaCungcap().getTenNCC(),df.format(x.getNgaySanXuat()) ,df.format(x.getHanSuDung() ),x.getDonViTinh(),x.getGiaNhap(),
//					x.getDonGia(),x.getSoLuongNhap(),x.getTrangThai()
//			});
//			if(listPhanLoai.contains(x.getPhanLoai())==false) {
//				cboModePhanLoai.addElement(x.getPhanLoai());
//				cmbPhanLoai.setModel(cboModePhanLoai);	
//				listPhanLoai.add(x.getPhanLoai());
//			}
//			if(listDonViTinh.contains(x.getDonViTinh())==false) {
//				cboModeDonViTinh.addElement(x.getDonViTinh());
//				cmbDonViTinh.setModel(cboModeDonViTinh);	
//				listDonViTinh.add(x.getDonViTinh());
//			}
//			if(listNhomThuoc.contains(x.getNhomThuoc())==false) {
//				cboModeNhomThuoc.addElement(x.getNhomThuoc());
//				cmbNhomThuoc.setModel(cboModeNhomThuoc);
//				listNhomThuoc.add(x.getNhomThuoc());
//			}
//			if(listTrangThai.contains(x.getTrangThai())==false) {
//				cboModeTrangThai.addElement(x.getTrangThai());
//				cmbTrangThai.setModel(cboModeTrangThai);	
//				listTrangThai.add(x.getTrangThai());
//			}
//			if(listMa.contains(String.valueOf(x.getMaThuoc()))==false) {
//				cboModeMa.addElement(x.getMaThuoc());
//				listMa.add(String.valueOf(x.getMaThuoc()));
//			}
//			if(listTenThuoc.contains(x.getTenThuoc())==false) {
//				cboModeTenThuoc.addElement(x.getTenThuoc());
//				listTenThuoc.add(x.getTenThuoc());
//			}
//			if(listTimPhanLoai.contains(x.getPhanLoai())==false) {
//				cboModeTimPhanLoai.addElement(x.getPhanLoai());
//				listTimPhanLoai.add(x.getPhanLoai());
//			}
//			if(listTimNhomThuoc.contains(x.getNhomThuoc())==false) {
//				cboModeTimNhomThuoc.addElement(x.getNhomThuoc());
//				listTimNhomThuoc.add(x.getNhomThuoc());
//			}
//		}	
//		dao.getTenCungCaps().forEach(x->{
//			if(listNCC.contains(x)==false) {
//				cboModeNCC.addElement(x);
//				cmbNCC.setModel(cboModeNCC);	
//				listNCC.add(x);
//			}
//			if(listTimNCC.contains(x)==false) {
//				cboModeTimNCC.addElement(x);
//				listTimNCC.add(x);
//			}
//		});
//	}
	/**
	 * Dùng để hiện thị các text và combobox từ bảng lên 
	 */
//	public void hienTable() {
//		int row;
//		int rowCount;
//		row=tblThuoc.getSelectedRow();
//		txtThuoc_Ma.setText(tbModel.getValueAt(row, 1).toString());
//		txtThuoc_SDK.setText(tbModel.getValueAt(row, 2).toString());
//		txtThuoc_Ten.setText(tbModel.getValueAt(row, 3).toString());
//		cmbPhanLoai.setSelectedItem(dao.getThuoc().get(row).getPhanLoai());
//		cmbNhomThuoc.setSelectedItem(dao.getThuoc().get(row).getNhomThuoc());
//		txtHamLuong.setText(tblThuoc.getValueAt(row, 6).toString());	
//		txtHoatChat.setText(tblThuoc.getValueAt(row, 7).toString());
//		txtThuoc_DBC.setText(tbModel.getValueAt(row, 8).toString().toString());
//		txtThuoc_QuyCach.setText(tbModel.getValueAt(row, 9).toString());
//		txtThuoc_TieuChuan.setText(tbModel.getValueAt(row, 10).toString());
//		cmbNCC.setSelectedItem(tbModel.getValueAt(row,11).toString());
//		dateNgaySX.setDate(dao.getThuoc().get(row).getNgaySanXuat());
//		dateHanSD.setDate(dao.getThuoc().get(row).getHanSuDung());
//		cmbDonViTinh.setSelectedItem(tbModel.getValueAt(row, 14));
//		txtThuoc_GiaNhap.setText(tbModel.getValueAt(row, 15).toString());
//		txtThuoc_DonGia.setText(tbModel.getValueAt(row, 16).toString());
//		txtThuoc_SLN.setText(tbModel.getValueAt(row, 17).toString());
//		cmbTrangThai.setSelectedItem(dao.getThuoc().get(row).getTrangThai());
//		try {
//			byte[] img=dao.getThuoc().get(row).getHinhAnh();
//			ImageIcon ima=new ImageIcon(new ImageIcon(img).getImage().getScaledInstance(lblAnhThuoc.getWidth(), lblAnhThuoc.getHeight(), Image.SCALE_SMOOTH));
//			lblAnhThuoc.setIcon(ima);
//			imageThuoc=img;
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//	}
	/**
	 * Mở giao diên sửa 
	 */
	public void sua()  {
		btnThemDVT.setEnabled(true);
		btnThemNCC.setEnabled(true);
		btnThemNhomThuoc.setEnabled(true);
		btnThemPhanLoai.setEnabled(true);
		btnThemTrangThai.setEnabled(true);
		txtHamLuong.setEditable(true);
		txtHoatChat.setEditable(true);
		txtThuoc_DBC.setEditable(true);
		
		cmbPhanLoai.setSelectedItem("Không kê đơn");
		btnSua.setText("Hủy");
		trangThaiSua=1;
		btnThem.setEnabled(false);
		btnLuu.setEnabled(true);
	}
	/**
	 * Dùng để lưu các các thuộc tính đã thêm hoặc sửa 
	 * @throws ParseException
	 */
	public void luu() throws ParseException {
		SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");
		
		String phanLoai= (String) cmbPhanLoai.getSelectedItem();
		String nhomThuoc= (String) cmbNhomThuoc.getSelectedItem();
		String hoatChat= txtHoatChat.getText().toString();
		String hamLuong= txtHamLuong.getText().toString();
		String dangBaoChe= txtThuoc_DBC.getText().toString();
	
		String tenNCC= (String) cmbNCC.getSelectedItem();
		Date ngaySX = dateNgaySX.getDate();
		Date ngaySD= dateHanSD.getDate();
		String donViTinh= (String) cmbDonViTinh.getSelectedItem();
		
		String trangThai= (String) cmbTrangThai.getSelectedItem();
//		if(trangThaiThem != 0 && trangThaiSua==0) {
//			if(kiemTra()==true) {
//				dao.them(soDangKi, tenThuoc, phanLoai,nhomThuoc,hoatChat, hamLuong, dangBaoChe, quyCach, tieuChuan, dao.getmaNCC(tenNCC), ngaySX, ngaySD, donViTinh, Float.parseFloat(gn), Float.parseFloat(dg), Integer.parseInt(sl), imageThuoc,trangThai);
//				JOptionPane.showMessageDialog(this, "Thêm thành công ");
//				btnThem.setText("Thêm");
//				btnSua.setEnabled(true);
//				btnLuu.setEnabled(false);
//				trangThaiThem=0;
//			}
//			else {
//				return;
//			}
//			
//		}
//		else if(trangThaiThem == 0 && trangThaiSua != 0) {
//			if(kiemTra()==true) {
//				String m = txtThuoc_Ma.getText();
//				int ma=0;
//				ma= Integer.parseInt(m);
//			//	dao.sua(ma, soDangKi, tenThuoc, phanLoai, nhomThuoc, hoatChat, hamLuong, dangBaoChe, quyCach, tieuChuan, dao.getmaNCC(tenNCC), ngaySX, ngaySD, donViTinh, Float.parseFloat(gn), Float.parseFloat(dg), Integer.parseInt(sl), imageThuoc, trangThai);
//				JOptionPane.showMessageDialog(this, "Sữa Thành Công");
//				btnThem.setEnabled(true);
//				btnSua.setText("Sửa");
//				btnLuu.setEnabled(false);
//				trangThaiSua=0;
//			}
//			else {
//				return;
//			}
//		}
//		lamMoi();

	}
	/**
	 * Dùng để mở giao diện thêm phân loại thuốc mới
	 */
	public void themPhanLoai() {
		String moi= JOptionPane.showInputDialog(this, "Phân loại mới");
		cmbPhanLoai.setSelectedItem(moi);
	}
	/**
	 * Dùng để mở giao diện thêm đơn vị tính thuốc mới
	 */
	public void themDonViTinh() {
		String moi= JOptionPane.showInputDialog(this, "Đơn vị tính mới");
		cmbDonViTinh.setSelectedItem(moi);
	}
	/**
	 * Dùng để mở giao diện thêm nhóm thuốc thuốc mới
	 */
	public void themNhomThuoc() {
		String moi= JOptionPane.showInputDialog(this, "Nhóm thuốc mới");
		cmbNhomThuoc.setSelectedItem(moi);
	}
	/**
	 * Dùng để mở giao diện thêm trạng thái thuốc mới
	 */
	public void themTrangThai() {
		String moi= JOptionPane.showInputDialog(this, "Trạng thái mới");
		cmbTrangThai.setSelectedItem(moi);
	}
	
	/**
	 * Mở giao diện thêm
	 */
	public void them() {
		lamMoi();
		btnThemDVT.setEnabled(true);
		btnThemNCC.setEnabled(true);
		btnThemNhomThuoc.setEnabled(true);
		btnThemPhanLoai.setEnabled(true);
		btnThemTrangThai.setEnabled(true);
		txtHamLuong.setEditable(true);
		txtHoatChat.setEditable(true);
		txtThuoc_DBC.setEditable(true);
	
		btnThem.setText("Hủy");
		cmbPhanLoai.setSelectedItem("Không kê đơn");
		cmbTrangThai.setSelectedItem("Đang bán");
		trangThaiThem=1;
		btnSua.setEnabled(false);
		btnLuu.setEnabled(true);
	}
	/**
	 * Dùng để xóa thuốc.
	 */
	public void xoa() {
		int i=JOptionPane.showConfirmDialog(this, "Bạn có chắ muốn chuyển sang trạng thái ngừng bán");
		if(i==0) {
		//	dao.xoa(Integer.parseInt(txtThuoc_Ma.getText()));
			lamMoi();
		}
		else if(i==1) {
			return;
		}

	}
	/**
	 * Dùng để xóa dữ liệu bảng
	 */
	public void xoaTable() {
		tbModel.addRow(new Object[] {

		});
		DefaultTableModel tbl = (DefaultTableModel) tblThuoc.getModel();
		tbl.getDataVector().removeAllElements();	
	}
	/**
	 * Dùng để làm mới giao diện
	 */
	public void lamMoi() {
	
		cmbPhanLoai.setSelectedItem("");
		txtHoatChat.setText("");
		txtHamLuong.setText("");	
		txtThuoc_DBC.setText("");
		
		cmbNCC.setSelectedItem("");
		cmbDonViTinh.setSelectedItem("");
	
		cmbTrangThai.setSelectedItem("");
		cmbNCC.setSelectedItem("");
		cmbDonViTinh.setSelectedItem("");
		cmbNhomThuoc.setSelectedItem("");
		cmbTrangThai.setSelectedItem("");
		txtHamLuong.setEditable(false);
		txtHoatChat.setEditable(false);
		txtThuoc_DBC.setEditable(false);
		
		xoaTable();
		//docDuLieu();
		lblAnhThuoc.setIcon(null);
		btnSua.setText("Sửa");
		btnSua.setEnabled(true);
		trangThaiSua=0;
		btnThem.setText("Thêm");
		trangThaiThem=0;
		btnThem.setEnabled(true);
		
		btnThemDVT.setEnabled(false);
		btnThemNCC.setEnabled(false);
		btnThemNhomThuoc.setEnabled(false);
		btnThemPhanLoai.setEnabled(false);
		btnThemTrangThai.setEnabled(false);
	
	}
	/**
	 * Dùng để tìm kiếm thuốc.
	 */

	public static void main(String[] args) {
		new FrmCongTrinh().setVisible(true);
	}
}
