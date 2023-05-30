package admin.product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.TreeSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/admin/product/getWhat.prod")
public class GetWhat extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String str[]=request.getParameterValues("mainView");
		int pronum[]=new int[8];
		for(int i=0;i<8;i++) {
			pronum[i]=Integer.parseInt(str[i]);
		}
		PrintWriter out=response.getWriter();
		int result=new ProductMgr().updateMainProd(pronum);
		if(result>0) {
			if(result==1) {
				out.print("<script>");
				out.print("alert('설정을 완료했습니다.');");
				out.print("location.href='mainProductMng.jsp'");
				out.print("</script>");
			}else {
				out.print("<script>");
				out.print("alert('중복 설정된 상품이 있습니다.');");
				out.print("history.back();");
				out.print("</script>");
			}
		}else {
			out.print("<script>");
			out.print("alert('설정에 실패했습니다.');");
			out.print("history.back();");
			out.print("</script>");
		}
	}
}
