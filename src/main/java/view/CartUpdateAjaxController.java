package view;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.order.CartBean;
import admin.order.OrderMgr;
import admin.product.ProductMgr;

@WebServlet("/deleteFromCart")
public class CartUpdateAjaxController extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int pronum=Integer.parseInt(request.getParameter("pronum")); 
		int cartnum=Integer.parseInt(request.getParameter("cartnum")); 
		int totalprice=Integer.parseInt(request.getParameter("totalprice")); 
		int qtt=0;
		ArrayList<CartBean> alist=new OrderMgr().getCartList(cartnum);
		
		for(int i=0;i<alist.size();i++) {
			if(alist.get(i).getPronum()==pronum) {
				qtt=alist.get(i).getQuantity();
			}
		}
		
		boolean result=new ProductViewMgr().updateCartYN(cartnum, pronum);
		if(result) {
			totalprice=totalprice-new ProductMgr().getProduct(pronum).getSale()*qtt;
		}else {
			totalprice=-1;
		}
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(totalprice);
	}

}
