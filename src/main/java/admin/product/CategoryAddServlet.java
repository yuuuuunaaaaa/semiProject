package admin.product;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/product/categoryadd.post")
public class CategoryAddServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String catname=request.getParameter("catname");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		boolean result=new ProductMgr().categoryAdd(catname);
		
		if(result) {
			writer.println("<script>alert('카테고리가 추가되었습니다.'); location.href='categoryMng.jsp'; </script>"); 
			writer.close();
		}else {
			writer.println("<script>alert('카테고리 추가 실패ㅠ'); location.href='categoryMng.jsp'; </script>"); 
			writer.close();
		}
		
	}

}
