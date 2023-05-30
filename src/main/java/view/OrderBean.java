package view;

public class OrderBean {
	private int ordernum;
	private String id;
	private String indate;
	private int proccess;
	private String postnum; //송장번호
	private String finaldate;
	private String name;
	private String zipcode;
	private String address;
	private String addrdetail;
	private String phone;
	private int point;
	private int finalPrice;
	private int review;
	
	private int pronum;
	private int quantity;
	
	public int getOrdernum() {
		return ordernum;
	}
	public void setOrdernum(int ordernum) {
		this.ordernum = ordernum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	public int getProccess() {
		return proccess;
	}
	public void setProccess(int proccess) {
		this.proccess = proccess;
	}
	public String getPostnum() {
		return postnum;
	}
	public void setPostnum(String postnum) {
		this.postnum = postnum;
	}
	public String getFinaldate() {
		return finaldate;
	}
	public void setFinaldate(String finaldate) {
		this.finaldate = finaldate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddrdetail() {
		return addrdetail;
	}
	public void setAddrdetail(String addrdetail) {
		this.addrdetail = addrdetail;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
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
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getFinalPrice() {
		return finalPrice;
	}
	public void setFinalPrice(int finalPrice) {
		this.finalPrice = finalPrice;
	}
	public int getReview() {
		return review;
	}
	public void setReview(int review) {
		this.review = review;
	}
	@Override
	public String toString() {
		return "OrderBean [ordernum=" + ordernum + ", id=" + id + ", indate=" + indate + ", proccess=" + proccess
				+ ", postnum=" + postnum + ", finaldate=" + finaldate + ", name=" + name + ", zipcode=" + zipcode
				+ ", address=" + address + ", addrdetail=" + addrdetail + ", phone=" + phone + ", point=" + point
				+ ", finalPrice=" + finalPrice + ", pronum=" + pronum + ", quantity=" + quantity + "]";
	}
	
	
	
	
	
	
}
