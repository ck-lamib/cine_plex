import 'package:cine_plex/model/halls.dart';
import 'package:cine_plex/model/movies.dart';
import 'package:cine_plex/model/seats.dart';
import 'package:cine_plex/model/theaters.dart';

List<Booking> bookingsFromJson(List<dynamic> bookingsJson) =>
    List<Booking>.from(
        bookingsJson.map((bookingJson) => Booking.fromJson(bookingJson)));

class Booking {
  int? id;
  int? vendorId;
  int? movieId;
  String? showTime;
  int? customerId;
  int? quantity;
  int? price;
  int? subTotal;
  int? discount;
  int? taxAmount;
  int? total;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? showTimeId;
  int? theaterId;
  CinemaHalls? vendor;
  Theaters? theater;
  Movie? movie;
  List<Seat>? seats;

  Booking(
      {this.id,
      this.vendorId,
      this.movieId,
      this.showTime,
      this.customerId,
      this.quantity,
      this.price,
      this.subTotal,
      this.discount,
      this.taxAmount,
      this.total,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.showTimeId,
      this.theaterId,
      this.vendor,
      this.theater,
      this.seats,
      this.movie});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    movieId = json['movie_id'];
    showTime = json['show_time'];
    customerId = json['customer_id'];
    quantity = json['quantity'];
    price = json['price'];
    subTotal = json['sub_total'];
    discount = json['discount'];
    taxAmount = json['tax_amount'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    showTimeId = json['show_time_id'];
    theaterId = json['theater_id'];
    vendor =
        json['vendor'] != null ? CinemaHalls.fromJson(json['vendor']) : null;
    theater =
        json['theater'] != null ? Theaters.fromJson(json['theater']) : null;
    movie = json['movie'] != null ? Movie.fromJson(json['movie']) : null;
    if (json['seats'] != null) {
      var seats = [];
      seats.addAll(seatsFromJson(json['seats']));
    } else {
      seats = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['movie_id'] = movieId;
    data['show_time'] = showTime;
    data['customer_id'] = customerId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['sub_total'] = subTotal;
    data['discount'] = discount;
    data['tax_amount'] = taxAmount;
    data['total'] = total;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['show_time_id'] = showTimeId;
    data['theater_id'] = theaterId;
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    if (theater != null) {
      data['theater'] = theater!.toJson();
    }
    if (movie != null) {
      data['movie'] = movie!.toJson();
    }
    if (seats != null) {
      data['seats'] = seats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
