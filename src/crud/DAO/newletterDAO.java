package crud.DAO;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import crud.entities.newletter;
import crud.util.JDBCHelper;

public class newletterDAO {
    // Các câu lệnh SQL
    String INSERT_SQL = "INSERT INTO NEWSLETTERS (Email, Status) VALUES (?, ?)";
    String UPDATE_SQL = "UPDATE NEWSLETTERS SET Status = ? WHERE Email = ?";
    String DELETE_SQL = "DELETE FROM NEWSLETTERS WHERE Email = ?";
    String SELECT_ALL_SQL = "SELECT * FROM NEWSLETTERS";
    String SELECT_BY_ID = "SELECT * FROM NEWSLETTERS WHERE Email = ?";
    
    // Phương thức thêm email vào bảng newletter
    public void insert(newletter letter) {
        JDBCHelper.executeUpdate(INSERT_SQL,
                letter.getEmail(),
                letter.isStatus() // Trạng thái của email
        );
    }

    // Phương thức cập nhật trạng thái email
    public void update(newletter letter) {
        JDBCHelper.executeUpdate(UPDATE_SQL,
                letter.isStatus(),
                letter.getEmail()
        );
    }

    // Phương thức xóa email khỏi bảng newletter
    public void delete(String email) {
        JDBCHelper.executeUpdate(DELETE_SQL, email);
    }

    // Phương thức lấy tất cả các email
    public List<newletter> selectAll() {
        return selectBySql(SELECT_ALL_SQL);
    }

    // Phương thức lấy email theo ID
    public newletter selectByID(String email) {
        List<newletter> list = selectBySql(SELECT_BY_ID, email);
        return list.isEmpty() ? null : list.get(0);
    }

    // Phương thức kiểm tra xem email đã tồn tại hay chưa
    public boolean isEmailExists(String email) {
        newletter letter = selectByID(email);
        return letter != null; // Nếu letter != null, email đã tồn tại
    }

    // Phương thức lấy danh sách email có trạng thái là true
    public List<String> getAllActiveEmails() {
        List<String> emails = new ArrayList<>();
        String SELECT_EMAILS_SQL = "SELECT Email FROM NEWSLETTERS WHERE Status = 1"; // Câu lệnh SQL lấy email có trạng thái true

        try {
            ResultSet rs = JDBCHelper.executeQuery(SELECT_EMAILS_SQL);
            while (rs.next()) {
                emails.add(rs.getString("Email")); // Thêm email vào danh sách
            }
            rs.getStatement().getConnection().close(); // Đóng kết nối
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return emails; // Trả về danh sách email
    }

    // Phương thức lấy danh sách email theo câu lệnh SQL
    private List<newletter> selectBySql(String sql, Object... args) {
        List<newletter> list = new ArrayList<>();
        try {
            ResultSet rs = JDBCHelper.executeQuery(sql, args);
            while (rs.next()) {
                newletter letter = new newletter();
                letter.setEmail(rs.getString(1));
                letter.setStatus(rs.getBoolean(2));
                list.add(letter);
            }
            rs.getStatement().getConnection().close();
            return list;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
