import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:cine_plex/model/user.dart';
import 'package:cine_plex/utils/api.dart';
import 'package:cine_plex/utils/storage_helper.dart';

import 'package:cine_plex/utils/http_request.dart';

class UpdateProfileRepo {
  static Future<void> updateProfile(
      {required String name,
      required String phone,
      String? image,
      required Function(User user, String message) onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      var body = {
        "name": name,
        "phone": phone,
      };

      if (image != null) body['profile_image'] = image;

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.updateProfileUrl),
          headers: headers,
          body: body);

      log("${Api.updateProfileUrl} ==============>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data["success"] as bool) {
        User user = User.fromJson(data["data"]);
        onSuccess(user, data['message']);
      } else {
        onError(data['message']);
      }
    } catch (e) {
      log(e.toString());
      onError("Sorry! Something went wrong");
    }
  }
}
