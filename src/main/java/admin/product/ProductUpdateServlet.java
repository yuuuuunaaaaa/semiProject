package admin.product;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin/ProductUpdate.post")
public class ProductUpdateServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
		HttpServletRequest request=req;
		
		request.setCharacterEncoding("UTF-8");
		
		boolean result=false; 
		result=new ProductMgr().updateProduct(request);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		if(result) {
			writer.println("<script>alert('상품 수정 성공! 관리페이지를 새로고침 해주세요'); window.close() </script>"); writer.close(); 
		}else {
			writer.println("<script>alert('상품 수정 실패'); window.close();</script>");
			writer.close();
		}
		 
		
	}

}
