package boards;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import db.DBConnectionMgr;

public class BoardMgr {
	private DBConnectionMgr pool;
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql=null;
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//큐엔에이 넣기
	public boolean insertQnA(QnaBean qBean) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="insert into QNA values(QNA_SEQ.NEXTVAL,?,?,?,?,QNA_SEQ.CURRVAL,default,default)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, qBean.getId());
			pstmt.setString(2, qBean.getTitle());
			pstmt.setString(3, qBean.getContent());
			pstmt.setInt(4, qBean.getCategory());
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
		
	}
	//답변 넣기
	public boolean insertQnAAnswer(QnaBean qBean, int qnanum) {
		boolean flag=false;
		
		try {
			con=pool.getConnection();
			sql="insert into QNA values(QNA_SEQ.NEXTVAL,?,?,?,?,?,1,default)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, qBean.getId());
			pstmt.setString(2, qBean.getTitle());
			pstmt.setString(3, qBean.getContent());
			pstmt.setInt(4, qBean.getCategory());
			pstmt.setInt(5, qnanum);
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
		
	}
	//id 로 걸러서 큐엔에이 가져오기
	public ArrayList<QnaBean> getQnaById(String id,int start, int end){
		ArrayList<QnaBean> alist=new ArrayList<QnaBean>();
		try {
			con=pool.getConnection();
			sql="SELECT ROWNUM, QT1.* FROM(SELECT * FROM QNA ORDER BY REF DESC, depth desc)QT1 WHERE ? <= ROWNUM AND ROWNUM <=? and id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			pstmt.setString(3, id);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QnaBean qBean=new QnaBean();
				
				qBean.setQnanum(rs.getInt(2));
				qBean.setId(rs.getString(3));
				qBean.setTitle(rs.getString(4));
				qBean.setContent(rs.getString(5));
				qBean.setCategory(rs.getInt(6));
				qBean.setRef(rs.getInt(7));
				qBean.setDepth(rs.getInt(8));
				qBean.setRegdate(rs.getString(9));
				alist.add(qBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return alist;
	}
	//qna하나 가져오기
	public QnaBean getQna(int qnanum){
		QnaBean qBean=new QnaBean();
		try {
			con=pool.getConnection();
			sql="SELECT * from qna where qnanum= '"+qnanum+"'";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				qBean.setQnanum(rs.getInt(1));
				qBean.setId(rs.getString(2));
				qBean.setTitle(rs.getString(3));
				qBean.setContent(rs.getString(4));
				qBean.setCategory(rs.getInt(5));
				qBean.setRef(rs.getInt(6));
				qBean.setDepth(rs.getInt(7));
				qBean.setRegdate(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return qBean;
	}

	
	//큐엔에이 다 가져오기
	public ArrayList<QnaBean> getQna(int start, int end){
		ArrayList<QnaBean> alist=new ArrayList<QnaBean>();
		try {
			con=pool.getConnection();
			sql="SELECT ROWNUM, QT1.* FROM(SELECT * FROM QNA ORDER BY REF DESC, depth desc)QT1 WHERE ?<=ROWNUM AND ROWNUM<=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QnaBean qBean=new QnaBean();
				qBean.setQnanum(rs.getInt(2));
				qBean.setId(rs.getString(3));
				qBean.setTitle(rs.getString(4));
				qBean.setContent(rs.getString(5));
				qBean.setCategory(rs.getInt(6));
				qBean.setRef(rs.getInt(7));
				qBean.setDepth(rs.getInt(8));
				qBean.setRegdate(rs.getString(9));
				alist.add(qBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return alist;
	}
	//큐엔에이 중복거르기
	public ArrayList<QnaBean> getQnaDblChk(int qnanum){
		ArrayList<QnaBean> alist=new ArrayList<QnaBean>();
		try {
			con=pool.getConnection();
			sql="select * from qna where ref="+qnanum;
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				QnaBean qBean=new QnaBean();
				qBean.setQnanum(rs.getInt(1));
				qBean.setId(rs.getString(2));
				qBean.setTitle(rs.getString(3));
				qBean.setContent(rs.getString(4));
				qBean.setCategory(rs.getInt(5));
				qBean.setRef(rs.getInt(6));
				qBean.setDepth(rs.getInt(7));
				qBean.setRegdate(rs.getString(8));
				alist.add(qBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return alist;
	}

}
