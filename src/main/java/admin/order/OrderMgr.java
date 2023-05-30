package admin.order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import db.DBConnectionMgr;
import view.OrderBean;

public class OrderMgr {
	
	private DBConnectionMgr pool;
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql=null;
	
	public OrderMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public ArrayList<OrderBean> getOrdertList(){
		ArrayList<OrderBean> alist = new ArrayList<OrderBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from orders order by INDATE desc";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			int i=0;
			while(rs.next()) {
				OrderBean oBean=new OrderBean();
				oBean.setOrdernum(rs.getInt(1));
				oBean.setId(rs.getString(2));
				oBean.setIndate(rs.getString(3));
				oBean.setProccess(rs.getInt(4));
				oBean.setPostnum(rs.getString(5));
				oBean.setFinaldate(rs.getString(6));
				oBean.setName(rs.getString(7));
				oBean.setZipcode(rs.getString(8));
				oBean.setAddress(rs.getString(9));
				oBean.setAddrdetail(rs.getString(10));
				oBean.setPhone(rs.getString(11));
				oBean.setPoint(rs.getInt(12));
				oBean.setFinalPrice(rs.getInt(13));
				
				alist.add(i,oBean); i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	
	//오더넘 정보 하나 가져오기
	public OrderBean getOrder(int ordernum){
		OrderBean oBean=new OrderBean();
		try {
			con=pool.getConnection();
			sql="select * from orders where ordernum="+ordernum;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			rs.next();
			
			oBean.setOrdernum(rs.getInt(1));
			oBean.setId(rs.getString(2));
			oBean.setIndate(rs.getString(3));
			oBean.setProccess(rs.getInt(4));
			oBean.setPostnum(rs.getString(5));
			oBean.setFinaldate(rs.getString(6));
			oBean.setName(rs.getString(7));
			oBean.setZipcode(rs.getString(8));
			oBean.setAddress(rs.getString(9));
			oBean.setAddrdetail(rs.getString(10));
			oBean.setPhone(rs.getString(11));
			oBean.setPoint(rs.getInt(12));
			oBean.setFinalPrice(rs.getInt(13));
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return oBean;
	}
	
	//디테일 정보 가져오기
	public ArrayList<OrderBean> getOrderDetails(int ordernum){
		ArrayList<OrderBean> alist=new ArrayList<OrderBean>();
		try {
			con=pool.getConnection();
			sql="select * from ORDERDETAIL where ordernum="+ordernum;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			int i=0;
			while(rs.next()) {
			OrderBean odBean=new OrderBean();
			
			odBean.setOrdernum(rs.getInt(1));
			odBean.setPronum(rs.getInt(2));
			odBean.setQuantity(rs.getInt(3));
			odBean.setReview(rs.getInt(4));
			alist.add(i, odBean); i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	
	//아이디별 정보 다 가져오기
	public ArrayList<OrderBean> getOrderById(String id){
		ArrayList<OrderBean> alist=new ArrayList<OrderBean>();
		try {
			con=pool.getConnection();
			sql="select * from orders where id='"+id+"' order by indate desc";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OrderBean oBean=new OrderBean();
				oBean.setOrdernum(rs.getInt(1));
				oBean.setId(rs.getString(2));
				oBean.setIndate(rs.getString(3));
				oBean.setProccess(rs.getInt(4));
				oBean.setPostnum(rs.getString(5));
				oBean.setFinaldate(rs.getString(6));
				oBean.setName(rs.getString(7));
				oBean.setZipcode(rs.getString(8));
				oBean.setAddress(rs.getString(9));
				oBean.setAddrdetail(rs.getString(10));
				oBean.setPhone(rs.getString(11));
				oBean.setPoint(rs.getInt(12));
				oBean.setFinalPrice(rs.getInt(13));
				alist.add(oBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	
	//처리 업뎃
	public int procUpdate(int ordernum, int process, String postnum) {
		int flag=0;
		
		try {
			con=pool.getConnection();
			
			if(process==2 && (postnum==null || postnum.equals("-"))) {
				sql="update orders set PROCCESS=? where ordernum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, process);
				pstmt.setInt(2, ordernum);
				if(pstmt.executeUpdate()==1) {
					flag=5;
				}
			}else if(process==2 && postnum!=null) {
				sql="update orders set PROCCESS=?, postnum=? where ordernum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, process);
				pstmt.setString(2, postnum);
				pstmt.setInt(3, ordernum);
				if(pstmt.executeUpdate()==1) {
					flag=5;
				}
			}
			else if(postnum==null || postnum.equals("-")) {
				flag=3;
			}
			else if(process==5) {
				sql="update orders set PROCCESS=?, postnum=?, FINALDATE=sysdate where ordernum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, process);
				pstmt.setString(2, postnum);
				pstmt.setInt(3, ordernum);
				if(pstmt.executeUpdate()==1) {
					sql="select point, id from orders where ordernum="+ordernum;
					pstmt=con.prepareStatement(sql);
					rs=pstmt.executeQuery();
					
					if(rs.next()) {
						int point=rs.getInt(1);
						
						String id=rs.getString(2);
						sql="select point from member where id='"+id+"'";
						pstmt=con.prepareStatement(sql);
						rs=pstmt.executeQuery();
						if(rs.next()) {
							int oldPoint=rs.getInt(1);
							
							sql="update member set point=? where id=?";
							point=point+oldPoint;
							pstmt=con.prepareStatement(sql);
							pstmt.setInt(1, point);
							pstmt.setString(2, id);
							if(pstmt.executeUpdate()==1) {
								flag=5;
							}
						}
					}
				}
			}
			else {
				sql="update orders set PROCCESS=?, postnum=? where ordernum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, process);
				pstmt.setString(2, postnum);
				pstmt.setInt(3, ordernum);
				if(pstmt.executeUpdate()==1) {
					flag=5;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		return flag;
	}
	//카트 추가
	public boolean addCart(CartBean cBean) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="insert into cart values(?,?,?,?,default,default)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cBean.getCartnum());
			pstmt.setString(2, cBean.getId());
			pstmt.setInt(3, cBean.getPronum());
			pstmt.setInt(4, cBean.getQuantity());
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
	
	//카트 중복 체크
	public boolean cartDoubleChk(CartBean cBean) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="select * from cart where cartnum=? and pronum=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cBean.getCartnum());
			pstmt.setInt(2, cBean.getPronum());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return flag;
	}
	//카트 수량 업
	public boolean updateCart(CartBean cBean) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="select * from cart where cartnum=? and pronum=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cBean.getCartnum());
			pstmt.setInt(2, cBean.getPronum());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				int qtt=rs.getInt(4);
				qtt=qtt+cBean.getQuantity();
				sql="update cart set QUANTITY=? where  cartnum=? and pronum=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, qtt);
				pstmt.setInt(2, cBean.getCartnum());
				pstmt.setInt(3, cBean.getPronum());
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
	//카트 번호 검색해서 다가져오기
	public ArrayList<CartBean> getCartList(int cartnum){
		ArrayList<CartBean> alist=new ArrayList<CartBean>();
		
		try {
			con=pool.getConnection();
			sql="Select * from cart where PURCHASE='N' and cartnum="+cartnum;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				CartBean cBean=new CartBean();
				cBean.setId(rs.getString(2));
				cBean.setPronum(rs.getInt(3));
				cBean.setQuantity(rs.getInt(4));
				cBean.setIndate(rs.getString(5));
				cBean.setPurchase(rs.getString(6));
				alist.add(cBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		return alist;
	}
	
}
