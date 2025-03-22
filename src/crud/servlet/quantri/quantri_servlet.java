package crud.servlet.quantri;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import crud.DAO.loaitinDAO;
import crud.DAO.nguoidungDAO;
import crud.DAO.tintucDAO;
import crud.entities.loaitin;
import crud.entities.nguoidung;

@WebServlet("/quantri/index")
public class quantri_servlet  extends HttpServlet{

@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	req.getRequestDispatcher("/views/quantri/quanly.jsp").forward(req, resp);
	
}
@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
}
