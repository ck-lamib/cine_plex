import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cine_plex/model/booking.dart';
import 'package:cine_plex/model/seats.dart';
import 'package:cine_plex/utils/api.dart';
import 'package:cine_plex/utils/http_request.dart';
import 'package:cine_plex/utils/storage_helper.dart';

class BookingRepo extends GetxController {
  static Future<void> bookSeats(
      {required String type,
      required int vendorId,
      required int theaterId,
      required int movieId,
      required int showTimeId,
      required String showDate,
      required String showTime,
      required int showPrice,
      required List<int> seats,
      required Function(Booking booking, List<Seat> seats, String type)
          onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token.toString()
      };

      var url = Api.booking;

      var body = {
        "type": type,
        "vendor_id": vendorId,
        "theater_id": theaterId,
        "movie_id": movieId,
        "show_time_id": showTimeId,
        "show_date": showDate,
        "show_time": showTime,
        "show_price": showPrice,
        "seats": seats
      };

      http.Response response = await HttpRequest.post(Uri.parse(url),
          headers: headers, body: json.encode(body));

      log("$url ===========>");
      log(json.encode(body));
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['success']) {
        var booking = Booking.fromJson(data['data']['booking']);
        var bookedSeats = seatsFromJson(data['data']['seats']);
        var type = data['data']['type'];
        onSuccess(booking, bookedSeats, type);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> cancelBooking(
      {required int bookingId,
      required Function(String message) onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token.toString()
      };

      var url = "${Api.cancelBooking}/$bookingId";

      http.Response response = await HttpRequest.get(
        Uri.parse(url),
        headers: headers,
      );

      log("$url ===========>");
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
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> getBookings(
      {required Function(List<Booking> bookings) onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token.toString()
      };

      var url = Api.getBooking;

      http.Response response = await HttpRequest.get(
        Uri.parse(url),
        headers: headers,
      );

      log("$url ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['success']) {
        var bookings = bookingsFromJson(data['data']);

        onSuccess(bookings);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> getBookingDetails(
      {required int bookingId,
      required Function(Booking booking, List<Seat> seats) onSuccess,
      required Function(String message) onError}) async {
    try {
      var token = StorageHelper.getToken();

      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token.toString()
      };

      var url = "${Api.getBookingDetails}/$bookingId";

      http.Response response = await HttpRequest.get(
        Uri.parse(url),
        headers: headers,
      );

      log("$url ===========>");
      log(response.body);

      dynamic data = json.decode(response.body);

      if (data['success']) {
        var booking = Booking.fromJson(data['data']['booking']);
        var bookedSeats = seatsFromJson(data['data']['seats']);
        onSuccess(booking, bookedSeats);
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
