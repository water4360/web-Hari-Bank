package common;

public class DAOServiceFactory {

	private static DAOService service = null;
	
	public static DAOService getInstance() {
		
		if(service == null) {
			service = new DAOService();
		}
		
		return service;
	}
}
