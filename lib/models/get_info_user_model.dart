class GetInfoUserModel {
  Message? message;

  GetInfoUserModel({this.message});

  GetInfoUserModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? sId;
  String? username;
  String? email;
  String? country;
  String? img;
  String? city;
  String? phone;
  List<String>? categories;

  Message(
      {this.sId,
      this.username,
      this.email,
      this.country,
      this.img,
      this.city,
      this.phone,
      this.categories});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    country = json['country'];
    img = json['img'];
    city = json['city'];
    phone = json['phone'];
    categories = json['categories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['country'] = this.country;
    data['img'] = this.img;
    data['city'] = this.city;
    data['phone'] = this.phone;
    data['categories'] = this.categories;
    return data;
  }
}
