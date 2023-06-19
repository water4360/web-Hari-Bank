//package controller;
//
//import java.util.HashMap;
//
//public class KakaoLoginController {
//	/**
//	 * 카카오 로그인 API
//	 * [GET] /app/login/kakao
//	 * @return BaseResponse<String>
//	 */
//	@ResponseBody
//	@GetMapping("/kakao")
//	public BaseResponse<PostLoginRes> kakaoLogin(@RequestParam(required = false) String code) {
//	    try {
//	        // URL에 포함된 code를 이용하여 액세스 토큰 발급
//	        String accessToken = loginService.getKakaoAccessToken(code);
//	        System.out.println(accessToken);
//
//	        // 액세스 토큰을 이용하여 카카오 서버에서 유저 정보(닉네임, 이메일) 받아오기
//	        HashMap<String, Object> userInfo = loginService.getUserInfo(accessToken);
//	        System.out.println("login Controller : " + userInfo);
//
//	        PostLoginRes postLoginRes = null;
//
//	        // 만일, DB에 해당 email을 가지는 유저가 없으면 회원가입 시키고 유저 식별자와 JWT 반환
//	        // 현재 카카오 유저의 전화번호를 받아올 권한이 없어서 테스트를 하지 못함.
//	        if(loginProvider.checkEmail(String.valueOf(userInfo.get("email"))) == 0) {
//	            //PostLoginRes postLoginRes = 해당 서비스;
//	            return new BaseResponse<>(postLoginRes);
//	        } else {
//	            // 아니면 기존 유저의 로그인으로 판단하고 유저 식별자와 JWT 반환
//	            postLoginRes = loginProvider.getUserInfo(String.valueOf(userInfo.get("email")));
//	            return new BaseResponse<>(postLoginRes);
//	        }
//	    } catch (BaseException exception) {
//	        return new BaseResponse<>((exception.getStatus()));
//	    }
//	}
//}
