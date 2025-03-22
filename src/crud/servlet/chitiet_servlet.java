package crud.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import crud.DAO.loaitinDAO;
import crud.DAO.nguoidungDAO;
import crud.DAO.tintucDAO;
import crud.entities.loaitin;
import crud.entities.nguoidung;
import crud.entities.tintuc;

@WebServlet("/chitiet")
public class chitiet_servlet extends HttpServlet {
    private tintucDAO ttdao = new tintucDAO();
    private nguoidungDAO nddao = new nguoidungDAO();
    private loaitinDAO ltdao = new loaitinDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        List<loaitin> loaiTinList = ltdao.selectAll();
		req.setAttribute("loaiTinList", loaiTinList); // Đặt danh sách loại tin vào request
        
        int id = Integer.parseInt(idParam);
     // **Cập nhật lượt xem bài viết**
        ttdao.viewCount(id);
        // Lấy bài viết theo ID
        tintuc tt = ttdao.selectById(id);
        if (tt == null) {
            req.setAttribute("errorMessage", "Bài viết không tồn tại");
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
            return;
        }
     // Gán bài viết vào request và chuyển đến trang chi tiết
        req.setAttribute("newtem", tt);
        
        
        List<nguoidung> nguoiDungList = nddao.selectAll();
        Map<String, String> useMap = new HashMap<>();
        for (nguoidung nd : nguoiDungList) {
            useMap.put(nd.getUserID(), nd.getFullName());
        }
        req.setAttribute("useMap", useMap);
        
     // Lấy danh sách bài viết hàng đầu
        List<tintuc> toptin = ttdao.selecttop5();
        req.setAttribute("tintuc", toptin);
        
      // Lấy danh sach các bài viết mới theo loại tin
        int categoryId = tt.getLtName().getCategoryID();
        List<tintuc> top5News = ttdao.selectByCategoryTopNew(categoryId); 
        req.setAttribute("top5News", top5News);
		
        String currentId = req.getParameter("id"); // Lấy ID từ tham số
        String recentIds = "";
     // Khai báo và lấy cookies từ request
        Cookie[] cookies = req.getCookies();

        // Kiểm tra xem cookie có tồn tại hay không
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("recentIds")) {
                    recentIds = cookie.getValue();
                    break;
                }
            }
        }

        // Thêm ID hiện tại vào danh sách
        if (!recentIds.contains(currentId)) {
            if (!recentIds.isEmpty()) {
                recentIds += "."; // Thêm dấu phẩy phân cách
            }
            recentIds += currentId;

            // Giới hạn số lượng ID (giả sử tối đa 5 ID)
            String[] ids = recentIds.split("\\.");
            if (ids.length > 6) {
                recentIds = String.join(".", Arrays.copyOfRange(ids, ids.length - 6, ids.length));
            }

            // Tạo cookie mới
            Cookie recentIdsCookie = new Cookie("recentIds", recentIds);
            recentIdsCookie.setMaxAge(60 * 60 * 24 * 365); // 1 năm
            resp.addCookie(recentIdsCookie);
        }


        
        req.getRequestDispatcher("/views/menu_con/chitiet_page.jsp").forward(req, resp);
    }
}
