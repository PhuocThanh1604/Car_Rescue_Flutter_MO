import 'package:google_sign_in/google_sign_in.dart';

class Environment {

  static const String API_URL_PLACES_NEW  = "https://places.googleapis.com/v1/places:searchText";

  static const String API_KEY_MAPS  = "AIzaSyB2fhukchi90Nc1P1i-9s2kJRjlEpw4r0k";

  static const String API_KEY_PREDICTIONS = "AIzaSyBZmPE0cCErk-nZtza3mDsXwIKLhS2s8Jg";

  static  GoogleSignIn SIGN_IN = GoogleSignIn(
    scopes: <String>[
      'email',
      // 'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
  
  static const String API_LOGIN_GMAIL = "https://rescuecapstoneapi.azurewebsites.net/api/Login/LoginWithGoogle";

  static const String API_CREATE_ORDER_CUSTOMER = "https://rescuecapstoneapi.azurewebsites.net/api/Order/CreateOrderForCustomer";

  static const String API_GETALL_SERVICE_CUSTOMER = "https://rescuecapstoneapi.azurewebsites.net/api/Service/GetAll";
}