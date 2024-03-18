import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:cine_plex/model/halls.dart';
import 'package:cine_plex/utils/api.dart';
import 'package:cine_plex/utils/http_request.dart';
import 'package:cine_plex/utils/storage_helper.dart';

class CinemaHallRepo {
  static Future<void> getCinemaHalls(
      {required Function(List<CinemaHalls> halls) onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Authorization": token.toString()
      };

      http.Response response = await HttpRequest.get(
        Uri.parse(Api.cinemaHallUrl),
        headers: headers,
      );

      log("${Api.cinemaHallUrl} ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['success']) {
        List<CinemaHalls> halls = cinemaHallsFromJson(data['data']);
        onSuccess(halls);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }
}
