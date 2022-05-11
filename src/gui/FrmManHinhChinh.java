package gui;
import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.Color;
import javax.swing.JMenuBar;
import javax.swing.JMenu;
import javax.swing.JToolBar;
import javax.swing.KeyStroke;

import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;

import javax.swing.ImageIcon;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JButton;
import javax.swing.JTabbedPane;
import java.awt.Toolkit;
import javax.swing.event.MenuListener;
import javax.swing.event.MenuEvent;

public class FrmManHinhChinh extends JFrame implements ActionListener,MenuListener {

	private JPanel contentPane;
	
	private JMenuItem mntmThemHoaDonMoi;
	private JMenuItem mntmHuyHoaDon;
	public static JTabbedPane tabbedPane;
	private JMenuBar menuBar;
	private JMenu mnAbout;
	private JMenu mnHelp;
	private JMenu mnExit;
	private JMenu mnXemHoaDon;
	private JMenuItem mntmXemThongTinThuoc;
	public static JMenuItem mntmQuanLyThuoc;
	private JMenuItem mntmThongKeHoaDon;
	private JMenuItem mntmThongKeTinhTrangThuoc;
	private JMenuItem mntmThongKeDoanhThu;
	private JMenuItem mntmThongTinNhanVien;
	private JMenuItem mntmDangXuat;
	public static JMenu mnNhanVien ;
	public static JMenu mnThongKe;
	public static JMenuBar menuBar_LapHoaDon;
	public static JMenu mnLapHoaDon;
	
	private FrmQuanLyNhanVien frmQuanLyNhanVien = new FrmQuanLyNhanVien();
	private FrmXemPhanCong frmQuanLyCongTrinh = new FrmXemPhanCong();
	private FrmXemThongTinCaNhan frmXemThongTinCaNhan = new FrmXemThongTinCaNhan();
    private FrmPhanCongLaoDong frmPhanCongLaoDong = new FrmPhanCongLaoDong();

	public FrmManHinhChinh() {
		setTitle("Công Ty Thiên Tâm");
		setIconImage(Toolkit.getDefaultToolkit().getImage("Hinh\\QLThuoc.png"));
		setBackground(Color.WHITE);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		setSize(1361, 720);
		setLocationRelativeTo(null);
		setExtendedState(JFrame.MAXIMIZED_BOTH);
		menuBar = new JMenuBar();
		menuBar.setBackground(Color.WHITE);
		setJMenuBar(menuBar);
		
		mnAbout = new JMenu("About");
		mnAbout.addMenuListener(new MenuListener() {
			public void menuCanceled(MenuEvent e) {
			}
			public void menuDeselected(MenuEvent e) {
			}
			public void menuSelected(MenuEvent e) {
			
			
			}
		});
		mnAbout.setBackground(Color.WHITE);
		menuBar.add(mnAbout);
		
		mnHelp = new JMenu("Help");
		mnHelp.setBackground(Color.WHITE);
		mnHelp.addMenuListener(new MenuListener() {
			public void menuCanceled(MenuEvent e) {
			}
			public void menuDeselected(MenuEvent e) {
			}
			public void menuSelected(MenuEvent e) {
				
			}
		});
		menuBar.add(mnHelp);
		
		mnExit = new JMenu("Exit");
		mnExit.addMenuListener(new MenuListener() {
			public void menuCanceled(MenuEvent e) {
			}
			public void menuDeselected(MenuEvent e) {
			}
			public void menuSelected(MenuEvent e) {
				Object chon = JOptionPane.showConfirmDialog(null, "Bạn có chắc chắn muốn thoát?");
				if(chon.equals(0)) {
					System.exit(0);
				}
			}
		});
		
		menuBar.add(mnExit);
		contentPane = new JPanel();
		contentPane.setBackground(Color.WHITE);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		JToolBar toolBar = new JToolBar();
		toolBar.setBackground(Color.WHITE);
		toolBar.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		toolBar.setFloatable(false);
		toolBar.setEnabled(false);
		contentPane.add(toolBar, BorderLayout.NORTH);
		
		menuBar_LapHoaDon = new JMenuBar();
		toolBar.add(menuBar_LapHoaDon);
		
		mnLapHoaDon = new JMenu("Phân công lao động");
		mnLapHoaDon.setIcon(new ImageIcon("Hinh\\ThemHoaDon.png"));
		mnLapHoaDon.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		
		mnLapHoaDon.setMnemonic(KeyEvent.VK_ENTER);
		menuBar_LapHoaDon.add(mnLapHoaDon);
		
		mntmThemHoaDonMoi = new JMenuItem("Phân công ");
		mntmThemHoaDonMoi.setIcon(new ImageIcon("Hinh\\add-HoaDon.png"));
		mntmThemHoaDonMoi.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		
		mntmThemHoaDonMoi.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F1,ActionEvent.ALT_MASK));
		
		mnLapHoaDon.add(mntmThemHoaDonMoi);
		
		mntmHuyHoaDon = new JMenuItem("Hủy phân công        Esc");
		mntmHuyHoaDon.setIcon(new ImageIcon("Hinh\\delete.png"));
		mntmHuyHoaDon.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		mntmHuyHoaDon.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_E,ActionEvent.ALT_MASK));
		mntmHuyHoaDon.setAccelerator(KeyStroke.getKeyStroke((char)KeyEvent.VK_ESCAPE));
		mnLapHoaDon.add(mntmHuyHoaDon);
		
		
		JMenuBar menuBar_2 = new JMenuBar();
		toolBar.add(menuBar_2);
		
		mnXemHoaDon = new JMenu("Xem Phân Công      ");
		mnXemHoaDon.addMenuListener(new MenuListener() {
			public void menuCanceled(MenuEvent e) {
			}
			public void menuDeselected(MenuEvent e) {
			}
			public void menuSelected(MenuEvent e) {
				tabbedPane.remove(tabbedPane.getSelectedComponent());
				tabbedPane.add(frmQuanLyCongTrinh.contentPane);
				tabbedPane.setSelectedComponent(frmQuanLyCongTrinh.contentPane);
			}
		});
		mnXemHoaDon.setIcon(new ImageIcon("Hinh\\hoadon.png"));
		mnXemHoaDon.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		mnXemHoaDon.setMnemonic(KeyEvent.VK_F2);
		menuBar_2.add(mnXemHoaDon);
		
		JMenuBar menuThuoc = new JMenuBar();
		menuThuoc.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		toolBar.add(menuThuoc);
		
		JMenu mnThuoc = new JMenu("Công trình      ");
		mnThuoc.setIcon(new ImageIcon("Hinh\\pill-29114.jpg"));
		mnThuoc.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		menuThuoc.add(mnThuoc);
		
		mntmXemThongTinThuoc = new JMenuItem("Xem thông tin công trình");
		mntmXemThongTinThuoc.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		mntmXemThongTinThuoc.setIcon(new ImageIcon("Hinh\\xemThongTinThuoc.jpg"));
		mntmXemThongTinThuoc.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F3,ActionEvent.ALT_MASK));
		mnThuoc.add(mntmXemThongTinThuoc);
		
		mntmQuanLyThuoc = new JMenuItem("Quản lý công trình");
		mntmQuanLyThuoc.setIcon(new ImageIcon("Hinh\\IconThuocThongKe.jpg"));
		mntmQuanLyThuoc.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		mntmQuanLyThuoc.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F4,ActionEvent.ALT_MASK));
		mnThuoc.add(mntmQuanLyThuoc);
		
		
		
		JMenuBar menuThongKe = new JMenuBar();
		toolBar.add(menuThongKe);
		mnThongKe = new JMenu("Thống Kê       ");
		mnThongKe.setIcon(new ImageIcon("Hinh\\iconthongke.jpg"));
		mnThongKe.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		menuThongKe.add(mnThongKe);
		
		mntmThongKeHoaDon = new JMenuItem("Thống kê hóa đơn lập theo nhân viên");
		mntmThongKeHoaDon.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		mntmThongKeHoaDon.setIcon(new ImageIcon("Hinh\\customer.png"));
		
		mntmThongKeHoaDon.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F5,ActionEvent.ALT_MASK));
		mnThongKe.add(mntmThongKeHoaDon);
		
		mntmThongKeTinhTrangThuoc = new JMenuItem("Thống kê tình trạng thuốc");
		mntmThongKeTinhTrangThuoc.setIcon(new ImageIcon("Hinh\\IconThuoc.png"));
		mntmThongKeTinhTrangThuoc.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		
		mntmThongKeTinhTrangThuoc.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F6,ActionEvent.ALT_MASK));
		mnThongKe.add(mntmThongKeTinhTrangThuoc);
		
		mntmThongKeDoanhThu = new JMenuItem("Thống kê doanh thu");
		mntmThongKeDoanhThu.setIcon(new ImageIcon("Hinh\\thongke.png"));
		mntmThongKeDoanhThu.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		
		mntmThongKeDoanhThu.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F7,ActionEvent.ALT_MASK));
		mnThongKe.add(mntmThongKeDoanhThu);
		
		JMenuBar menuKhachHang = new JMenuBar();
		toolBar.add(menuKhachHang);
		
		JMenuBar menuNhanVien = new JMenuBar();
		menuKhachHang.add(menuNhanVien);

		JMenu mnNhanVien = new JMenu("Nhân Viên                           ");
		mnNhanVien.setIcon(new ImageIcon("Hinh\\customer.png"));
		mnNhanVien.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		mnNhanVien.setEnabled(true);
		menuKhachHang.add(mnNhanVien);
		
		mntmThongTinNhanVien = new JMenuItem("Quản lý nhân viên  ");
		mntmThongTinNhanVien.setIcon(new ImageIcon("Hinh\\ListKhachHang.png"));
		
		
		mntmThongTinNhanVien.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_F9,ActionEvent.ALT_MASK));
		
		
		mntmThongTinNhanVien.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		mnNhanVien.add(mntmThongTinNhanVien);
		
		JMenuBar menuThongTinCaNhan = new JMenuBar();
		toolBar.add(menuThongTinCaNhan);
		
		JMenu mnThongTinCaNhan = new JMenu("Thông Tin Cá Nhân");
		mnThongTinCaNhan.addMenuListener(new MenuListener() {
			public void menuCanceled(MenuEvent e) {
			}
			public void menuDeselected(MenuEvent e) {
			}
			public void menuSelected(MenuEvent e) {
				tabbedPane.remove(tabbedPane.getSelectedComponent());
				tabbedPane.add(frmXemThongTinCaNhan.pnlTabXemThongTinCaNhan);
			}
		});
		mnThongTinCaNhan.setIcon(new ImageIcon("Hinh\\ThongTinCaNhan.png"));
		mnThongTinCaNhan.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		menuThongTinCaNhan.add(mnThongTinCaNhan);
		
		mnThongTinCaNhan.setMnemonic(KeyEvent.VK_F10);
		JMenuBar menuDangNhap = new JMenuBar();
		toolBar.add(menuDangNhap);
		
		JMenu mnDangNhap_DangXuat = new JMenu("");
		mnDangNhap_DangXuat.setFont(new Font("Times New Roman", Font.PLAIN, 20));
		mnDangNhap_DangXuat.setIcon(new ImageIcon("Hinh\\close2222.png"));
		menuDangNhap.add(mnDangNhap_DangXuat);
		
		mntmDangXuat = new JMenuItem("Đăng xuất");
		mntmDangXuat.setIcon(new ImageIcon("Hinh\\logout.png"));
		mntmDangXuat.setFont(new Font("Times New Roman", Font.PLAIN, 18));
		
		mnDangNhap_DangXuat.setMnemonic(KeyEvent.VK_F11);
		mnDangNhap_DangXuat.add(mntmDangXuat);
		
		tabbedPane = new JTabbedPane(JTabbedPane.RIGHT);
		tabbedPane.setBackground(Color.WHITE);
		contentPane.add(tabbedPane, BorderLayout.CENTER);
		mntmThemHoaDonMoi.addActionListener(this);
		mntmHuyHoaDon.addActionListener(this);
		mnXemHoaDon.addActionListener(this);
		mnXemHoaDon.addMenuListener(this);
		mntmXemThongTinThuoc.addActionListener(this);
		mntmQuanLyThuoc.addActionListener(this);
		mntmThongKeHoaDon.addActionListener(this);
		mntmThongKeTinhTrangThuoc.addActionListener(this);
		mntmThongKeDoanhThu.addActionListener(this);
		mntmThongTinNhanVien.addActionListener(this);
		mntmDangXuat.addActionListener(this);
		//contentPane.add(frmLapHoaDon.jp1, BorderLayout.CENTER);
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		Object obj = e.getSource();
		if(obj.equals(mntmThemHoaDonMoi)) {
			try {
			
				
			} catch (Exception e2) {
				// TODO: handle exception
				
			}
			tabbedPane.remove(tabbedPane.getSelectedComponent());
			
			tabbedPane.add(frmPhanCongLaoDong.jp1);
			
			
		}
		else if(obj.equals(mntmHuyHoaDon)) {
			tabbedPane.remove(frmPhanCongLaoDong.jp1);
		}
		else if(obj.equals(mntmXemThongTinThuoc)) {
			tabbedPane.remove(tabbedPane.getSelectedComponent());	
		    FrmCongTrinh frmCongTrinh = new FrmCongTrinh();	 
			frmCongTrinh.pnlChucNang.remove(frmCongTrinh.btnThem);
			frmCongTrinh.pnlChucNang.remove(frmCongTrinh.btnLuu);
			frmCongTrinh.pnlChucNang.remove(frmCongTrinh.btnXoa);
			frmCongTrinh.pnlChucNang.remove(frmCongTrinh.btnSua);
			tabbedPane.add(frmCongTrinh.contentPane);	

		}
		else if(obj.equals(mntmQuanLyThuoc)) {
			tabbedPane.remove(tabbedPane.getSelectedComponent());	
			 FrmCongTrinh frmCongTrinh = new FrmCongTrinh();	
			tabbedPane.add(frmCongTrinh.contentPane);
			
		}
		else if(obj.equals(mntmThongKeHoaDon)){
			
		}
		else if(obj.equals(mntmThongKeTinhTrangThuoc)) {
			tabbedPane.remove(tabbedPane.getSelectedComponent());
			
		}
		else if(obj.equals(mntmThongKeDoanhThu)) {
			tabbedPane.remove(tabbedPane.getSelectedComponent());
			
		}
		else if(obj.equals(mntmThongTinNhanVien)) {
			tabbedPane.remove(tabbedPane.getSelectedComponent());
			tabbedPane.add(frmQuanLyNhanVien.pnlTabQLNV);
		}
		else if(obj.equals(mntmDangXuat)) {
			this.setVisible(false);
			
			
			
		}
	}

	@Override
	public void menuSelected(MenuEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void menuDeselected(MenuEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void menuCanceled(MenuEvent e) {
		// TODO Auto-generated method stub
		
	}
}
