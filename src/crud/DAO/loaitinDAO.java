package crud.DAO;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import crud.entities.loaitin;
import crud.entities.nguoidung;
import crud.util.JDBCHelper;

public class loaitinDAO {
	String INSERT_SQL = "insert into CATEGORIES (CategoryName) values (?)";
    String UPDATE_SQL = "update CATEGORIES set CategoryName = ? where CategoryId = ?";
    String DELETE_SQL = "delete from CATEGORIES where CategoryId = ?";
    String SELECT_ALL_SQL = "select * from CATEGORIES";
    String SELECT_BY_ID = "select * from CATEGORIES where CategoryId = ?";
    
    public void insert( loaitin ltin) {
    	JDBCHelper.executeUpdate(INSERT_SQL,
    			ltin.getCategoryName()
    			);
	}
    public void update( loaitin ltin) {
    	JDBCHelper.executeUpdate(UPDATE_SQL,
    			ltin.getCategoryName(),
    			ltin.getCategoryID()
    			);
    			
	}
    public void delete(int idLTin) {
		JDBCHelper.executeUpdate(DELETE_SQL, idLTin);
	}
    public List<loaitin> selectAll() {
		return selectBySql(SELECT_ALL_SQL);
	}
    public loaitin selectByID (int ID) {
		List<loaitin> list = selectBySql(SELECT_BY_ID, ID);
		if(list.isEmpty()) {
			return null;
		}
		return list.get(0);
	}
    
    
    private List<loaitin> selectBySql(String sql, Object... args) {
        List<loaitin> list=new ArrayList<>(); 
       try {
           ResultSet rs = JDBCHelper.executeQuery(sql, args);
           while(rs.next()){
               loaitin ltin = new loaitin();
               ltin.setCategoryID(rs.getInt(1));
               ltin.setCategoryName(rs.getString(2));
               
              
               list.add(ltin);
           }
           rs.getStatement().getConnection().close();
           return list;
       } catch (Exception e) { 
           throw new RuntimeException(e);
       }
   }
}
