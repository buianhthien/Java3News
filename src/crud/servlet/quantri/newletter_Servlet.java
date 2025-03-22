package crud.servlet.quantri;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import crud.DAO.newletterDAO;
import crud.entities.loaitin;
import crud.entities.newletter;

@WebServlet({"/newletter/index", "/newletter/create", "/newletter/update", "/newletter/delete"})
public class newletter_Servlet extends HttpServlet {
    newletterDAO dao = new newletterDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        if (uri.contains("index")) {
            List<newletter> list = dao.selectAll();
            req.setAttribute("admin", "/views/quantri/guimail/newsletter.jsp");
            req.setAttribute("emails", list);
        } else if (uri.contains("create")) {
            req.setAttribute("admin", "/views/quantri/guimail/ct_newsletter.jsp");
        } else if (uri.contains("update")) {
            req.setAttribute("admin", "/views/quantri/guimail/update_letter.jsp");
            String email = req.getParameter("email");
            newletter letter = dao.selectByID(email);
            req.setAttribute("emails", letter);
        } else {
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
        String email = req.getParameter("email");
        String statusParam = req.getParameter("enabled");
        Boolean status = null;
        String errorMessage = null;

        // Validate email
        if (email == null || email.trim().isEmpty()) {
            errorMessage = "Email không được để trống!";
        } else if (!email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z]{2,6}$")) {
            errorMessage = "Email không đúng định dạng!";
        }

        // Validate status
        if (statusParam == null) {
            errorMessage = "Trạng thái không được để trống!";
        } else {
            try {
                status = Boolean.parseBoolean(statusParam);
            } catch (Exception e) {
                errorMessage = "Giá trị trạng thái không hợp lệ!";
            }
        }

        // Nếu có lỗi validate
        if (errorMessage != null) {
            req.setAttribute("errorMessage", errorMessage);
            if (uri.contains("create")) {
                req.setAttribute("admin", "/views/quantri/guimail/ct_newsletter.jsp");
            } else if (uri.contains("update")) {
                req.setAttribute("admin", "/views/quantri/guimail/update_letter.jsp");
            }
            req.getRequestDispatcher("/views/layouts.jsp").forward(req, resp);
            return;
        }

        if (uri.contains("create")) {
            newletter letter = new newletter();
            letter.setEmail(email);
            letter.setStatus(status);
            dao.insert(letter);
            resp.sendRedirect("/Assignment_BAT/newletter/index");

        } else if (uri.contains("update")) {
            newletter letter = new newletter();
            letter.setStatus(status);
            letter.setEmail(email);
            dao.update(letter);
            resp.sendRedirect("/Assignment_BAT/newletter/index");

        } else if (uri.contains("delete")) {
            dao.delete(email);
            resp.sendRedirect("/Assignment_BAT/newletter/index");
        }
    }

}
