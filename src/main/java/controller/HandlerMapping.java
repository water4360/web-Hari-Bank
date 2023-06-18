package controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

public class HandlerMapping {
	private Map<String, Controller> mappings;

	public HandlerMapping(String propLoc) {
		mappings = new HashMap<>();
		// property를 불러오는 내장...객체?
		Properties prop = new Properties();

		try {
			// prop.load로 파일을 불러와야 하는데 () 안의 타입은 InputStream이니까 이거 절대경로로 가져와주고,
//			InputStream is = new FileInputStream("C:\\Users\\User\\eclipse-workspace-JSP\\JYBanking\\bean.properties");

			// 이젠 web.xml만 고치면 됨ㅋㅋ
			InputStream is = new FileInputStream(propLoc);
			// try~catch로 감싸줌.
			prop.load(is);

			// properties의 한 쌍에서 name만 뽑아올 수 있음!
			// 그렇다면 value를 뽑아내는건? getProperty()라는 메소드를 씀.
			// Object가 String이라는 보장이 없기 때문에 (String)으로 명시적 형변환하는 것은 옳은 방법은 아님!
			Set<Object> keys = prop.keySet();
			for (Object key : keys) {
				System.out.println("key : " + key);
				String className = prop.getProperty(key.toString());
				System.out.println(key + " : " + className);

				// reflection : 프로그램을 실행하는 와중에 객체를 관리하려고 하는 것. 메소드 호출이라던가 유동적으로 바뀌도록...
				// 동적으로 객체 생성, 메소드 호출, 정보 알아오게 하는 그런 모든 것들을 리플렉션이라고 합니다.
				// 스프링은 모두 리플렉션 방식임.
				// 커넥션팩토리에서 classForName 어쩌고 있었는데 그게 리플렉션임.

				Class<?> clz = Class.forName(className);
				Constructor<?> constructor = clz.getConstructor();
				// object타입이니까 Controller로 명시적 형변환해주기!
				Controller ctrl = (Controller) constructor.newInstance();

				mappings.put(key.toString(), ctrl);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		// 근데 이 uri를 여따가 다 써?? 100개면 다 써??
		// 파일 하나에 몰아주자!
		// .properties 라는 파일을 만들어
		// 항상 name = value 이렇게 쌍의 형태로 저장을 할 것임.
		// /login.do=LoginController
		// /member/mypage = MyPageController 이런식으로 저장이 되겠지.
		// 근데 동명의 LoginController가 있을수 있기 때문에 패키지를 포함한 이름을 써야함.
		// 단 쌍의 중간에 스페이스 안됨!! 엔터로 공간을 줘서도 안됨!!!

//		mappings.put("/login.do", new LoginController);
//		mappings.put("/member/mypage.do", new MyPageController);
	}

	public Controller getController(String uri) {

		// key만 꺼내는 게 get메소드!ㅋㅋㅋ
		// uri로 login.do가 들어오면, 걔의 밸류인 LoginController를 뽑!
		return mappings.get(uri);

	}

	/*
	 * public static void main(String[] args) throws Exception{ // java.util.Random
	 * r = new java.util.Random(); // System.out.println(r.nextInt());
	 * 
	 * //클래스 내용을 가져와서 Class<?> clz = Class.forName("java.util.Random");
	 * 
	 * //생성자를 만들고 나서 // Object obj = clz.newInstance(); 얘는 이제 deprecated 된 애...
	 * Constructor<?> constructor = clz.getConstructor();
	 * 
	 * //인스턴스 객체를 만들 수 있음. Object obj = constructor.newInstance();
	 * System.out.println("난수 : " + ((java.util.Random)obj).nextInt()); }
	 * 
	 */
}
