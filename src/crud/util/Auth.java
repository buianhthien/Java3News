package crud.util;

import crud.entities.nguoidung;

public class Auth {
	 public static nguoidung user =  null;
	    public static void clear(){
	        Auth.user = null;
	    }
	    public static boolean isLogin(){
	        return Auth.user!= null;
	    }
	    public static boolean isManager(){
	        return Auth.isLogin()&&user.isRole();
	    }
}
