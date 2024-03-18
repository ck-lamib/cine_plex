import 'dart:convert';
import 'dart:developer';

import 'package:cine_plex/utils/api.dart';
import 'package:cine_plex/utils/http_request.dart';

import 'package:http/http.dart' as http;

class ForgetPasswordRepo {
  static Future<void> forgetPassword({
    required String email,
    required Function(String customerId) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };

      var body = {
        "email": email.toLowerCase(),
      };

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.forgotPasswordUrl),
          headers: headers,
          body: body);

      log("${Api.forgotPasswordUrl} ===================>");
      log(json.encode(body));
      log(response.body);

      dynamic data = jsonDecode(response.body);
      if (data["success"]) {
        var customerId = data['data']['customer'];

        onSuccess(customerId.toString());
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }

  static Future<void> resetPassword({
    required String otp,
    required String password,
    required String customerId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
        // "Content-Type": "application/json",
      };

      var body = {
        "customer_id": customerId,
        "otp": otp,
        "new_password": password,
      };

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.resetPasswordUrl),
          headers: headers,
          body: body);

      log("${Api.resetPasswordUrl} ===================>");
      log(json.encode(body));
      log(response.body);

      dynamic data = jsonDecode(response.body);
      if (data["success"]) {
        onSuccess(data['message']);
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
