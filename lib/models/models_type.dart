class HotelsTypeModels {
  List<MessageHotelsType>? message;

  HotelsTypeModels({this.message});

  HotelsTypeModels.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <MessageHotelsType>[];
      json['message'].forEach((v) {
        message!.add(new MessageHotelsType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageHotelsType {
  String? sId;
  String? name;
  String? type;
  String? desc;
  String? rating;
  String? featured;
  String? imgs;

  MessageHotelsType(
      {this.sId,
      this.name,
      this.type,
      this.desc,
      this.rating,
      this.featured,
      this.imgs});

  MessageHotelsType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'] + json['title'];
    type = json['type'];
    desc = json['desc'];
    rating = json['rating'].toString();
    featured = json['featured'];
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['desc'] = this.desc;
    data['rating'] = this.rating;
    data['featured'] = this.featured;
    data['imgs'] = this.imgs;
    return data;
  }
}

/////////////////////////////////////////////////////////////////////
///
///
class HouseTypeModels {
  List<MessageTowHouse>? message;

  HouseTypeModels({this.message});

  HouseTypeModels.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <MessageTowHouse>[];
      json['message'].forEach((v) {
        message!.add(new MessageTowHouse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MessageTowHouse {
  String? sId;
  String? type;
  String? title;
  String? price;
  String? desc;
  String? city;
  String? averageRating;
  String? Rating;
  String? featured;
  String? imgs;

  MessageTowHouse(
      {this.sId,
      this.title,
      this.price,
      this.desc,
      this.city,
      this.averageRating,
      this.featured,
      this.imgs});

  MessageTowHouse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'].toString();
    title = json['title'] ?? '' + json['name'] ?? '';
    price = json['price'].toString();
    desc = json['desc'];
    city = json['city'];
    type = json['type'].toString();
    averageRating = json['averageRating'].toString();
    Rating = json['rating'].toString();
    featured = json['featured'].toString();
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['desc'] = this.desc;
    data['city'] = this.city;
    data['type'] = this.type;
    data['rating'] = this.Rating;
    data['averageRating'] = this.averageRating;
    data['featured'] = this.featured;
    data['imgs'] = this.imgs;
    return data;
  }
}
