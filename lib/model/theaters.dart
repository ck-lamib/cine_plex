import 'package:cine_plex/model/movies.dart';
import 'package:cine_plex/model/seats.dart';

List<Theaters> theatersFromJson(List<dynamic> theatersJson) =>
    List<Theaters>.from(
        theatersJson.map((theaterJson) => Theaters.fromJson(theaterJson)));

class Theaters {
  int? id;
  int? vendorId;
  String? name;
  String? email;
  String? phone;
  int? rows;
  int? columns;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Seat>? seats;
  List<Movie>? movies;

  Theaters(
      {this.id,
      this.vendorId,
      this.name,
      this.email,
      this.phone,
      this.rows,
      this.columns,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.seats,
      this.movies});

  Theaters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    rows = json['rows'];
    columns = json['columns'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['seats'] != null) {
      seats = seatsFromJson(json['seats']);
    }
    if (json['movies'] != null) {
      movies = moviesFromJson(json['movies']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['rows'] = rows;
    data['columns'] = columns;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (seats != null) {
      data['seats'] = seats!.map((v) => v.toJson()).toList();
    }
    if (movies != null) {
      data['movies'] = movies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
