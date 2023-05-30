package admin.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.PMemberBean;

@WebServlet("/MemberUpdate.post")
public class MemberUpdate extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PMemberBean mBean=new PMemberBean();
		String orginId=request.getParameter("orginId");
		mBean.setId(request.getParameter("id"));
		mBean.setPwd(request.getParameter("pwd"));
		mBean.setName(request.getParameter("name"));
		mBean.setPhone(request.getParameter("phone"));
		mBean.setZipcode(request.getParameter("zipcode"));
		mBean.setAddress(request.getParameter("addr"));
		mBean.setAddrdetail(request.getParameter("addrdetail"));
		mBean.setUseyn(Integer.parseInt(request.getParameter("useyn")));
		
		boolean result=false; 
		result=new AdminMemberMgr().updateMember(mBean,orginId);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		if(result) {
			writer.println("<script>alert('회원정보 수정 성공! 관리페이지를 새로고침 해주세요'); window.close() </script>"); writer.close(); 
		}else {
			writer.println("<script>alert('회원정보 수정 실패'); window.close();</script>");
			writer.close();
		}
		
		
	}
}
