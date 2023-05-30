package admin.order;

public class CartBean {
	private int cartnum;
	private String id;
	private int pronum;
	private int quantity;
	private String indate;
	private String purchase; //Y or N
	public int getCartnum() {
		return cartnum;
	}
	public void setCartnum(int cartnum) {
		this.cartnum = cartnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPronum() {
		return pronum;
	}
	public void setPronum(int pronum) {
		this.pronum = pronum;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	public String getPurchase() {
		return purchase;
	}
	public void setPurchase(String purchase) {
		this.purchase = purchase;
	}
	
	
	 
}
