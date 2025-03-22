package crud.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import crud.DAO.loaitinDAO;
import crud.DAO.tintucDAO;
import crud.entities.loaitin;
import crud.entities.tintuc;

@WebServlet("/menu/loaitin")
public class menu_Servlet extends HttpServlet {
	tintucDAO ttdao = new tintucDAO();
	loaitinDAO ltdao = new loaitinDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy categoryId từ request
		String categoryId = req.getParameter("id");
		List<loaitin> loaiTinList = ltdao.selectAll();
		req.setAttribute("loaiTinList", loaiTinList); // Đặt danh sách loại tin vào request

		int categoryID = Integer.parseInt(categoryId); // Chuyển thành số nguyên
		List<tintuc> tinTucList = ttdao.selectByCategoryTop5(categoryID); // Lấy tất cả tin thuộc loại
		req.setAttribute("tinTucList", tinTucList); // Đặt danh sách tin vào request
		List<tintuc> listnews = ttdao.selectByCategoryTopNew(categoryID);
		req.setAttribute("listnews", listnews);
		
		List<tintuc> listnews0 = ttdao.selectByCategoryTopNew(28);
		req.setAttribute("listnews0", listnews0);

		List<tintuc> listnews1 = ttdao.selectByCategoryTopNew(34);
		req.setAttribute("listnews1", listnews1);

		List<tintuc> listnews2 = ttdao.selectByCategoryTopNew(35);
		req.setAttribute("listnews2", listnews2);
		List<tintuc> listnews3 = ttdao.selectByCategoryTopNew(31);
		req.setAttribute("listnews3", listnews3);
		List<tintuc> listnews4 = ttdao.selectByCategoryTopNew(2);
		req.setAttribute("listnews4", listnews4);
		
		
		req.setAttribute("view", "/views/menu/chitiet_lt.jsp");
		req.getRequestDispatcher("/views/layout.jsp").forward(req, resp);

	}
}
