import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:project_indian/services/firebase_service.dart';
import 'package:project_indian/vo/user_vo.dart';

class KakoLoginService {
  final String apiKey;

  KakoLoginService(this.apiKey);

  FirebaseService firebaseService = FirebaseService();
  User? user;

  Future<void> kakaoLogin() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  Future<void> getUser() async {
    try {
      user = await UserApi.instance.me();
      setUserData();
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      return;
    }

    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n이름: ${user.kakaoAccount?.name}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n프로필 사진: ${user.kakaoAccount?.profile?.profileImageUrl}'
          '\n이메일: ${user.kakaoAccount?.email}'
          '\n핸드폰 번호: ${user.kakaoAccount?.phoneNumber}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }

    // List<String> scopes = [];
    //
    // if (user?.kakaoAccount?.emailNeedsAgreement == true) {
    //   scopes.add('account_email');
    // }
    // if (user?.kakaoAccount?.birthdayNeedsAgreement == true) {
    //   scopes.add("birthday");
    // }
    // if (user?.kakaoAccount?.birthyearNeedsAgreement == true) {
    //   scopes.add("birthyear");
    // }
    // if (user?.kakaoAccount?.ciNeedsAgreement == true) {
    //   scopes.add("account_ci");
    // }
    // if (user?.kakaoAccount?.phoneNumberNeedsAgreement == true) {
    //   scopes.add("phone_number");
    // }
    // if (user?.kakaoAccount?.profileNeedsAgreement == true) {
    //   scopes.add("profile");
    // }
    // if (user?.kakaoAccount?.ageRangeNeedsAgreement == true) {
    //   scopes.add("age_range");
    // }

    // if (scopes.length > 0) {
    //   print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');
    //
    //   // OpenID Connect 사용 시
    //   // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
    //   // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
    //   // scopes.add("openid")
    //
    //   // scope 목록을 전달하여 추가 항목 동의 받기 요청
    //   // 지정된 동의항목에 대한 동의 화면을 거쳐 다시 카카오 로그인 수행
    //   OAuthToken token;
    //
    //   try {
    //     token = await UserApi.instance.loginWithNewScopes(scopes);
    //     print('현재 사용자가 동의한 동의항목: ${token.scopes}');
    //   } catch (error) {
    //     print('추가 동의 요청 실패 $error');
    //     return;
    //   }
    //
    //   // 사용자 정보 재요청
    //   try {
    //     User user = await UserApi.instance.me();
    //     print('현재 사용자가 동의한 동의항목: ${token.scopes}');
    //     print('사용자 정보 요청 성공'
    //         '\n회원번호: ${user.id}'
    //         '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
    //         '\n이메일: ${user.kakaoAccount?.email}');
    //   } catch (error) {
    //     print('사용자 정보 요청 실패 $error');
    //   }
    // }
  }

  Future<void> setUserData() async {
    firebaseService.setUserDB(UserVo(
        uid: "${user?.id ?? 0}",
        email: user?.kakaoAccount?.email ?? "없음",
        nick_name: user?.kakaoAccount?.profile?.nickname ?? "없음"
    ));
  }

  Future<void> kakoLogout() async {
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
  }

// Future<void> tokenManager() async {
//   var manager = TokenManagerProvider.instance;
//   print(await manager.manager.getToken());
// }

}
