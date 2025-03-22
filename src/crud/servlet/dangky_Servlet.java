package crud.servlet;

import crud.DAO.loaitinDAO;
import crud.DAO.newletterDAO; // Import DAO
import crud.entities.loaitin;
import crud.entities.newletter;

import java.io.IOException;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dangky")
public class dangky_Servlet extends HttpServlet {
	loaitinDAO ltdao = new loaitinDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       
    	String currentCategoryID = req.getParameter("id");
		List<loaitin> loaiTinList = ltdao.selectAll();
		req.setAttribute("currentCategoryID", currentCategoryID); // Đặt vào request
		req.setAttribute("loaiTinList", loaiTinList); // Đặt danh sách loại tin vào request
		 req.getRequestDispatcher("/views/taikhoan/dangky.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        crud.DAO.newletterDAO dao = new crud.DAO.newletterDAO();
    	String email = req.getParameter("email");

        // Kiểm tra email có hợp lệ không
        if (!isValidEmail(email)) {
            req.setAttribute("message", "Email không hợp lệ. Vui lòng nhập lại.");
            req.setAttribute("messageType", "error");
            req.getRequestDispatcher("/views/taikhoan/dangky.jsp").forward(req, resp);
            return; // Dừng xử lý nếu email không hợp lệ
        }

        // Kiểm tra xem email đã tồn tại chưa
        if (dao.isEmailExists(email)) {
            req.setAttribute("message", "Email này đã được đăng ký nhận bản tin!");
            req.setAttribute("messageType", "error");
            req.getRequestDispatcher("/views/taikhoan/dangky.jsp").forward(req, resp);
            return;
        }

        // Gửi email chúc mừng và thiết lập thông báo
        String message;
        try {
        	newletter letter = new newletter();
        	letter.setEmail(email);
        	letter.setStatus(true);
            sendEmail(email); // Gửi email chúc mừng
            dao.insert(letter); // Thêm email vào bảng newletter
            message = "Chúc mừng! Bạn đã đăng ký thành công.";
            req.setAttribute("message", message);
            req.setAttribute("messageType", "success");
        } catch (MessagingException e) {
            message = "Có lỗi xảy ra khi gửi email. Vui lòng kiểm tra lại địa chỉ email và thử lại.";
            req.setAttribute("message", message);
            req.setAttribute("messageType", "error");
            e.printStackTrace(); // In ra console để phục vụ việc gỡ lỗi
        }

        // Chuyển hướng người dùng về trang đăng ký
        req.getRequestDispatcher("/views/taikhoan/dangky.jsp").forward(req, resp);
    }

    // Phương thức kiểm tra email hợp lệ
    private boolean isValidEmail(String email) {
        // Biểu thức chính quy kiểm tra email
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    // Phương thức gửi email
    private void sendEmail(String recipient) throws MessagingException {
        // Cài đặt thông tin gửi email
        String from = "thienba2609@gmail.com"; // Thay bằng email của bạn
        String password = "oexd ssyd ikmq ilqm"; // Thay bằng mật khẩu của bạn

        // Cấu hình thông tin máy chủ SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");

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
        message.setSubject("Chúc mừng bạn đã đăng ký thành công!");
        message.setText("Chúc mừng! Bạn đã đăng ký thành công trên hệ thống của chúng tôi.");

        // Gửi email
        Transport.send(message);
        
    }
    
}
