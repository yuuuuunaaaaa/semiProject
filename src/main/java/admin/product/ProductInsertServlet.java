package admin.product;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/product/ProductInsert.post")
public class ProductInsertServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		ProductMgr pMgr=new ProductMgr();
		boolean result=false;
		result=pMgr.InsertProduct(request);
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter writer = response.getWriter();
		
		if(result) {
			writer.println("<script>alert('상품 등록 성공! 관리자 페이지를 새로고침해 확인하세요'); window.close(); </script>"); 
			writer.close();
		}else {
			writer.println("<script>alert('상품 등록 실패ㅠ'); window.close();</script>"); 
			writer.close();
		}
		
	}

}
