package view;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.StringTokenizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import admin.product.ProductBean;

@WebServlet("/SearchKeyWord.me")
public class SearchProducts extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search=request.getParameter("keyWord");
		
		StringTokenizer st=new StringTokenizer(search, " ");
			
		
		LinkedHashSet<ProductBean> alist=new LinkedHashSet();
		ProductBean pBean=new ProductBean();
		
		while(st.hasMoreElements()) {
			String keyword=st.nextToken();
			
			ArrayList<ProductBean> alisttemp=new ArrayList();
			
			alisttemp=new ProductViewMgr().getProductYListByKeyword(keyword);
			if(!alisttemp.isEmpty()) {
				for(int i=0;i<alisttemp.size();i++) {
					alist.add(alisttemp.get(i));
				}
			}
		}
		int len=0;
		if(alist.isEmpty()) {
			response.setContentType("application/json; charset=UTF-8");
			response.getWriter().print(-1);
		}else {
			len=alist.size();
			int arr[]=new int[len];
			Iterator fu=alist.iterator();
			int i=0;
			while(fu.hasNext()) {
				pBean=(ProductBean) fu.next();
				arr[i]=pBean.getPronum();
				i++;
			}
			response.setContentType("application/json; charset=UTF-8");
			new Gson().toJson(arr, response.getWriter());
		}
		
	}

}
