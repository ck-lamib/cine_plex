import 'dart:convert';

List<Movie> moviesFromJson(List<dynamic> moviesJson) =>
    List<Movie>.from(moviesJson.map((movieJson) => Movie.fromJson(movieJson)));

List<ShowTimes> showTimesFromJson(List<dynamic> showTimesJson) =>
    List<ShowTimes>.from(
        showTimesJson.map((showTimeJson) => ShowTimes.fromJson(showTimeJson)));

List<Show> showsFromJson(List<dynamic> showsJson) =>
    List<Show>.from(showsJson.map((showJson) => Show.fromJson(showJson)));

class Movie {
  int? id;
  int? vendorId;
  int? theaterId;
  String? title;
  String? duration;
  String? releaseDate;
  String? image;
  String? trailer;
  String? status;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;
  String? trailerUrl;
  List<ShowTimes>? showTimes;

  Movie(
      {this.id,
      this.vendorId,
      this.theaterId,
      this.title,
      this.releaseDate,
      this.duration,
      this.image,
      this.trailer,
      this.status,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.imageUrl,
      this.trailerUrl,
      this.showTimes});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    theaterId = json['theater_id'];
    title = json['title'];
    releaseDate = json['release_date'];
    duration = json['duration'];
    image = json['image'];
    trailer = json['trailer'];
    status = json['status'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
    trailerUrl = json['trailer_url'];
    if (json['show_times'] != null) {
      showTimes = showTimesFromJson(json['show_times']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['theater_id'] = theaterId;
    data['title'] = title;
    data['release_date'] = releaseDate;
    data['duration'] = duration;
    data['image'] = image;
    data['trailer'] = trailer;
    data['status'] = status;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image_url'] = imageUrl;
    data['trailer_url'] = trailerUrl;
    if (showTimes != null) {
      data['show_times'] = showTimes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowTimes {
  int? id;
  int? vendorId;
  int? theaterId;
  int? movieId;
  List<Show>? showDetails;
  String? description;
  String? createdAt;
  String? updatedAt;

  ShowTimes(
      {this.id,
      this.vendorId,
      this.theaterId,
      this.movieId,
      this.showDetails,
      this.description,
      this.createdAt,
      this.updatedAt});

  ShowTimes.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    vendorId = data['vendor_id'];
    theaterId = data['theater_id'];
    movieId = data['movie_id'];
    if (data['show_details'] != null) {
      showDetails = showsFromJson(json.decode(data['show_details']));
    }
    description = data['description'];
    createdAt = data['created_at'];
    updatedAt = data['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['theater_id'] = theaterId;
    data['movie_id'] = movieId;
    data['show_details'] = showDetails;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (showDetails != null) {
      var shows = showDetails!.map((v) => v.toJson()).toList();
      data['show_times'] = json.decode(shows.toString());
    }
    return data;
  }
}

class Show {
  int? showTimeId;
  String? showDate;
  String? showTime;
  int? ticketPrice;

  Show({this.showTimeId, this.showDate, this.showTime, this.ticketPrice});

  Show.fromJson(Map<String, dynamic> json) {
    showTimeId = json['show_time_id'];
    showDate = json['show_date'];
    showTime = json['show_time'];
    ticketPrice = int.parse(json['ticket_price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['show_time_id'] = showTimeId;
    data['show_date'] = showDate;
    data['show_time'] = showTime;
    data['ticket_price'] = ticketPrice;
    return data;
  }
}
