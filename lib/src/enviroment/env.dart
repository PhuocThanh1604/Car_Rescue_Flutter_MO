<<<<<<< HEAD
class Environment {

  static const String API_URL_PLACES_NEW  = "https://places.googleapis.com/v1/places:searchText";

  static const String API_KEY_MAPS  = "AIzaSyB2fhukchi90Nc1P1i-9s2kJRjlEpw4r0k";

}
=======
import 'package:google_sign_in/google_sign_in.dart';

class Environment {
  static const String API_URL_PLACES_NEW =
      "https://places.googleapis.com/v1/places:searchText";

  static const String API_KEY_MAPS = "AIzaSyDtQ6f3BA48dZxUbT6NhN94Byw1wfFJBKM";

  static const String API_KEY_PREDICTIONS =
      "AIzaSyBZmPE0cCErk-nZtza3mDsXwIKLhS2s8Jg";

  static GoogleSignIn SIGN_IN = GoogleSignIn(
    scopes: <String>[
      'email',
      // 'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  static const String API_URL = "https://rescuecapstoneapi.azurewebsites.net/";
}
>>>>>>> origin/MinhAndHieu6
