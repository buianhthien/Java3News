package crud.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCHelper {
	private static String driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static String dburl = "jdbc:sqlserver://localhost:1433;encrypt=false;database=NEWSPAPER";
	private static String username = "sa";
	private static String password = "123";

	static {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}
	
	public static PreparedStatement getSttm(String sql, Object... args) throws SQLException {
		Connection conn = DriverManager.getConnection(dburl, username, password);
		PreparedStatement psttm;
		if (sql.trim().startsWith("{")) {
			psttm = conn.prepareCall(sql);
		} else {
			psttm = conn.prepareStatement(sql);
		}
		for (int i = 0; i < args.length; i++) {
			psttm.setObject(i + 1, args[i]);
		}
		return psttm;

	}
	
	public static int executeUpdate(String sql, Object... args) {
		try {
			PreparedStatement sttm = JDBCHelper.getSttm(sql, args);
			try {
				return sttm.executeUpdate();
			} finally {
				sttm.getConnection().close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}

	}
	
	public static ResultSet executeQuery(String sql, Object... args) throws SQLException {
		PreparedStatement stmt = JDBCHelper.getSttm(sql, args);
		return stmt.executeQuery();
	}

	public static Object value(String sql, Object... args) {
		try {
			ResultSet rs = JDBCHelper.executeQuery(sql, args);
			if (rs.next()) {
				return rs.getObject(0);
			}
			rs.getStatement().getConnection().close();
			return null;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static Object values(String sql, Object... args) {
		try {
			ResultSet rs = JDBCHelper.executeQuery(sql, args);
			if (rs.next()) {
				return rs.getObject(0);
			}
			rs.getStatement().getConnection().close();
			return null;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}

}
