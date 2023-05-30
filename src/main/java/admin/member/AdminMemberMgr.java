package admin.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import db.DBConnectionMgr;
import member.PMemberBean;

public class AdminMemberMgr {
	private DBConnectionMgr pool;
	
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql=null;
	
	public AdminMemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//회원정보 전부 가져오기
	public ArrayList<PMemberBean> getAllMember(){
		ArrayList<PMemberBean> alist=new ArrayList<>();
		
		try {
			con=pool.getConnection();
			sql="select * from member order by regdate, name";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				PMemberBean pBean=new PMemberBean();
				pBean.setId(rs.getString(1));
				pBean.setPwd(rs.getString(2));
				pBean.setName(rs.getString(3));
				pBean.setPhone(rs.getString(4));
				pBean.setEmail(rs.getString(5));
				pBean.setZipcode(rs.getString(6));
				pBean.setAddress(rs.getString(7));
				pBean.setAddrdetail(rs.getString(8));
				pBean.setRegdate(rs.getString(9));
				pBean.setEnddate(rs.getString(10));
				pBean.setUseyn(rs.getInt(11));
				pBean.setPoint(rs.getInt(12));
				pBean.setCartnum(rs.getInt(13));
				alist.add(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return alist;
	}
	
	//회원 삭제
	public boolean memberDel(String id[]) {
		boolean flag=false;
		int result=0;
		
		try {
			con=pool.getConnection();
			for(int i=0;i<id.length;i++) {
				sql="delete from member where id="+"'"+id[i]+"'";
				pstmt=con.prepareStatement(sql);
				if(pstmt.executeUpdate()==1) {
					result++;
				}
			}
			if(result==id.length) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt);
		}
		return flag;
	}
	//회원정보 업데이트
	public boolean updateMember(PMemberBean pBean, String orginId) {
		boolean flag=false;
		try {
			con=pool.getConnection();
			sql="update member set id=?, pwd=?,name=?,phone=?,zipcode=?,address=?,Addrdetail=?,useyn=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pBean.getId());
			pstmt.setString(2, pBean.getPwd());
			pstmt.setString(3, pBean.getName());
			pstmt.setString(4, pBean.getPhone());
			pstmt.setString(5, pBean.getZipcode());
			pstmt.setString(6, pBean.getAddress());
			pstmt.setString(7, pBean.getAddrdetail());
			pstmt.setInt(8, pBean.getUseyn());
			pstmt.setString(9, orginId);
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt);
		}
		return flag;
	}
	//회원 탈퇴여부 변경
	public boolean ynUpdateMember(String id[]) {
		boolean flag=false;
		int result=0;
		try {
			con=pool.getConnection();
			for(int i=0;i<id.length;i++) {
				sql="select useyn from member where id="+"'"+id[i]+"'";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				rs.next();
				int yn=rs.getInt(1);
				if(yn==1) {
					sql="update member set useyn=2, enddate=sysdate where id="+"'"+id[i]+"'";
					pstmt=con.prepareStatement(sql);
					if(pstmt.executeUpdate()==1) {
						result++;
					}
				}else {
					sql="update member set useyn=1, enddate=default where id="+"'"+id[i]+"'";
					pstmt=con.prepareStatement(sql);
					if(pstmt.executeUpdate()==1) {
						result++;
					}
				}
			}
			if(result==id.length) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt);
		}
		return flag;
	}
}
