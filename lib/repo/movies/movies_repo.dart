import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:cine_plex/model/movies.dart';
import 'package:cine_plex/utils/api.dart';
import 'package:cine_plex/utils/date_time_helper.dart';
import 'package:cine_plex/utils/http_request.dart';
import 'package:cine_plex/utils/storage_helper.dart';

class MoviesRepo {
  static Future<void> getCurrentMovies(
      {required int vendorId,
      required Function(List<Movie> nowShowing, List<Movie> commingSoon)
          onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token.toString()
      };

      var body = {"vendor_id": vendorId};

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.showingMoviesUrl),
          headers: headers,
          body: json.encode(body));

      log("${Api.showingMoviesUrl} ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['success']) {
        List<Movie> nowShowing = <Movie>[];
        List<Movie> commingSoon = <Movie>[];

        if (data['data']['nowShowing'] != null) {
          nowShowing.addAll(moviesFromJson(data['data']['nowShowing']));
        }

        if (data['data']['comingSoon'] != null) {
          commingSoon.addAll(moviesFromJson(data['data']['comingSoon']));
        }

        onSuccess(nowShowing, commingSoon);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> getMovieDetails(
      {required int movieId,
      required Function(Movie movie, Map<String, List<Show>> shows) onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token.toString()
      };

      var url = "${Api.getMovieDetails}/$movieId";

      http.Response response = await HttpRequest.get(
        Uri.parse(url),
        headers: headers,
      );

      log("$url ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['success']) {
        var movie = Movie.fromJson(data['data']['movie']);

        var todayShows = showsFromJson(
            data['data'][DateTimeHelper.dateFormat(DateTime.now())]);
        var tomorrowShows = showsFromJson(data['data'][
            DateTimeHelper.dateFormat(
                DateTime.now().add(const Duration(days: 1)))]);
        var shows = {
          DateTimeHelper.dateFormat(DateTime.now()): todayShows,
          DateTimeHelper.dateFormat(
              DateTime.now().add(const Duration(days: 1))): tomorrowShows
        };
        onSuccess(movie, shows);
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
