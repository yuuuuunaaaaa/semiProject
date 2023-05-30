package admin.product;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import db.DBConnectionMgr;

public class ProductMgr {
	private DBConnectionMgr pool;
	
	//multimart 필요한 정보들 변수에 담아놓기
	private static final String SAVEFOLDER="C:\\KYA\\04_jsp\\project\\src\\main\\webapp\\resource\\fileupload"; //파일 저장할 위치
	private static final String ENCTYPE="UTF-8";
	private static final int MAXSIZE=5*1024*1024*1024;
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql=null;
	
	public ProductMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean InsertProduct(HttpServletRequest request) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			
			MultipartRequest multi=null; 
			String thumb=null;
			String img=null;
			
			multi=new MultipartRequest(request,SAVEFOLDER,MAXSIZE,ENCTYPE,new DefaultFileRenamePolicy());
			Enumeration files=multi.getFileNames();
			
			if(files!=null) {
				img=(String)files.nextElement();
				img=multi.getFilesystemName(img);
				
				thumb=(String)files.nextElement();
				thumb=multi.getFilesystemName(thumb);
			}
			sql="INSERT INTO PRODUCT VALUES(PRODUCT_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, DEFAULT, DEFAULT, ?,0,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setInt(2, Integer.parseInt(multi.getParameter("category")));
			pstmt.setInt(3, Integer.parseInt(multi.getParameter("cost")));
			pstmt.setInt(4, Integer.parseInt(multi.getParameter("price")));
			pstmt.setInt(5, Integer.parseInt(multi.getParameter("sale")));
			int profit=Integer.parseInt(multi.getParameter("sale"))-Integer.parseInt(multi.getParameter("cost"));
			pstmt.setInt(6, profit);
			pstmt.setString(7, thumb);
			pstmt.setString(8, img);
			pstmt.setString(9, multi.getParameter("content"));
			pstmt.setInt(10, Integer.parseInt(multi.getParameter("stock")));
			pstmt.setString(11, multi.getParameter("type"));
			
			
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
	//상품 수정
	public boolean updateProduct(HttpServletRequest request) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			
			MultipartRequest multi=null; 
			String thumb=null;
			String img=null;
			
			multi=new MultipartRequest(request,SAVEFOLDER,MAXSIZE,ENCTYPE,new DefaultFileRenamePolicy());
			String str=multi.getParameter("pronum");
			int pronum=Integer.parseInt(str);
			ProductBean pBean=new ProductMgr().getProduct(pronum);
			
			Enumeration files=multi.getFileNames();
			
			if(files!=null) {
				img=(String)files.nextElement();
				img=multi.getFilesystemName(thumb);
				
				thumb=(String)files.nextElement();
				thumb=multi.getFilesystemName(img);
			}
			if(thumb==null || thumb.equals("")) {
				thumb=pBean.getThumb();
			}
			if(img==null || img.equals("")) {
				img=pBean.getImg();
			}
			sql="update product set proname=?, category=?,cost=?,price=?,sale=?,profit=?,thumb=?,img=?,content=?,stock=? ,type=? where pronum=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setInt(2, Integer.parseInt(multi.getParameter("category")));
			pstmt.setInt(3, Integer.parseInt(multi.getParameter("cost")));
			pstmt.setInt(4, Integer.parseInt(multi.getParameter("price")));
			pstmt.setInt(5, Integer.parseInt(multi.getParameter("sale")));
			int profit=Integer.parseInt(multi.getParameter("sale"))-Integer.parseInt(multi.getParameter("cost"));
			pstmt.setInt(6, profit);
			pstmt.setString(7, thumb);
			pstmt.setString(8, img);
			pstmt.setString(9, multi.getParameter("content"));
			pstmt.setInt(10, Integer.parseInt(multi.getParameter("stock")));
			pstmt.setString(11, multi.getParameter("type"));
			pstmt.setInt(12, pronum);
			
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
	
	//상품 번호
	public int getMultiPronum(HttpServletRequest request) {
		int pronum=0;
		
		try {
			con=pool.getConnection();
			
			MultipartRequest multi=null; 
			String thumb=null;
			String img=null;
			
			multi=new MultipartRequest(request,SAVEFOLDER,MAXSIZE,ENCTYPE,new DefaultFileRenamePolicy());
			String str=multi.getParameter("pronum");
			pronum=Integer.parseInt(str);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		
		return pronum;
	}
	
	//카테고리 추가
	public boolean categoryAdd(String catname) {
		boolean flag=false;
		try {
			con=pool.getConnection();
			sql="INSERT INTO CATEGORY VALUES(CAT_SEQ.NEXTVAL,?) ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, catname);
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
	
	//카테고리 가져오기
	public ArrayList<CategoryBean> getCategory(){
		ArrayList<CategoryBean> alist=new ArrayList<>();
		
		try {
			con=pool.getConnection();
			sql="select * from category order by catnum";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				CategoryBean cBean=new CategoryBean();
				cBean.setCatnum(rs.getInt(1));
				cBean.setCatname(rs.getString(2));
				alist.add(cBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	//카테고리 하나만 가져오기
	public String getCategoryName(int num){
		String cname="";
		
		try {
			con=pool.getConnection();
			sql="select catname from category where catnum="+num;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				cname=rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return cname;
	}
	//카테고리명 변경
	public boolean categoryUpdate(ArrayList<String[]> alist) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="update category set catname=? where catnum=?";
			int result=0;
			for(int i=0;i<alist.size();i++) {
				String update[]=alist.get(i);
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, update[1]);
				pstmt.setInt(2,Integer.parseInt(update[0]));
				if(pstmt.executeUpdate()==1) {
					result++;
				}
			}
			if(result==alist.size()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt);
		}
		return flag;
	}
	
	//카테고리 삭제
	public boolean categoryDelete(ArrayList<String[]> alist) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="delete from category where catname=? and catnum=?";
			int result=0;
			for(int i=0;i<alist.size();i++) {
				String update[]=alist.get(i);
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, update[1]);
				pstmt.setInt(2,Integer.parseInt(update[0]));
				if(pstmt.executeUpdate()==1) {
					result++;
				}
			}
			if(result==alist.size()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt);
		}
		return flag;
	}
	//상품 리스트 가져오기
	public ArrayList<ProductBean> getProductList(){
		ArrayList<ProductBean> alist = new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select * from product order by regdate desc";
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
	//상품 하나 가져오기
	public ProductBean getProduct(int num){
		ProductBean pBean=new ProductBean();
		try {
			con=pool.getConnection();
			sql="select * from product where pronum="+num;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return pBean;
	}
	//사용여부 변경
	public int updateProdUse(int[] pronum) {
		int flag=0;
		String yn="";
		int count=0;
		try {
			con=pool.getConnection();
		stop:for(int i=0;i<pronum.length;i++) {
				sql="select useyn from product where pronum="+pronum[i];
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					yn=rs.getString(1);
					if(yn.contains("N")) {
						sql="update product set USEYN=? where pronum=?";
						pstmt=con.prepareStatement(sql);
						pstmt.setString(1, "Y");
						pstmt.setInt(2, pronum[i]);
						
						if(pstmt.executeUpdate()==1) {
							count++;
						}
					}else {
						int[] mainprod=getMainProd();
						
						for(int j=0;j<8;j++) {
							for(int k=0;k<8;k++) {
								if(pronum[j]==mainprod[k]) {
									flag=-1;
									break stop;
								}
							}
						}
						sql="update product set USEYN=? where pronum=?";
						pstmt=con.prepareStatement(sql);
						pstmt.setString(1, "N");
						pstmt.setInt(2, pronum[i]);
						if(pstmt.executeUpdate()==1) {
							count++;
						}
					}
				}
			}
			if(count==pronum.length) {
				flag=1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
		return flag;
	}
	//선택 상품 삭제
	public boolean deleteProduct(int[] pronum) {
		boolean flag=false;
		String yn="";
		int count=0;
		try {
			con=pool.getConnection();
			for(int i=0;i<pronum.length;i++) {
				sql="delete from product where pronum="+pronum[i];
				pstmt=con.prepareStatement(sql);
				count+=pstmt.executeUpdate();
			}
			if(count==pronum.length) {
				flag=true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt);
		}
		return flag;
	}
	//신상 8개
	public ArrayList<ProductBean> getNew(){
		ArrayList<ProductBean> alist=new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
				sql="select rownum, PD.* from (select * from product where useyn='Y' order by regdate desc) PD where rownum<=8";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					ProductBean pBean=new ProductBean();
					pBean.setPronum(rs.getInt(2));
					pBean.setProname(rs.getString(3));
					pBean.setCategory(rs.getInt(4));
					pBean.setCost(rs.getInt(5));
					pBean.setPrice(rs.getInt(6));
					pBean.setSale(rs.getInt(7));
					pBean.setProfit(rs.getInt(8));
					pBean.setThumb(rs.getString(9));
					pBean.setImg(rs.getString(10));
					pBean.setContent(rs.getString(11));
					pBean.setUseyn(rs.getString(12));
					pBean.setRegdate(rs.getString(13));
					pBean.setStock(rs.getInt(14));
					pBean.setSaleqtt(rs.getInt(15));
					pBean.setType(rs.getString(16));
					alist.add(pBean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con,pstmt,rs);
			}
		return alist;
	}
	//hot 8개
	public ArrayList<ProductBean> getPopular(){
		ArrayList<ProductBean> alist=new ArrayList<ProductBean>();
		
		try {
			con=pool.getConnection();
			sql="select rownum, PD.* from (select * from product where useyn='Y' order by SALEQTT desc, regdate desc) PD where rownum<=8";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductBean pBean=new ProductBean();
				pBean.setPronum(rs.getInt(2));
				pBean.setProname(rs.getString(3));
				pBean.setCategory(rs.getInt(4));
				pBean.setCost(rs.getInt(5));
				pBean.setPrice(rs.getInt(6));
				pBean.setSale(rs.getInt(7));
				pBean.setProfit(rs.getInt(8));
				pBean.setThumb(rs.getString(9));
				pBean.setImg(rs.getString(10));
				pBean.setContent(rs.getString(11));
				pBean.setUseyn(rs.getString(12));
				pBean.setRegdate(rs.getString(13));
				pBean.setStock(rs.getInt(14));
				pBean.setSaleqtt(rs.getInt(15));
				pBean.setType(rs.getString(16));
				alist.add(pBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return alist;
	}
	//지금 메인에 떠있는 상품 8개
	public int[] getMainProd() {
		int mainProd[]=new int[8];
		try {
			con=pool.getConnection();
			for(int i=0;i<8;i++) {
				int j=i+1;
				sql="select * from mainprod where viewnum="+j;
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					mainProd[i]=rs.getInt(2);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return mainProd;
	}
	//메인에 띄울 상품 8개 넣기
	public int updateMainProd(int pronum[]) {
		int flag=0;
		int count=0;
		TreeSet<Integer> ts=new TreeSet<>();
		for(int i=0;i<8;i++) {
			ts.add(pronum[i]);
		}
		if(pronum.length!=ts.size()) {
			return 5;
		}else {
			try {
				con=pool.getConnection();
				for(int i=0;i<pronum.length;i++) {
					sql="update mainprod set pronum=? where viewnum=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, pronum[i]);
					pstmt.setInt(2, i+1);
					count+=pstmt.executeUpdate();
				}
				if(count==pronum.length) {
					flag=1;
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con,pstmt);
			}
			return flag;
		}
	}
}
