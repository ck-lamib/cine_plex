class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? profileImage;
  String? profileImageUrl;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.profileImage,
      this.profileImageUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileImage = json['profile_image'];
    profileImageUrl = json['profile_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_image'] = profileImage;
    data['profile_image_url'] = profileImageUrl;
    return data;
  }
}
