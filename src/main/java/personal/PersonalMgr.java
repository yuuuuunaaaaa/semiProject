package personal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.order.OrderMgr;
import db.DBConnectionMgr;
import member.PMemberBean;
import view.OrderBean;

public class PersonalMgr {


	private DBConnectionMgr pool;
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql=null;
	
	public PersonalMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	public PMemberBean getMemInfo(String id) {
		PMemberBean mBean=new PMemberBean();
		try {
			con=pool.getConnection();
			sql="select * from member where id="+"'"+id+"'";
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return mBean;
	}
	
	//회원정보 수정
	public boolean updateMember(PMemberBean mBean) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			String id=mBean.getId();
			sql="update member set pwd=?, name=?,phone=?,email=?,zipcode=?,Address=?,Addrdetail=? where id="+"'"+id+"'";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mBean.getPwd());
			pstmt.setString(2, mBean.getName());
			pstmt.setString(3, mBean.getPhone());
			pstmt.setString(4, mBean.getEmail());
			pstmt.setString(5, mBean.getZipcode());
			pstmt.setString(6, mBean.getAddress());
			pstmt.setString(7, mBean.getAddrdetail());
			
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
	
	//회원 탈퇴
	public boolean deleteMember(String id) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="update member set USEYN=2 where id="+"'"+id+"'";
			pstmt=con.prepareStatement(sql);
			
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
	
	//리뷰 작성 가능한 상품 다 가져오기(배송 완료 상태에서만 작성 가능)
	public ArrayList<OrderBean> getAbleReviewList(String id){
		ArrayList<OrderBean> alist=new ArrayList<OrderBean>();
		
		try {
			con=pool.getConnection();
			sql="select ordernum from orders where PROCCESS=5 and id='"+id+"'";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				int ordernum=rs.getInt(1);
				sql="select * from orderdetail where review=0 and ordernum="+ordernum;
				pstmt=con.prepareStatement(sql);
				ResultSet rs2=pstmt.executeQuery();
				while(rs2.next()) {
					OrderBean odBean=new OrderBean();
					odBean.setOrdernum(rs2.getInt(1));
					odBean.setPronum(rs2.getInt(2));
					odBean.setQuantity(rs2.getInt(3));
					odBean.setReview(rs2.getInt(4));
					alist.add(odBean);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		return alist;
	}
	
	//리뷰 넣기
	private static final String SAVEFOLDER="C:\\KYA\\04_jsp\\project\\src\\main\\webapp\\resource\\fileupload"; //파일 저장할 위치
	private static final String ENCTYPE="UTF-8";
	private static final int MAXSIZE=5*1024*1024*1024;
	static int reviewnum;
	
	public boolean InsertReview(HttpServletRequest request) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			
			MultipartRequest multi=null; 
			String img=null;
			
			multi=new MultipartRequest(request,SAVEFOLDER,MAXSIZE,ENCTYPE,new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("img")!=null) {
				img=multi.getFilesystemName("img");
			}
			int ordernum=Integer.parseInt(multi.getParameter("ordernum"));
			int pronum=Integer.parseInt(multi.getParameter("pronum"));
			sql="INSERT INTO REVIEW VALUES(?, ?, ?, ?, ?, ?, ?, default, REVIEW_SEQ.NEXTVAL)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ordernum);
			pstmt.setInt(2, pronum);
			pstmt.setString(3, multi.getParameter("id"));
			pstmt.setString(4, multi.getParameter("title"));
			pstmt.setString(5, multi.getParameter("content"));
			pstmt.setString(6, img);
			pstmt.setInt(7, Integer.parseInt(multi.getParameter("rate")));
			
			if(pstmt.executeUpdate()==1) {
				sql="select REVIEW_SEQ.CURRVAL FROM DUAL";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					reviewnum=rs.getInt(1);
				}
				
				sql="update orderdetail set review=1 where ordernum=? and pronum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, ordernum);
				pstmt.setInt(2, pronum);
				if(pstmt.executeUpdate()==1) {
					flag=true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return flag;
	}
	//리뷰 가져가기
	public ReviewBean getReview(int reviewnum) {
		ReviewBean rBean=new ReviewBean();
		try {
			con=pool.getConnection();
			sql="select * from review where reviewnum="+reviewnum;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				rBean.setOrdernum(rs.getInt(1));
				rBean.setPronum(rs.getInt(2));
				rBean.setId(rs.getString(3));
				rBean.setTitle(rs.getString(4));
				rBean.setContent(rs.getString(5));
				rBean.setImg(rs.getString(6));
				rBean.setRate(rs.getInt(7));
				rBean.setRegdate(rs.getString(8));
				rBean.setReviewnum(rs.getInt(9));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rBean;
	}
	//리뷰번호 찾기
	public int getReviewNum(int pronum, int ordernum) {
		int reviewnum=0;
		try {
			con=pool.getConnection();
			sql="select REVIEWNUM from review where pronum=? and ordernum=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pronum);
			pstmt.setInt(2, ordernum);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				reviewnum=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return reviewnum;
	}
	
	//상품별 리뷰 가져오기
	public ArrayList<ReviewBean> getReviewBypronum(int pronum) {
		ArrayList<ReviewBean> alist=new ArrayList<ReviewBean>();
		try {
			con=pool.getConnection();
			sql="select * from review where pronum="+pronum;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean rBean=new ReviewBean();
				rBean.setOrdernum(rs.getInt(1));
				rBean.setPronum(rs.getInt(2));
				rBean.setId(rs.getString(3));
				rBean.setTitle(rs.getString(4));
				rBean.setContent(rs.getString(5));
				rBean.setImg(rs.getString(6));
				rBean.setRate(rs.getInt(7));
				rBean.setRegdate(rs.getString(8));
				rBean.setReviewnum(rs.getInt(9));
				alist.add(rBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return alist;
	}
}
