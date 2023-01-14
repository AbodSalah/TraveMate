class SearchModel {
  List<Rooms>? rooms;
  List<Hotels>? hotels;

  SearchModel({this.rooms, this.hotels});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['Rooms'] != null) {
      rooms = <Rooms>[];
      json['Rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
    if (json['Hotels'] != null) {
      hotels = <Hotels>[];
      json['Hotels'].forEach((v) {
        hotels!.add(new Hotels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rooms != null) {
      data['Rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    if (this.hotels != null) {
      data['Hotels'] = this.hotels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rooms {
  String? sId;
  String? title;
  String? type;
  int? price;
  String? desc;
  double? averageRating;
  String? imgs;

  Rooms(
      {this.sId,
      this.title,
      this.type,
      this.price,
      this.desc,
      this.averageRating,
      this.imgs});

  Rooms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    price = json['price'];
    desc = json['desc'];
    averageRating = double.parse(json['averageRating'].toString());
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['price'] = this.price;
    data['desc'] = this.desc;
    data['averageRating'] = this.averageRating;
    data['imgs'] = this.imgs;
    return data;
  }
}

class Hotels {
  String? sId;
  String? userId;
  String? name;
  String? type;
  String? city;
  String? destanceFromCityCenter;
  String? address;
  String? desc;
  String? rating;
  List<String>? category;
  String? imgs;

  Hotels(
      {this.sId,
      this.userId,
      this.name,
      this.type,
      this.city,
      this.destanceFromCityCenter,
      this.address,
      this.desc,
      this.rating,
      this.category,
      this.imgs});

  Hotels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    type = json['type'];
    city = json['city'];
    destanceFromCityCenter = json['destanceFromCityCenter'];
    address = json['address'].toString();
    desc = json['desc'];
    rating = json['rating'].toString();
    category = json['category'].cast<String>();
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['city'] = this.city;
    data['destanceFromCityCenter'] = this.destanceFromCityCenter;
    data['address'] = this.address;
    data['desc'] = this.desc;
    data['rating'] = this.rating;
    data['category'] = this.category;
    data['imgs'] = this.imgs;
    return data;
  }
}
