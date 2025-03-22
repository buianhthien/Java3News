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

@WebServlet("/seach")
public class seach_Servlet extends HttpServlet {
	tintucDAO ttdao =  new tintucDAO();
	loaitinDAO ltdao = new loaitinDAO();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		        String keyword = req.getParameter("keyword"); // Lấy từ khóa tìm kiếm
		        List<tintuc> results = ttdao.findTitle(keyword); // Tìm kiếm theo tiêu đề
		        
		        List<loaitin> loaiTinList = ltdao.selectAll();
				req.setAttribute("loaiTinList", loaiTinList); // Đặt danh sách loại tin vào request
				
				  // Lấy danh sách bài viết hàng đầu
		        List<tintuc> toptin = ttdao.selecttop5();
		        req.setAttribute("tintuc", toptin);
		        
		     // Lấy danh sách tin mới
				List<tintuc> tinmoi = ttdao.selectByNew();
				req.setAttribute("news", tinmoi);
		        
		        req.setAttribute("results", results); // Lưu kết quả vào request
		        req.getRequestDispatcher("/views/timkiem.jsp").forward(req, resp);
		    }
}
