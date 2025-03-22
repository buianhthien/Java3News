package crud.servlet.quantri;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.html.HTML;

import crud.DAO.loaitinDAO;
import crud.entities.loaitin;

@WebServlet({"/loaitin/index","/loaitin/create","/loaitin/update/*", "/loaitin/delete"})
public class qlloaitin_Servlet  extends HttpServlet{
	loaitinDAO dao = new loaitinDAO();
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 req.setCharacterEncoding("UTF-8");
     resp.setContentType("text/html; charset=UTF-8");
     resp.setCharacterEncoding("UTF-8");
	String uri = req.getRequestURI();
	if (uri.contains("index")) {
		List<loaitin> list = dao.selectAll();
		req.setAttribute("admin", "/views/quantri/loaitin/loaitin.jsp");
		req.setAttribute("categories", list);
	}else if(uri.contains("create")) {
		req.setAttribute("admin", "/views/quantri/loaitin/ct_loaitin.jsp");
	}else if(uri.contains("update")) {
		  req.setAttribute("admin", "/views/quantri/loaitin/lt_update.jsp");
		    String idParam = req.getParameter("id");
		    int id = Integer.parseInt(idParam);
	        loaitin lt = dao.selectByID(id);
	        req.setAttribute("loaitin", lt);
	}else {
		req.setAttribute("admin", "/views/trangchu.jsp");
	}
	req.getRequestDispatcher("/views/layouts.jsp").forward(req, resp);
}
private boolean validateLoaitin(String name, HttpServletRequest req) {
    if (name == null || name.trim().isEmpty()) {
        req.setAttribute("errorMessage", "Tên loại tin không được để trống.");
        return false;
    }
   
    return true;
}
@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 req.setCharacterEncoding("UTF-8");
	    resp.setContentType("text/html; charset=UTF-8");
	    resp.setCharacterEncoding("UTF-8");
	    
	    String uri = req.getRequestURI();
	    if (uri.contains("create")) {
	        String name = req.getParameter("name");

	        // Validate input
	        if (!validateLoaitin(name, req)) {
	            req.setAttribute("admin", "/views/quantri/loaitin/ct_loaitin.jsp"); // Trả lại form
	            req.getRequestDispatcher("/views/layouts.jsp").forward(req, resp);
	            return; // Ngừng thực hiện nếu có lỗi
	        }

	        loaitin lt = new loaitin();
	        lt.setCategoryName(name);
	        dao.insert(lt);
	        req.getSession().setAttribute("message", "Thêm loại tin thành công!");
	        resp.sendRedirect("/Assignment_BAT/loaitin/index");

	    } else if (uri.contains("update")) {
	        String idParam = req.getParameter("id");
	        int id = Integer.parseInt(idParam);
	        String name = req.getParameter("name");

	        // Validate input
	        if (!validateLoaitin(name, req)) {
	            req.setAttribute("admin", "/views/quantri/loaitin/lt_update.jsp"); // Trả lại form
	            req.setAttribute("loaitin", dao.selectByID(id)); // Đưa lại đối tượng để hiển thị
	            req.getRequestDispatcher("/views/layout.jsp").forward(req, resp);
	            return; // Ngừng thực hiện nếu có lỗi
	        }

	        loaitin lt = new loaitin();
	        lt.setCategoryName(name);
	        lt.setCategoryID(id);

	        dao.update(lt);
	        req.getSession().setAttribute("message", "Sửa loại tin thành công!");
	        resp.sendRedirect("/Assignment_BAT/loaitin/index");

	    } else if (uri.contains("delete")) {
	        int id = Integer.parseInt(req.getParameter("id"));
	        dao.delete(id);
	        req.getSession().setAttribute("message", "Xóa loại tin thành công!");
	        resp.sendRedirect("/Assignment_BAT/loaitin/index");
	    }
	
	
	}
}
