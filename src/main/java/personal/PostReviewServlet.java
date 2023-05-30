package personal;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PostReviewServlet
 */
@WebServlet("/PostReview.post")
public class PostReviewServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		boolean result=new PersonalMgr().InsertReview(request);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter writer = response.getWriter();
		
		if(result) {
			int reviewnum=new PersonalMgr().reviewnum;
			writer.println("<script>location.href='personal/ViewReview.jsp?reviewnum="+reviewnum+"' </script>"); 
			writer.close();
		}else {
			writer.println("<script>alert('리뷰 등록 실패ㅠ'); history.back();</script>"); 
			writer.close();
		}
		
		
	}

}
