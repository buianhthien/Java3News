package crud.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import crud.DAO.loaitinDAO;
import crud.DAO.nguoidungDAO;
import crud.entities.loaitin;
import crud.entities.nguoidung;

@WebServlet("/dangnhap")
public class dangnhap_Servlet extends HttpServlet {
    nguoidungDAO dao = new nguoidungDAO();
    loaitinDAO ltdao = new loaitinDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String currentCategoryID = req.getParameter("id");
        System.out.println("Current Category ID: " + currentCategoryID);
		List<loaitin> loaiTinList = ltdao.selectAll();
		req.setAttribute("currentCategoryID", currentCategoryID); // Đặt vào request
		req.setAttribute("loaiTinList", loaiTinList); // Đặt danh sách loại tin vào request
		System.out.println("Loai Tin List: " + loaiTinList);
		req.getRequestDispatcher("/views/taikhoan/dangnhap.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("Username");
        String password = req.getParameter("Password");
        
        // Kiểm tra người dùng từ database
        nguoidung ngdung = dao.selectByID(username); 

        if (ngdung == null) {
            req.setAttribute("error", "Sai tên đăng nhập");
            req.getRequestDispatcher("/views/taikhoan/dangnhap.jsp").forward(req, resp);
        } else if (!password.equals(ngdung.getPassword())) {
            req.setAttribute("error", "Sai mật khẩu");
            req.getRequestDispatcher("/views/taikhoan/dangnhap.jsp").forward(req, resp);
        } else {
            // Đăng nhập thành công, lưu người dùng vào session
            HttpSession session = req.getSession();
            session.setAttribute("loggedInUser", ngdung);  // Lưu đối tượng nguoidung vào session
            
         // Lấy role từ đối tượng người dùng (true = admin, false = reporter)
            boolean isAdmin = ngdung.isRole();  // Giả sử thuộc tính role là boolean

            // Lưu vai trò vào session dưới dạng String (để tiện so sánh trong JSP)
            if (isAdmin) {
                session.setAttribute("role", "admin");
            } else {
                session.setAttribute("role", "reporter");
            }
            
            // Xử lý nhớ đăng nhập (remember me)
            String remember = req.getParameter("remember");
            if (remember != null) {
                Cookie userCookie = new Cookie("username", username);
                Cookie passCookie = new Cookie("password", password);
                userCookie.setMaxAge(60 * 60 * 24 * 7); // Lưu trong 7 ngày
                passCookie.setMaxAge(60 * 60 * 24 * 7);
                resp.addCookie(userCookie);
                resp.addCookie(passCookie);
            }
            resp.sendRedirect("/Assignment_BAT/quantri/index");  // Quản trị viên
        }
    }
}
