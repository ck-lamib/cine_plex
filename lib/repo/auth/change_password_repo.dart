import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:cine_plex/utils/api.dart';
import 'package:cine_plex/utils/http_request.dart';
import 'package:cine_plex/utils/storage_helper.dart';

class ChangePasswordRepo {
  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      var body = {
        "old_password": oldPassword,
        "new_password": newPassword,
      };

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.changePasswordUrl),
          headers: headers,
          body: body);

      log("${Api.changePasswordUrl} ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['success']) {
        onSuccess(data['message']);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }
}
