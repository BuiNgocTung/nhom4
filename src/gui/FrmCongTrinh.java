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
		pnlNoiDung.setBorder(new TitledBorder(new EtchedBorder(EtchedBorder.LOWERED, new Color(255, 255, 255), new Color(160, 160, 160)), "N???i dung qu???n l??", TitledBorder.LEADING, TitledBorder.TOP, null, Color.BLACK));
		pnlNoiDung.setBounds(20, 70, 1300, 240);
		pnl_Thuoc.add(pnlNoiDung);
		pnlNoiDung.setLayout(null);

		JLabel lblMCT = new JLabel("M?? C??ng Tr??nh :");
		lblMCT.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblMCT.setBounds(10, 22, 200, 20);
		 pnlNoiDung.add(lblMCT);
      int w=1050;
		txtMa = new JTextField();
		txtMa.setEnabled(false);
		txtMa.setBounds(220, 22, w, 30);
		 pnlNoiDung.add(txtMa);
		txtMa.setColumns(10);
		
		JLabel lblTenCT = new JLabel("T??n CT:");
		lblTenCT.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblTenCT.setBounds(10, 58, 200, 30);
		 pnlNoiDung.add(lblTenCT);

		txtTenCT = new JTextField();
		txtTenCT.setBounds(220, 58, w, 30);
		 pnlNoiDung.add(txtTenCT);
		txtTenCT.setColumns(10);
		
		JLabel lblDiaDiem = new JLabel("??ia ??i???m:");
		lblDiaDiem.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblDiaDiem.setBounds(10, 98, 200, 30);
		 pnlNoiDung.add(lblDiaDiem);

		txtDiaDiem = new JTextField();
		txtDiaDiem.setBounds(220, 98, w, 30);
		 pnlNoiDung.add(txtDiaDiem);
		txtDiaDiem.setColumns(10);
		

		JLabel lblNgayCPXD = new JLabel("Ng??y c???p ph??p x??y d???ng:");
		lblNgayCPXD.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		lblNgayCPXD.setBounds(10, 132, 200, 30);
		 pnlNoiDung.add(lblNgayCPXD);
		
		txtNgayCPXD = new JTextField();
		txtNgayCPXD.setColumns(10);
		txtNgayCPXD.setBounds(220, 132, w, 30);
		 pnlNoiDung.add(txtNgayCPXD);
		 
			JLabel lblNgayKC = new JLabel("Ng??y kh???i c??ng:");
			lblNgayKC.setFont(new Font("Times New Roman", Font.PLAIN, 20));
			lblNgayKC.setBounds(10, 167, 200, 30);
			 pnlNoiDung.add(lblNgayKC);
			
			txtNgayKC = new JTextField();
			txtNgayKC.setBounds(220, 165, w, 30);
			 pnlNoiDung.add(txtNgayKC);
			txtNgayKC.setColumns(10);
		 
		JLabel lblNgayDKHT = new JLabel("Ng??y d??? ki???n HT :");
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
		cboModeTim.addElement("T??m ki???m theo:");
		cboModeTim.addElement("T??m theo m?? c??ng  tr??nh.");
		cboModeTim.addElement("T??m theo t??n c??ng tr??nh.");
		cboModeTim.addElement("T??m theo ?????a ??i???m.");
		cboModeTim.addElement("T??m theo ng???y c???p ph??p.");
		cboModeTim.addElement("T??m theo ng??y kh???i c??ng.");

		JPanel pnl_4_Thuoc = new JPanel();

		pnl_4_Thuoc.setBounds(10, 11, 1293, 191);
		pnlDsthuoc.add(pnl_4_Thuoc);
		pnl_4_Thuoc.setLayout(null);
		/*
		 * T???o Table
		 */

		JScrollPane scrollPaneThuoc = new JScrollPane();
		scrollPaneThuoc.setToolTipText("qq\r\n");
		scrollPaneThuoc.setVerticalScrollBarPolicy(ScrollPaneConstants.VERTICAL_SCROLLBAR_ALWAYS);
		scrollPaneThuoc.setHorizontalScrollBarPolicy(ScrollPaneConstants.HORIZONTAL_SCROLLBAR_ALWAYS);
		scrollPaneThuoc.setBounds(10, 11, 1273, 168);
		pnl_4_Thuoc.add(scrollPaneThuoc);
		String[] colsname= {"STT", "M?? c??ng tr??nh","T??n c??ng tr??nh" ,"??ia ??i???m","Ng??y c???p ph??p x??y d???ng","Ng??y kh???i c??ng" ,"Ng??y d??? ki???n ho??n th??nh"};

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

		JLabel lblTitiel = new JLabel("Qu???n L?? C??ng Tr??nh");
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

		btnThem = new JButton("Th??m ");
		btnThem.setBackground(Color.LIGHT_GRAY);
		btnThem.setHorizontalAlignment(SwingConstants.LEFT);
		btnThem.setIcon(new ImageIcon("Hinh\\add.png"));
		btnThem.setBounds(10, 93, 102, 30);
		pnlChucNang.add(btnThem);
		btnThem.setFont(new Font("Times New Roman", Font.BOLD, 12));

		btnXoa = new JButton("X??a\r\n");
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

		btnLuu = new JButton("L??u");
		btnLuu.setBackground(Color.LIGHT_GRAY);
		btnLuu.setHorizontalAlignment(SwingConstants.LEFT);
		btnLuu.setEnabled(false);
		btnLuu.setBounds(354, 92, 106, 30);
		pnlChucNang.add(btnLuu);
		btnLuu.setIcon(new ImageIcon("Hinh\\yes.png"));
		btnLuu.setFont(new Font("Times New Roman", Font.BOLD, 15));

		JButton btnThoat = new JButton("Tho??t");
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

		btnSua = new JButton("S???a");
		btnSua.setBackground(Color.LIGHT_GRAY);
		btnSua.setHorizontalAlignment(SwingConstants.LEFT);
		btnSua.setIcon(new ImageIcon("Hinh\\edit.png"));
		btnSua.setFont(new Font("Times New Roman", Font.BOLD, 15));
		btnSua.setBounds(238, 92, 106, 30);
		pnlChucNang.add(btnSua);

		btnLamMoi = new JButton("L??M M???I");
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
		
		JButton btnTim = new JButton("T??m ki???m");
		btnTim.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		btnTim.setBounds(976, 16, 127, 25);
		panel.add(btnTim);
		
		JLabel label = new JLabel("Nh???p th??ng tin t??m ki???m:");
		label.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		label.setBounds(20, 18, 162, 25);
		panel.add(label);
		
		JLabel label_1 = new JLabel("T??m theo:");
		label_1.setFont(new Font("Times New Roman", Font.PLAIN, 16));
		label_1.setBounds(30, 43, 63, 25);
		panel.add(label_1);
		
		radMa = new JRadioButton("M?? c??ng tr??nh");
		radMa.setSelected(true);
		radMa.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radMa.setBounds(174, 43, 184, 22);
		panel.add(radMa);
		
		radTenCT = new JRadioButton("T??n c??ng tr??nh");
		radTenCT.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radTenCT.setBounds(360, 43, 184, 22);	
		panel.add(radTenCT);
		
		radDD = new JRadioButton("?????a ??i???m");
		radDD.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radDD.setBounds(546, 43, 184, 22);
		panel.add(radDD);
		
		radNgayCPXD = new JRadioButton("Ng??y c???p ph??p x??y d???ng");
		radNgayCPXD.setFont(new Font("Tahoma", Font.PLAIN, 15));
		radNgayCPXD.setBounds(918, 43, 184, 22);
		panel.add(radNgayCPXD);
		
		
		
		radNgayKC = new JRadioButton("Ng??y kh???i c??ng");
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
		
		
			
		
		
		
	/** D??ng ????? l???y d??? li???u t??? sql l??n b???ng
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
	 * D??ng ????? hi???n th??? c??c text v?? combobox t??? b???ng l??n 
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
	 * M??? giao di??n s???a 
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
		
		cmbPhanLoai.setSelectedItem("Kh??ng k?? ????n");
		btnSua.setText("H???y");
		trangThaiSua=1;
		btnThem.setEnabled(false);
		btnLuu.setEnabled(true);
	}
	/**
	 * D??ng ????? l??u c??c c??c thu???c t??nh ???? th??m ho???c s???a 
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
//				JOptionPane.showMessageDialog(this, "Th??m th??nh c??ng ");
//				btnThem.setText("Th??m");
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
//				JOptionPane.showMessageDialog(this, "S???a Th??nh C??ng");
//				btnThem.setEnabled(true);
//				btnSua.setText("S???a");
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
	 * D??ng ????? m??? giao di???n th??m ph??n lo???i thu???c m???i
	 */
	public void themPhanLoai() {
		String moi= JOptionPane.showInputDialog(this, "Ph??n lo???i m???i");
		cmbPhanLoai.setSelectedItem(moi);
	}
	/**
	 * D??ng ????? m??? giao di???n th??m ????n v??? t??nh thu???c m???i
	 */
	public void themDonViTinh() {
		String moi= JOptionPane.showInputDialog(this, "????n v??? t??nh m???i");
		cmbDonViTinh.setSelectedItem(moi);
	}
	/**
	 * D??ng ????? m??? giao di???n th??m nh??m thu???c thu???c m???i
	 */
	public void themNhomThuoc() {
		String moi= JOptionPane.showInputDialog(this, "Nh??m thu???c m???i");
		cmbNhomThuoc.setSelectedItem(moi);
	}
	/**
	 * D??ng ????? m??? giao di???n th??m tr???ng th??i thu???c m???i
	 */
	public void themTrangThai() {
		String moi= JOptionPane.showInputDialog(this, "Tr???ng th??i m???i");
		cmbTrangThai.setSelectedItem(moi);
	}
	
	/**
	 * M??? giao di???n th??m
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
	
		btnThem.setText("H???y");
		cmbPhanLoai.setSelectedItem("Kh??ng k?? ????n");
		cmbTrangThai.setSelectedItem("??ang b??n");
		trangThaiThem=1;
		btnSua.setEnabled(false);
		btnLuu.setEnabled(true);
	}
	/**
	 * D??ng ????? x??a thu???c.
	 */
	public void xoa() {
		int i=JOptionPane.showConfirmDialog(this, "B???n c?? ch??? mu???n chuy???n sang tr???ng th??i ng???ng b??n");
		if(i==0) {
		//	dao.xoa(Integer.parseInt(txtThuoc_Ma.getText()));
			lamMoi();
		}
		else if(i==1) {
			return;
		}

	}
	/**
	 * D??ng ????? x??a d??? li???u b???ng
	 */
	public void xoaTable() {
		tbModel.addRow(new Object[] {

		});
		DefaultTableModel tbl = (DefaultTableModel) tblThuoc.getModel();
		tbl.getDataVector().removeAllElements();	
	}
	/**
	 * D??ng ????? l??m m???i giao di???n
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
		btnSua.setText("S???a");
		btnSua.setEnabled(true);
		trangThaiSua=0;
		btnThem.setText("Th??m");
		trangThaiThem=0;
		btnThem.setEnabled(true);
		
		btnThemDVT.setEnabled(false);
		btnThemNCC.setEnabled(false);
		btnThemNhomThuoc.setEnabled(false);
		btnThemPhanLoai.setEnabled(false);
		btnThemTrangThai.setEnabled(false);
	
	}
	/**
	 * D??ng ????? t??m ki???m thu???c.
	 */

	public static void main(String[] args) {
		new FrmCongTrinh().setVisible(true);
	}
}
