package crud.DAO;

import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import crud.entities.nguoidung;
import crud.util.JDBCHelper;

public class nguoidungDAO {
	String INSERT_SQL = "insert into USERS values (?,?,?,?,?,?,?,?)";
    String UPDATE_SQL = "update USERS set Passwords = ?,Fullname = ?, Birthday = ?, Gender = ?, Mobile = ?,Email = ?,Roles = ? where UserId = ?";
    String DELETE_SQL = "delete from USERS where UserId = ?";
    String SELECT_ALL_SQL = "select * from USERS";
    String SELECT_BY_ID = "select * from USERS where UserId = ?";
    
    public void insert(nguoidung ngdung) {
    	JDBCHelper.executeUpdate(INSERT_SQL,
    			ngdung.getUserID(),
    			ngdung.getPassword(),
    			ngdung.getFullName(),
    			ngdung.getBirthday(),
    			ngdung.isGender(),
    			ngdung.getMobile(),
    			ngdung.getEmail(),
    			ngdung.isRole());
		
	}
    
    public void update(nguoidung ngdung) {
    	JDBCHelper.executeUpdate(UPDATE_SQL,
    			ngdung.getPassword(),
    			ngdung.getFullName(),
    			ngdung.getBirthday(),
    			ngdung.isGender(),
    			ngdung.getMobile(),
    			ngdung.getEmail(),
    			ngdung.isRole(),
    			ngdung.getUserID());
	}
    public void delete(String userID) {
    	JDBCHelper.executeUpdate(DELETE_SQL, userID);
		
	}
    
    public List<nguoidung> selectAll() {
    	return selectBySQL(SELECT_ALL_SQL);
	}
    
    public nguoidung selectByID (String id) {
		List<nguoidung> list = selectBySQL(SELECT_BY_ID, id);
		if(list.isEmpty()) {
			return null;
		}
		return list.get(0);
	}
    
    
    private List<nguoidung> selectBySQL(String sql,Object...args){
    	List<nguoidung> list = new ArrayList<>();
    	try {
			ResultSet rs =  JDBCHelper.executeQuery(sql, args);
			while(rs.next()) {
				nguoidung ngdung = new nguoidung();
				ngdung.setUserID(rs.getString(1));
				ngdung.setPassword(rs.getString(2));
				ngdung.setFullName(rs.getString(3));
				ngdung.setBirthday(rs.getObject(4,LocalDate.class));
				ngdung.setGender(rs.getBoolean(5));
				ngdung.setMobile(rs.getString(6));
				ngdung.setEmail(rs.getString(7));
				ngdung.setRole(rs.getBoolean(8));
				list.add(ngdung);
			}
			rs.getStatement().getConnection().close();
			return list;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
}
