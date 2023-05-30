package member;

public class PMemberBean {
	private String id;
	private String pwd;
	private String name;
	private String phone;
	private String email;
	private String zipcode;
	private String address;
	private String addrdetail;
	private String regdate;
	private String enddate;
	private int useyn;
	private int point;
	private int cartnum;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getUseyn() {
		return useyn;
	}
	public void setUseyn(int useyn) {
		this.useyn = useyn;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public int getCartnum() {
		return cartnum;
	}
	public void setCartnum(int cartnum) {
		this.cartnum = cartnum;
	}
	@Override
	public String toString() {
		return "PMemberBean [id=" + id + ", pwd=" + pwd + ", name=" + name + ", phone=" + phone + ", email=" + email
				+ ", zipcode=" + zipcode + ", address=" + address + ", addrdetail=" + addrdetail + ", regdate="
				+ regdate + ", enddate=" + enddate + ", useyn=" + useyn + ", point=" + point + "]";
	}
	

	
}
