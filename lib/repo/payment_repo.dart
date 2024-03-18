import 'dart:convert';
import 'dart:developer';

import "package:http/http.dart" as http;
import 'package:cine_plex/model/booking.dart';
import 'package:cine_plex/model/seats.dart';
import 'package:cine_plex/utils/api.dart';
import 'package:cine_plex/utils/storage_helper.dart';

import '../utils/http_request.dart';

class PaymentRepo {
  static Future<void> verifyKhaltiPayment({
    required int transactionId,
    required String pidx,
    required int amount,
    required String token,
    required Function(Booking booking, List<Seat> seats) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var accesstoken = StorageHelper.getToken();
      var headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": accesstoken.toString(),
      };

      var body = {
        "booking_id": transactionId,
        "pidx": pidx,
        "amount": amount,
        "token": token
      };

      log(body.toString());

      http.Response response = await HttpRequest.post(
          Uri.parse(Api.verifyPayment),
          headers: headers,
          body: json.encode(body));

      log("${Api.verifyPayment} =========> ");
      log(response.body.toString());
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
      onError("Sorry something went wring");
    }
  }
}
