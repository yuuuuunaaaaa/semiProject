package view;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import admin.order.OrderMgr;
import admin.product.ProductBean;
import db.DBConnectionMgr;

public class ProductViewMgr {

	private DBConnectionMgr pool;
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql=null;
	
	public ProductViewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	

	//사용중인 상품 리스트 가져오기
	public ArrayList<ProductBean> getProductYList(String order){
		ArrayList<ProductBean> alist = new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from product where useyn='Y' order by regdate desc";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductBean pBean=new ProductBean();
				pBean.setPronum(rs.getInt(1));
				pBean.setProname(rs.getString(2));
				pBean.setCategory(rs.getInt(3));
				pBean.setCost(rs.getInt(4));
				pBean.setPrice(rs.getInt(5));
				pBean.setSale(rs.getInt(6));
				pBean.setProfit(rs.getInt(7));
				pBean.setThumb(rs.getString(8));
				pBean.setImg(rs.getString(9));
				pBean.setContent(rs.getString(10));
				pBean.setUseyn(rs.getString(11));
				pBean.setRegdate(rs.getString(12));
				pBean.setStock(rs.getInt(13));
				pBean.setSaleqtt(rs.getInt(14));
				pBean.setType(rs.getString(15));
				alist.add(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	
	//사용중인 상품 검색해서 가져오기
	public ArrayList<ProductBean> searchProductY(int num[]){
		ArrayList<ProductBean> alist = new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from product where useyn='Y' and pronum=?";
			
			pstmt=con.prepareStatement(sql);
			for(int i=0;i<num.length;i++) {
				pstmt.setInt(1, num[i]);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					ProductBean pBean=new ProductBean();
					pBean.setPronum(rs.getInt(1));
					pBean.setProname(rs.getString(2));
					pBean.setCategory(rs.getInt(3));
					pBean.setCost(rs.getInt(4));
					pBean.setPrice(rs.getInt(5));
					pBean.setSale(rs.getInt(6));
					pBean.setProfit(rs.getInt(7));
					pBean.setThumb(rs.getString(8));
					pBean.setImg(rs.getString(9));
					pBean.setContent(rs.getString(10));
					pBean.setUseyn(rs.getString(11));
					pBean.setRegdate(rs.getString(12));
					pBean.setStock(rs.getInt(13));
					pBean.setSaleqtt(rs.getInt(14));
					pBean.setType(rs.getString(15));
					alist.add(pBean);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	
	//사용중인 상품 리스트 타입별로 가져오기
	public ArrayList<ProductBean> getProductYListByType(String type, String order){
		ArrayList<ProductBean> alist = new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from product where useyn='Y' and type=? order by regdate desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, type);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductBean pBean=new ProductBean();
				pBean.setPronum(rs.getInt(1));
				pBean.setProname(rs.getString(2));
				pBean.setCategory(rs.getInt(3));
				pBean.setCost(rs.getInt(4));
				pBean.setPrice(rs.getInt(5));
				pBean.setSale(rs.getInt(6));
				pBean.setProfit(rs.getInt(7));
				pBean.setThumb(rs.getString(8));
				pBean.setImg(rs.getString(9));
				pBean.setContent(rs.getString(10));
				pBean.setUseyn(rs.getString(11));
				pBean.setRegdate(rs.getString(12));
				pBean.setStock(rs.getInt(13));
				pBean.setSaleqtt(rs.getInt(14));
				pBean.setType(rs.getString(15));
				alist.add(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	//사용중인 상품 리스트 카테고리별로 가져오기
	public ArrayList<ProductBean> getProductYListByType(int category){
		ArrayList<ProductBean> alist = new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from product where useyn='Y' and category=? order by regdate desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, category);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductBean pBean=new ProductBean();
				pBean.setPronum(rs.getInt(1));
				pBean.setProname(rs.getString(2));
				pBean.setCategory(rs.getInt(3));
				pBean.setCost(rs.getInt(4));
				pBean.setPrice(rs.getInt(5));
				pBean.setSale(rs.getInt(6));
				pBean.setProfit(rs.getInt(7));
				pBean.setThumb(rs.getString(8));
				pBean.setImg(rs.getString(9));
				pBean.setContent(rs.getString(10));
				pBean.setUseyn(rs.getString(11));
				pBean.setRegdate(rs.getString(12));
				pBean.setStock(rs.getInt(13));
				pBean.setSaleqtt(rs.getInt(14));
				pBean.setType(rs.getString(15));
				alist.add(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	//세일중인 상품 가져오기
	public ArrayList<ProductBean> getSaleProduct(){
		ArrayList<ProductBean> alist = new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from product where useyn='Y' and sale<price order by regdate desc";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductBean pBean=new ProductBean();
				pBean.setPronum(rs.getInt(1));
				pBean.setProname(rs.getString(2));
				pBean.setCategory(rs.getInt(3));
				pBean.setCost(rs.getInt(4));
				pBean.setPrice(rs.getInt(5));
				pBean.setSale(rs.getInt(6));
				pBean.setProfit(rs.getInt(7));
				pBean.setThumb(rs.getString(8));
				pBean.setImg(rs.getString(9));
				pBean.setContent(rs.getString(10));
				pBean.setUseyn(rs.getString(11));
				pBean.setRegdate(rs.getString(12));
				pBean.setStock(rs.getInt(13));
				pBean.setSaleqtt(rs.getInt(14));
				pBean.setType(rs.getString(15));
				alist.add(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	//신상품(등록 한달 이내) 가져오기
	public ArrayList<ProductBean> getNewProduct(){
		ArrayList<ProductBean> alist = new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from product where useyn='Y' and regdate>add_months(sysdate,-1) order by regdate desc";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductBean pBean=new ProductBean();
				pBean.setPronum(rs.getInt(1));
				pBean.setProname(rs.getString(2));
				pBean.setCategory(rs.getInt(3));
				pBean.setCost(rs.getInt(4));
				pBean.setPrice(rs.getInt(5));
				pBean.setSale(rs.getInt(6));
				pBean.setProfit(rs.getInt(7));
				pBean.setThumb(rs.getString(8));
				pBean.setImg(rs.getString(9));
				pBean.setContent(rs.getString(10));
				pBean.setUseyn(rs.getString(11));
				pBean.setRegdate(rs.getString(12));
				pBean.setStock(rs.getInt(13));
				pBean.setSaleqtt(rs.getInt(14));
				pBean.setType(rs.getString(15));
				alist.add(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	//검색하기
	public ArrayList<ProductBean> getProductYListByKeyword(String keyword){
		ArrayList<ProductBean> alist = new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from product where useyn='Y' and proname like '%"+keyword+"%' order by regdate desc";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductBean pBean=new ProductBean();
				pBean.setPronum(rs.getInt(1));
				pBean.setProname(rs.getString(2));
				pBean.setCategory(rs.getInt(3));
				pBean.setCost(rs.getInt(4));
				pBean.setPrice(rs.getInt(5));
				pBean.setSale(rs.getInt(6));
				pBean.setProfit(rs.getInt(7));
				pBean.setThumb(rs.getString(8));
				pBean.setImg(rs.getString(9));
				pBean.setContent(rs.getString(10));
				pBean.setUseyn(rs.getString(11));
				pBean.setRegdate(rs.getString(12));
				pBean.setStock(rs.getInt(13));
				pBean.setSaleqtt(rs.getInt(14));
				pBean.setType(rs.getString(15));
				alist.add(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	//주문등록
	public boolean purchaseIn(ArrayList<OrderBean> alist, OrderBean oBean, int cartnum) {
		boolean flag=false;
		int count=0;
		
		try {
			con=pool.getConnection();
			sql="insert into orders (ORDERNUM, ID, INDATE, NAME,ZIPCODE,ADDRESS ,ADDRDETAIL,PHONE,POINT,FINALPRICE,PROCCESS) "
					+ "values(order_seq.nextval,?,default,?,?,?,?,?,?,?,1)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, oBean.getId());
			pstmt.setString(2, oBean.getName());
			pstmt.setString(3, oBean.getZipcode());
			pstmt.setString(4, oBean.getAddress());
			pstmt.setString(5, oBean.getAddrdetail());
			pstmt.setString(6, oBean.getPhone());
			pstmt.setInt(7, oBean.getPoint());
			pstmt.setInt(8, oBean.getFinalPrice());
			if(pstmt.executeUpdate()==1) {
				sql="select order_seq.currval from dual";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				rs.next();
				int ordernum=rs.getInt(1);
				for(int i=0;i<alist.size();i++) {
					OrderBean odBean=new OrderBean();
					odBean=alist.get(i);
					sql="insert into ORDERDETAIL values(?,?,?,default)";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, ordernum);
					pstmt.setInt(2, odBean.getPronum());
					pstmt.setInt(3, odBean.getQuantity());
					if(pstmt.executeUpdate()==1) {
						count++;
					}
				}
				if(count==alist.size()) {
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
/*
	public static void main(String[] args) {
		for(int i=0;i<3;i++) {
		boolean result=new ProductViewMgr().
				updateCartYN(19,new OrderMgr().getOrderDetails(44).get(i).getPronum());
		System.out.println(result);
		}
	}
*/
	//카트에서 삭제
	public boolean updateCartYN(int cartnum, int pronum) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="delete cart where cartnum=? and pronum=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cartnum);
			pstmt.setInt(2, pronum);
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return flag;
	}
	
}
