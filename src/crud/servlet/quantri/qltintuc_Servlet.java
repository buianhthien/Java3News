package crud.servlet.quantri;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.Message;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import crud.DAO.loaitinDAO;
import crud.DAO.newletterDAO;
import crud.DAO.tintucDAO;
import crud.entities.loaitin;
import crud.entities.nguoidung;
import crud.entities.tintuc;

@MultipartConfig
@WebServlet({ "/tintuc/index", "/tintuc/create", "/tintuc/update/*", "/tintuc/delete" })
public class qltintuc_Servlet extends HttpServlet {
	tintucDAO dao = new tintucDAO();
	loaitinDAO ltDAO = new loaitinDAO();
	newletterDAO newletterDAO = new newletterDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		String role = (String) req.getSession().getAttribute("role");
		nguoidung loggedInUser = (nguoidung) req.getSession().getAttribute("loggedInUser");
		if (uri.contains("index")) {
			List<tintuc> list; // Danh sách tin tức
	        // Phân quyền dựa trên vai trò
	        if ("admin".equals(role)) {
	            // Nếu là quản trị viên, lấy tất cả tin tức
	            list = dao.selectAll();
	        } else if ("reporter".equals(role)) {
	            // Nếu là phóng viên, chỉ lấy tin tức của người dùng hiện tại
	            String author = loggedInUser.getUserID(); // Lấy username từ session
	            list = dao.selectByAuthor(author); // Lấy tin tức theo tên người dùng
	            List<tintuc> newsList = dao.selectByAuthor(author);
	            
	            if (list.isEmpty()) {
	                System.out.println("No news found for author: " + author);
	            } 	
	        } else {
	            list = null; // Trường hợp không hợp lệ
	            
	        }
	        
	        // Gán danh sách tin tức vào request attribute
	        req.setAttribute("news", list);
	        // Điều hướng đến trang hiển thị tin tức
	        req.setAttribute("admin", "/views/quantri/tintuc/tintuc.jsp");
		} else if (uri.contains("create")) {
			List<loaitin> list = ltDAO.selectAll();
			req.setAttribute("ds", list);
			req.setAttribute("admin", "/views/quantri/tintuc/ct_tintuc.jsp");
		} else if (uri.contains("update")) {
			int id = Integer.parseInt(req.getParameter("id"));
			tintuc ttuc = dao.selectById(id); 
			req.setAttribute("news", ttuc); 
			
			List<loaitin> list = ltDAO.selectAll();
			req.setAttribute("ds", list);
			req.setAttribute("admin", "/views/quantri/tintuc/tt_update.jsp");
		}
		req.getRequestDispatcher("/views/layouts.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 req.setCharacterEncoding("UTF-8");
		    resp.setContentType("text/html; charset=UTF-8");
		    resp.setCharacterEncoding("UTF-8");

		    String uri = req.getRequestURI();

		    if (uri.contains("create")) {
		        // Validate input
		        if (!validateTinTucForm(req)) {
		            List<loaitin> list = ltDAO.selectAll();
		            req.setAttribute("ds", list);
		            req.setAttribute("admin", "/views/quantri/tintuc/ct_tintuc.jsp");
		            req.getRequestDispatcher("/views/layouts.jsp").forward(req, resp);
		            return;
		        }

		        // Xử lý việc tạo tin tức nếu không có lỗi
		        Part filePart = req.getPart("image");
		        String fileName = filePart.getSubmittedFileName();
		        String path = req.getServletContext().getRealPath("/images");
		        filePart.write(path + "\\" + fileName);

		        String title = req.getParameter("title");
		        String content = req.getParameter("content");
		        String image = "/images/"+ fileName;
		        Date postedDate = new Date();
		        
		     // Lấy thông tin phóng viên từ session
		        HttpSession session = req.getSession();
		        nguoidung currentUser = (nguoidung) session.getAttribute("loggedInUser");
		        String author = currentUser.getUserID(); // Lấy mã phóng viên từ session
		        
		        int viewCount = Integer.parseInt(req.getParameter("viewCount"));
		        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
		        Boolean home = req.getParameter("home") != null;

		        tintuc tt = new tintuc();
		        tt.setTitle(title);
		        tt.setContent(content);
		        tt.setImage(image);
		        tt.setPostDate(postedDate);
		        tt.setAuthor(author);
		        tt.setViewCount(viewCount);
		        tt.setCategoryID(categoryId);
		        tt.setHome(home);

		        dao.insert(tt);
		        sendNewsletterNotification(title, content);
		        
		        req.getSession().setAttribute("message", "Thêm tin tức thành công!");
		        resp.sendRedirect("/Assignment_BAT/tintuc/index");

		    } else if (uri.contains("update")) {
		    	  // Validate input
		        if (!validateTinTucForm(req)) {
		            int id = Integer.parseInt(req.getParameter("id"));
		            req.setAttribute("news", dao.selectById(id));
		            List<loaitin> list = ltDAO.selectAll();
		            req.setAttribute("ds", list);
		            req.setAttribute("view", "/views/quantri/tintuc/tt_update.jsp");
		            req.getRequestDispatcher("/views/layouts.jsp").forward(req, resp);
		            return;
		        }

		        // Xử lý việc cập nhật tin tức nếu không có lỗi
		        int id = Integer.parseInt(req.getParameter("id"));
		        String title = req.getParameter("title");
		        String content = req.getParameter("content");
		        String author = req.getParameter("author");

		        // Lấy tin tức hiện tại từ cơ sở dữ liệu
		        tintuc existingNews = dao.selectById(id);

		        // Xử lý ngày đăng
		        String postedDateParam = req.getParameter("postedDate");
		        Date postedDate = existingNews.getPostDate(); // Mặc định là ngày cũ
		        if (postedDateParam != null && !postedDateParam.isEmpty()) {
		            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Định dạng ngày trong form HTML
		            try {
		                postedDate = sdf.parse(postedDateParam); // Chuyển đổi từ chuỗi sang Date
		            } catch (ParseException e) {
		                // Nếu có lỗi định dạng, giữ nguyên ngày cũ
		                e.printStackTrace();
		            }
		        }

		        int viewCount = 0;
		        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
		        Boolean home = req.getParameter("home") != null;

		        // Xử lý hình ảnh
		        Part filePart = req.getPart("image");
		        String fileName = filePart.getSubmittedFileName();
		        String image;

		        if (filePart != null && fileName != null && !fileName.isEmpty()) {
		            String path = req.getServletContext().getRealPath("/images");
		            filePart.write(path + "\\" + fileName);
		            image = "/images/" + fileName;
		        } else {
		            image = existingNews.getImage(); // Giữ nguyên ảnh cũ nếu không upload ảnh mới
		        }

		        // Tạo đối tượng tintuc và set các thuộc tính
		        tintuc tt = new tintuc();
		        tt.setNewsID(id);
		        tt.setTitle(title);
		        tt.setContent(content);
		        tt.setImage(image);
		        tt.setPostDate(postedDate); // Sử dụng ngày mới nếu có hoặc giữ nguyên ngày cũ
		        tt.setAuthor(author);
		        tt.setViewCount(viewCount);
		        tt.setCategoryID(categoryId);
		        tt.setHome(home);

		        // Cập nhật dữ liệu
		        dao.update(tt);
		        req.getSession().setAttribute("message", "Sửa tin tức thành công!");
		        // Chuyển hướng sau khi cập nhật thành công
		        resp.sendRedirect("/Assignment_BAT/tintuc/index");
		    } else if (uri.contains("delete")) {
		        int id = Integer.parseInt(req.getParameter("id"));
		        dao.delete(id);
		        req.getSession().setAttribute("message", "Xóa tin tức thành công!");
		        resp.sendRedirect("/Assignment_BAT/tintuc/index");
		    }
	}
	
	private boolean validateTinTucForm(HttpServletRequest req) {
	    String title = req.getParameter("title");
	    String content = req.getParameter("content");
//	    String postedDate = req.getParameter("postedDate");
	    String viewCountStr = req.getParameter("viewCount");
	    String categoryIdStr = req.getParameter("categoryId");

	    // Kiểm tra title
	    if (title == null || title.trim().isEmpty()) {
	        req.setAttribute("errorMessage", "Tiêu đề không được để trống.");
	        return false;
	    }

	    // Kiểm tra content
	    if (content == null || content.trim().isEmpty()) {
	        req.setAttribute("errorMessage", "Nội dung không được để trống.");
	        return false;
	    }

		/*
		 * // Kiểm tra postedDate (ngày đăng) if (postedDate == null ||
		 * postedDate.trim().isEmpty()) { req.setAttribute("errorMessage",
		 * "Ngày đăng không được để trống."); return false; }
		 */

	    // Kiểm tra viewCount (số lượt xem) có phải là số hợp lệ không
	    try {
	        int viewCount = Integer.parseInt(viewCountStr);
	        if (viewCount < 0) {
	            req.setAttribute("errorMessage", "Số lượt xem phải lớn hơn hoặc bằng 0.");
	            return false;
	        }
	    } catch (NumberFormatException e) {
	        req.setAttribute("errorMessage", "Số lượt xem phải là một số hợp lệ.");
	        return false;
	    }

	    // Kiểm tra categoryId (loại tin) có phải là số hợp lệ không
	    try {
	        int categoryId = Integer.parseInt(categoryIdStr);
	        if (categoryId <= 0) {
	            req.setAttribute("errorMessage", "Loại tin không hợp lệ.");
	            return false;
	        }
	    } catch (NumberFormatException e) {
	        req.setAttribute("errorMessage", "Loại tin phải là một số hợp lệ.");
	        return false;
	    }

	    return true;
	}
	
	 private void sendNewsletterNotification(String title, String content) {
	        List<String> emails = newletterDAO.getAllActiveEmails(); // Lấy danh sách email đã đăng ký với trạng thái true

	        for (String email : emails) {
	            try {
	                sendEmail(email, title, content); // Gửi email thông báo
	            } catch (MessagingException e) {
	                e.printStackTrace(); // Xử lý lỗi gửi email
	            }
	        }
	    }
	 private void sendEmail(String recipient, String title, String content) throws MessagingException {
		    String from = "thienbapd11347@gmail.com"; // Email của bạn
		    String password = "jzed llrm jswl bqvl"; // Mật khẩu ứng dụng của bạn

		    // Cấu hình thông tin máy chủ SMTP
		    Properties props = new Properties();
		    props.put("mail.smtp.host", "smtp.gmail.com");
		    props.put("mail.smtp.port", "587");
		    props.put("mail.smtp.auth", "true");
		    props.put("mail.smtp.starttls.enable", "true");
		    props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // Thêm dòng này
		    
		    props.put("mail.smtp.ssl.protocols", "TLSv1.2");
		    // Tạo phiên làm việc với xác thực
		    Session session = Session.getInstance(props, new javax.mail.Authenticator() {
		        protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
		            return new javax.mail.PasswordAuthentication(from, password);
		        }
		    });

		    // Tạo tin nhắn email
		    Message message = new MimeMessage(session);
		    message.setFrom(new InternetAddress(from));
		    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
		    message.setSubject("Thông báo tin tức mới: " + title);
		    message.setText("Nội dung: " + content); // Gửi nội dung tin tức

		    // Gửi email
		    Transport.send(message);
		}
	
}
