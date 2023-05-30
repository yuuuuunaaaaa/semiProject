package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.DBConnectionMgr;

public class PMemberMgr {
	private DBConnectionMgr pool;
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql=null;
	
	public PMemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//아이디 중복체크
	public boolean checkId(String id) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="SELECT ID FROM MEMBER WHERE ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			flag=rs.next(); //중복 아이디 있으면 true
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	//회원가입
	public boolean insertMember(PMemberBean bean) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="insert into member values(?,?,?,?,?,?,?,?,DEFAULT,DEFAULT,DEFAULT,DEFAULT,CART_SEQ.NEXTVAL)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getPhone());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			pstmt.setString(8, bean.getAddrdetail());
			
			if(pstmt.executeUpdate()==1)
				flag=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//회원증식
/*	public void memberadd(String a1,String a2,String a3,String a4,String a5,String a6,String a7,String a8) {
		Connection con=null;
		PreparedStatement pstmt=null;
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			String sql="insert into member values(?,?,?,?,?,?,?,?,DEFAULT,DEFAULT,DEFAULT,DEFAULT)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, a1);
			pstmt.setString(2, a2);
			pstmt.setString(3, a3);
			pstmt.setString(4, a4);
			pstmt.setString(5, a5);
			pstmt.setString(6, a6);
			pstmt.setString(7, a7);
			pstmt.setString(8, a8);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	public static void main(String[] args) {
		PMemberMgr pmgr=new PMemberMgr();
		for(int i=0;i<20;i++) {
			String a1="userrrr"+i;
			String a2="123!@#qwe"+i;
			String a3="이름"+i;
			String a4="010123412"+i;
			String a5="email"+i+"@mail.com";
			String a6="123";
			String a7="서울특별시";
			String a8=i+"층";
			pmgr.memberadd(a1, a2, a3, a4, a5, a6, a7, a8);
			
		}
	
	}*/

	//로그인
	public int loginMember(String id, String pwd) {
		int yn=0;
		
		try {
			con=pool.getConnection();
			sql="SELECT USEYN FROM MEMBER WHERE ID=? and PWD=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs=pstmt.executeQuery();
			rs.next(); //아이디 비번 일치하는 값 있으면 true
			yn=rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return yn;
	}
	
	public PMemberBean getMember(String id) {
		PMemberBean mBean=new PMemberBean();
		try {
			con=pool.getConnection();
			sql="SELECT * FROM MEMBER WHERE ID="+"'"+id+"'";
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);
			if(rs.next()) {
				mBean.setId(rs.getString(1));
				mBean.setPwd(rs.getString(2));
				mBean.setName(rs.getString(3));
				mBean.setPhone(rs.getString(4));
				mBean.setEmail(rs.getString(5));
				mBean.setZipcode(rs.getString(6));
				mBean.setAddress(rs.getString(7));
				mBean.setAddrdetail(rs.getString(8));
				mBean.setRegdate(rs.getString(9));
				mBean.setEnddate(rs.getString(10));
				mBean.setUseyn(rs.getInt(11));
				mBean.setPoint(rs.getInt(12));
				mBean.setCartnum(rs.getInt(13));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt,rs);
		}
		return mBean;
	}
	
	//이메일로 아이디 찾기->이메일, 폰으로 바꾸기(메일보내서 인증번호 받기로,, 가능하면)
	public String findinfo(String email, String name) {
		String id="";
		try {
			con=pool.getConnection();
			sql="SELECT ID FROM MEMBER WHERE EMAIL=? AND NAME=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, name);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				id=rs.getString("id");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt,rs);
		}
		return id;
	}
	
	//폰,아이디로 비밀번호 찾기
	public boolean pwdFind(String phone, String id) {
		String pwd="";
		boolean flag=false;
		try {
			con=pool.getConnection();
			sql="SELECT PWD FROM MEMBER WHERE PHONE=? AND ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, phone);
			pstmt.setString(2, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				pwd=rs.getString("PWD");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt,rs);
		}
		if(pwd!="") {
			flag=true;
		}
		return flag;
	}
	
	//폰,아이디로 비밀번호 바꾸기
	public boolean pwdUpdate(String pwd, String id, String phone) {
		int result=0;
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="UPDATE MEMBER SET PWD=? WHERE ID=? AND PHONE=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, id);
			pstmt.setString(3, phone);
			result=pstmt.executeUpdate();
			if(result==1)
				flag=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//포인트 사용
	public boolean usePoint(String id, int point) {
		boolean flag=false;
		try {
			con=pool.getConnection();
			sql="Select point from member where id='"+id+"'";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				int oldPoint=rs.getInt(1);
				point=oldPoint-point;
				
				sql="UPDATE MEMBER SET POINT=? WHERE ID=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, point);
				pstmt.setString(2, id);
				if(pstmt.executeUpdate()==1)
					flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt,rs);
		}
		return flag;
	}
}
