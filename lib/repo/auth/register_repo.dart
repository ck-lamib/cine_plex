import 'dart:convert';
import 'dart:developer';

import 'package:cine_plex/utils/api.dart';

import '../../model/access_token.dart';
import '../../model/user.dart';

import 'package:http/http.dart' as http;

import '../../utils/http_request.dart';

class RegisterRepo {
  static Future<void> register({
    required String email,
    required String password,
    required String name,
    required Function(User user, AccessToken token) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      var body = {
        "name": name,
        "email": email,
        "password": password,
      };

      http.Response response = await HttpRequest.post(Uri.parse(Api.signupUrl),
          headers: headers, body: body);

      log("${Api.signupUrl} ===================>");
      log(json.encode(body));
      log(response.body);

      dynamic data = jsonDecode(response.body);
      if (data["success"]) {
        AccessToken token = AccessToken.fromJson(data["data"]["token"]);
        User user = User.fromJson(data["data"]["customer"]);
        onSuccess(user, token);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }
}
