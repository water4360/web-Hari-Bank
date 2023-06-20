package user;

public class UserVO {
	private String id;
	private String pw;
	private String korName;
	private String birthdate;
	private String gender;
	private String telecom;
	private String phone;
	private String email;
	private String signupType;
	private String regDate;
	private String role;
	private String roleName;
	private String addressType;
	private String postcode;
	private String roadAddress;
	private String detailAddress;
	
	
	
	//전체 생성자
	public UserVO(String id, String pw, String korName, String birthdate, String gender, String telecom, String phone,
			String email, String signupType, String regDate) {
		super();
		this.id = id;
		this.pw = pw;
		this.korName = korName;
		this.birthdate = birthdate;
		this.gender = gender;
		this.telecom = telecom;
		this.phone = phone;
		this.email = email;
		this.signupType = signupType;
		this.regDate = regDate;
		this.role = role;
		this.roleName = roleName;
		this.addressType = addressType;
		this.postcode = postcode;
		this.roadAddress = roadAddress;
		this.detailAddress = detailAddress;
	}

	public UserVO() {
		super();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getKorName() {
		return korName;
	}

	public void setKorName(String korName) {
		this.korName = korName;
	}

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getTelecom() {
		return telecom;
	}

	public void setTelecom(String telecom) {
		this.telecom = telecom;
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

	public String getSignupType() {
		return signupType;
	}

	public void setSignupType(String signupType) {
		this.signupType = signupType;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getAddressType() {
		return addressType;
	}

	public void setAddressType(String addressType) {
		this.addressType = addressType;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getRoadAddress() {
		return roadAddress;
	}

	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	
	
}

