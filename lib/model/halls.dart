import 'package:cine_plex/model/theaters.dart';

List<CinemaHalls> cinemaHallsFromJson(List<dynamic> cinemaHallsJson) =>
    List<CinemaHalls>.from(cinemaHallsJson
        .map((cinemaHallJson) => CinemaHalls.fromJson(cinemaHallJson)));

class CinemaHalls {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? status;
  String? image;
  String? bannerImage;
  String? registrationNumber;
  String? legalNumber;
  String? legalType;
  String? description;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  List<Theaters>? theaters;

  CinemaHalls(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.status,
      this.image,
      this.bannerImage,
      this.registrationNumber,
      this.legalNumber,
      this.legalType,
      this.description,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.imageUrl,
      this.theaters});

  CinemaHalls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    image = json['image'];
    bannerImage = json['banner_image'];
    registrationNumber = json['registration_number'];
    legalNumber = json['legal_number'];
    legalType = json['legal_type'];
    description = json['description'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
    if (json['theaters'] != null) {
      theaters = theatersFromJson(json['theaters']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    data['image'] = image;
    data['banner_image'] = bannerImage;
    data['registration_number'] = registrationNumber;
    data['legal_number'] = legalNumber;
    data['legal_type'] = legalType;
    data['description'] = description;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image_url'] = imageUrl;
    if (theaters != null) {
      data['theaters'] = theaters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
