package crud.servlet.quantri;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import crud.DAO.nguoidungDAO;
import crud.entities.nguoidung;

@WebServlet({"/nguoidung/index","/nguoidung/create","/nguoidung/update/*","/nguoidung/delete"})
public class qlngdung_Servlet extends HttpServlet{
	nguoidungDAO dao =  new nguoidungDAO();
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	String uri = req.getRequestURI();
	if (uri.contains("index")) {
		List<nguoidung>ngdungList = dao.selectAll();
		req.setAttribute("admin", "/views/quantri/nguoidung/nguoidung.jsp");
		req.setAttribute("users", ngdungList);
	}else if(uri.contains("create")) {
		req.setAttribute("admin", "/views/quantri/nguoidung/ct_nguoidung.jsp");
	}else if(uri.contains("update")) {
		req.setAttribute("admin", "/views/quantri/nguoidung/nd_update.jsp");
		String id = req.getParameter("id");
		nguoidung nd = dao.selectByID(id);
		System.out.println(nd);
		req.setAttribute("nguoidung", nd);
		
	}else {
		req.setAttribute("admin", "/views/trangchu.jsp");
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
        if (!validateNguoiDung(req)) {
            req.setAttribute("admin", "/views/quantri/nguoidung/ct_nguoidung.jsp"); // Trả lại form
            req.getRequestDispatcher("/views/layouts.jsp").forward(req, resp);
            return; // Ngừng thực hiện nếu có lỗi
        }

        // Nếu không có lỗi, thực hiện thêm người dùng
        String id = req.getParameter("id");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        LocalDate birthday = LocalDate.parse(req.getParameter("birthday"));
        Boolean gender = Boolean.parseBoolean(req.getParameter("gender"));
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        Boolean role = Boolean.parseBoolean(req.getParameter("role"));

        nguoidung nd = new nguoidung();
        nd.setUserID(id);
        nd.setPassword(password);
        nd.setFullName(fullname);
        nd.setBirthday(birthday);
        nd.setGender(gender);
        nd.setMobile(mobile);
        nd.setEmail(email);
        nd.setRole(role);
        
        dao.insert(nd);
        req.getSession().setAttribute("message", "Thêm Người dùng thành công!");
        resp.sendRedirect("/Assignment_BAT/nguoidung/index");

    } else if (uri.contains("update")) {
        // Validate input
        if (!validateNguoiDung(req)) {
            req.setAttribute("admin", "/views/quantri/nguoidung/nd_update.jsp"); // Trả lại form
            String id = req.getParameter("id");
            req.setAttribute("nguoidung", dao.selectByID(id)); // Đưa lại đối tượng để hiển thị
            req.getRequestDispatcher("/views/layouts.jsp").forward(req, resp);
            return; // Ngừng thực hiện nếu có lỗi
        }

        // Nếu không có lỗi, thực hiện cập nhật người dùng
        String id = req.getParameter("id");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        LocalDate birthday = LocalDate.parse(req.getParameter("birthday"));
        Boolean gender = Boolean.parseBoolean(req.getParameter("gender"));
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        Boolean role = Boolean.parseBoolean(req.getParameter("role"));

        nguoidung nd = new nguoidung();
        nd.setUserID(id);
        nd.setPassword(password);
        nd.setFullName(fullname);
        nd.setBirthday(birthday);
        nd.setGender(gender);
        nd.setMobile(mobile);
        nd.setEmail(email);
        nd.setRole(role);
        
        dao.update(nd);
        req.getSession().setAttribute("message", "Sửa người dùng thành công!");
        resp.sendRedirect("/Assignment_BAT/nguoidung/index");
        
    } else if (uri.contains("delete")) {
        String id = req.getParameter("id");
        dao.delete(id);
        req.getSession().setAttribute("message", "Xóa người dùng thành công!");
        resp.sendRedirect("/Assignment_BAT/nguoidung/index");
    }
	}


private boolean validateNguoiDung(HttpServletRequest req) {
    String id = req.getParameter("id");
    String password = req.getParameter("password");
    String fullname = req.getParameter("fullname");
    String birthday = req.getParameter("birthday");
    String mobile = req.getParameter("mobile");
    String email = req.getParameter("email");
    
    if (id == null || id.trim().isEmpty()) {
        req.setAttribute("errorMessage", "ID người dùng không được để trống.");
        return false;
    }
    if (password == null || password.trim().isEmpty()) {
        req.setAttribute("errorMessage", "Mật khẩu không được để trống.");
        return false;
    }
    if (fullname == null || fullname.trim().isEmpty()) {
        req.setAttribute("errorMessage", "Họ tên không được để trống.");
        return false;
    }
    if (birthday == null || birthday.trim().isEmpty()) {
        req.setAttribute("errorMessage", "Ngày sinh không được để trống.");
        return false;
    }
    if (mobile == null || !mobile.matches("\\d{10}")) { // Kiểm tra số điện thoại có 10 chữ số
        req.setAttribute("errorMessage", "Số điện thoại không hợp lệ.");
        return false;
    }
    if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) { // Kiểm tra định dạng email
        req.setAttribute("errorMessage", "Email không hợp lệ.");
        return false;
    }
    return true;
}
}
