package crud.DAO;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import crud.entities.loaitin;
import crud.entities.tintuc;
import crud.util.JDBCHelper;

public class tintucDAO {
	String INSERT_SQL = "insert into NEWS (Title,Content,Images,PostedDate,Author,ViewCount,CategoryId,Home) values (?,?,?,?,?,?,?,?)";
    String UPDATE_SQL = "update NEWS set Title = ?,Content = ?, Images = ?, PostedDate = ?, Author = ?,ViewCount = ?,CategoryId = ?, Home = ? where NewsId = ?";
    String DELETE_SQL = "delete from NEWS where NewsId = ?";
    String SELECT_ALL_SQL = "select * from NEWS order by NewsId desc";
    String SELECT_BY_ID = "select * from NEWS where NewsId = ?";
    String SELECT_ELEMENT = "select n.*, c.CategoryName as nameLT  from NEWS n join CATEGORIES c on n.CategoryId = c.CategoryId ";
    String SELECT_TOP = "select top 5 * from NEWS where Home = 1 order by  ViewCount desc";
    String SELECT_NEW = "select * from NEWS where Home = 1 order by PostedDate desc";
    public void insert(tintuc ttuc) {
		JDBCHelper.executeUpdate(INSERT_SQL, 
				ttuc.getTitle(),
				ttuc.getContent(),
				ttuc.getImage(),
				ttuc.getPostDate(),
				ttuc.getAuthor(),
				ttuc.getViewCount(),
				ttuc.getCategoryID(),
				ttuc.isHome()
				);
	}
    public void update(tintuc ttuc) {
		JDBCHelper.executeUpdate(UPDATE_SQL, 
				ttuc.getTitle(),
				ttuc.getContent(),
				ttuc.getImage(),
				ttuc.getPostDate(),
				ttuc.getAuthor(),
				ttuc.getViewCount(),
				ttuc.getCategoryID(),
				ttuc.isHome(),
				ttuc.getNewsID()
				);
	}
    public void delete(int idTTuc) {
		JDBCHelper.executeUpdate(DELETE_SQL, idTTuc);
	}
    public List<tintuc> selectAll() {
    	return selectBySql(SELECT_ALL_SQL);
		
	}
    public List<tintuc> selectElement(){
    	return selectBySql(SELECT_ELEMENT);
    }
    
    public tintuc selectIdNews (int id) {
		List<tintuc> ls  = selectBySql(SELECT_BY_ID,id);
		if(ls.isEmpty()) {
			return null;
		}
		return ls.get(0);
	}
    
    public tintuc selectById (int id) {
    	String sql = "select n.*, c.CategoryName as nameLT  from NEWS n join CATEGORIES c on n.CategoryId = c.CategoryId where NewsId = ?";
		List<tintuc> ls  = selectBySql(sql,id);
		if(ls.isEmpty()) {
			return null;
		}
		return ls.get(0);
	}
    
    public List<tintuc>selecttop5(){
    	return selectBySql(SELECT_TOP);
    }
    
    public List<tintuc> selectByNew(){
    	return selectBySql(SELECT_NEW);
    }
    
    public List<tintuc> selectByCategory(int idLT){
    	String sql = "select * from NEWS where  and CategoryId = ?";
    	return selectBySql(sql, idLT);
    }
    
    public List<tintuc> selectByCategoryTop5(int idLT){
    	String sql = "select top 5  * from NEWS where CategoryId = ? order by ViewCount desc";
    	return selectBySql(sql, idLT);
    }
    
    public List<tintuc> selectByCategoryTopNew(int idLT){
    	String sql = "select * from NEWS where Home = 1 and CategoryId = ? order by PostedDate desc";
    	return selectBySql(sql, idLT);
    }
    public tintuc viewCount(int id) {
        // Cập nhật lượt xem
        String updateSql = "UPDATE NEWS SET ViewCount = ViewCount + 1 WHERE NewsId = ?";
        JDBCHelper.executeUpdate(updateSql, id);
        
        // Sau khi cập nhật, lấy lại thông tin của bài viết
        String selectSql = "SELECT * FROM NEWS WHERE NewsId = ?";
        List<tintuc> list = selectBySql(selectSql, id);
        
        // Nếu bài viết tồn tại, trả về đối tượng tintuc
        if (!list.isEmpty()) {
            return list.get(0); // Trả về bài viết đầu tiên trong danh sách
        }
        return null; // Trả về null nếu không tìm thấy bài viết
    }
    
    public List<tintuc> selectByAuthor(String author){
    	String sql = "select * from NEWS where Author = ? order by NewsId desc";
    	return selectBySql(sql, author);
    }
    
    public List<tintuc> findTitle(String keyword) {
        String sql = "SELECT * FROM NEWS WHERE Title LIKE ?;";
        String searchKeyword = "%" + keyword + "%";
        return selectBySql(sql, searchKeyword);
    }
    
    private List<tintuc> selectBySql(String sql, Object... args) {
        List<tintuc> list = new ArrayList<>();
        try {
            ResultSet rs = JDBCHelper.executeQuery(sql, args);
            while (rs.next()) {
                tintuc ttuc = new tintuc();
                ttuc.setNewsID(rs.getInt("NewsID"));
                ttuc.setTitle(rs.getString("Title"));
                ttuc.setContent(rs.getString("Content"));
                ttuc.setImage(rs.getString("Images"));
                ttuc.setPostDate(rs.getTimestamp("PostedDate"));
                ttuc.setAuthor(rs.getString("Author"));
                ttuc.setViewCount(rs.getInt("ViewCount"));
                ttuc.setCategoryID(rs.getInt("CategoryId"));
                ttuc.setHome(rs.getBoolean("Home"));
                loaitin lt = new loaitin();
                lt.setCategoryID(rs.getInt("CategoryId"));
                try {
                    lt.setCategoryName(rs.getString("nameLT")); 
                } catch (SQLException e) {
//                    System.out.println("Error retrieving nameLT: " + e.getMessage());
                    lt.setCategoryName(""); // hoặc giá trị mặc định
                }
                ttuc.setLtName(lt);

                
                list.add(ttuc);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
