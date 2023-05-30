package personal;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import admin.order.CartBean;
import admin.order.OrderMgr;
import member.PMemberMgr;

@WebServlet("/cartSearch")
public class CartAjaxControllar extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id=request.getParameter("id");
		int qtt=Integer.parseInt(request.getParameter("qtt"));
		int pronum=Integer.parseInt(request.getParameter("pronum"));
		CartBean cBean=new CartBean();
		cBean.setQuantity(qtt);
		cBean.setPronum(pronum);
		cBean.setId(id);
		cBean.setCartnum(new PMemberMgr().getMember(id).getCartnum());
		

		boolean result=new OrderMgr().cartDoubleChk(cBean);
		response.setContentType("application/json; charset=utf-8");
		new Gson().toJson(result, response.getWriter());
	
	}

}
