package crud.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import crud.DAO.loaitinDAO;
import crud.DAO.tintucDAO;
import crud.entities.loaitin;
import crud.entities.tintuc;

@WebServlet("/nguoidung")
public class nguoidung_servlet extends HttpServlet {
	private tintucDAO ttdao = new tintucDAO();
	private loaitinDAO ltdao = new loaitinDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy danh sách bài viết hàng đầu
		List<tintuc> toptin = ttdao.selecttop5();
		req.setAttribute("tintuc", toptin);

		// Lấy danh sách tin mới
		List<tintuc> tinmoi = ttdao.selectByNew();
		req.setAttribute("news", tinmoi);

		// Lấy danh sách loại tin
		List<loaitin> loaiTinList = ltdao.selectAll();
		req.setAttribute("loaiTinList", loaiTinList);

		List<tintuc> listnews = ttdao.selectByCategoryTopNew(28);
		req.setAttribute("listnews", listnews);

		List<tintuc> listnews1 = ttdao.selectByCategoryTopNew(34);
		req.setAttribute("listnews1", listnews1);

		List<tintuc> listnews2 = ttdao.selectByCategoryTopNew(35);
		req.setAttribute("listnews2", listnews2);
		List<tintuc> listnews3 = ttdao.selectByCategoryTopNew(31);
		req.setAttribute("listnews3", listnews3);

		Cookie[] cookies = req.getCookies();
		List<tintuc> recentArticles = new ArrayList<>();

		// Hiển thị danh sách bài viết đã xem
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("recentIds")) {
					String recentIds = cookie.getValue();
					String[] ids = recentIds.split("\\.");

					for (String id : ids) {
						int articleId = Integer.parseInt(id); // Chuyển đổi chuỗi thành int
						tintuc article = ttdao.selectById(articleId); // Gọi phương thức để lấy bài viết
						if (article != null) {
							recentArticles.add(article); // Thêm bài viết vào danh sách
						}
					}
					break;
				}
			}
		}
		
		// Đảo ngược danh sách bài viết để hiển thị bài mới nhất trước
		Collections.reverse(recentArticles);

		// Gán danh sách bài viết vào request để hiển thị trên JSP
		req.setAttribute("recentArticles", recentArticles);

		// Chuyển đến trang chủ
		req.setAttribute("view", "/views/trangchu.jsp");
		req.getRequestDispatcher("/views/layout.jsp").forward(req, resp);
	}
}