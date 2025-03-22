package crud.servlet.quantri;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/dangxuat")
public class dangxuat_Servlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 // Lấy session hiện tại
    HttpSession session = req.getSession(false); // false để không tạo mới session nếu không có

    if (session != null) {
        // Xóa tất cả các thuộc tính trong session
        session.invalidate(); // Xóa session và tất cả thông tin trong đó
    }

    // Chuyển hướng về trang đăng nhập hoặc trang chính
    resp.sendRedirect("/Assignment_BAT/dangnhap"); // Đường dẫn đến trang đăng nhập
}

@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 doGet(req, resp);
	}
}
