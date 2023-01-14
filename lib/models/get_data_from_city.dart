class GetDataFromCityModel {
  City? city;
  List<TopDestination>? topDestination;
  List<Places>? places;
  List<Hotels>? hotels;

  GetDataFromCityModel(
      {this.city, this.topDestination, this.places, this.hotels});

  GetDataFromCityModel.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['topDestination'] != null) {
      topDestination = <TopDestination>[];
      json['topDestination'].forEach((v) {
        topDestination!.add(new TopDestination.fromJson(v));
      });
    }
    if (json['places'] != null) {
      places = <Places>[];
      json['places'].forEach((v) {
        places!.add(new Places.fromJson(v));
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
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.topDestination != null) {
      data['topDestination'] =
          this.topDestination!.map((v) => v.toJson()).toList();
    }
    if (this.places != null) {
      data['places'] = this.places!.map((v) => v.toJson()).toList();
    }
    if (this.hotels != null) {
      data['Hotels'] = this.hotels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String? sId;
  String? name;
  String? desc;
  List<String>? categories;
  String? imgs;

  City({this.sId, this.name, this.desc, this.categories, this.imgs});

  City.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    desc = json['desc'];
    categories = json['categories'].cast<String>();
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['categories'] = this.categories;
    data['imgs'] = this.imgs;
    return data;
  }
}

class TopDestination {
  String? sId;
  String? name;
  String? city;
  String? imgs;

  TopDestination({this.sId, this.name, this.city, this.imgs});

  TopDestination.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    city = json['city'];
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['imgs'] = this.imgs;
    return data;
  }
}

class Places {
  String? sId;
  String? title;
  String? type;
  int? price;
  String? city;
  double? averageRating;
  String? imgs;

  Places(
      {this.sId,
      this.title,
      this.type,
      this.price,
      this.city,
      this.averageRating,
      this.imgs});

  Places.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    price = json['price'];
    city = json['city'];
    averageRating = double.parse(json['averageRating'].toString());
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['price'] = this.price;
    data['city'] = this.city;
    data['averageRating'] = this.averageRating;
    data['imgs'] = this.imgs;
    return data;
  }
}

class Hotels {
  String? sId;
  String? name;
  String? type;
  String? city;
  String? destanceFromCityCenter;
  String? desc;
  double? rating;
  int? featured;
  List<String>? category;
  String? imgs;
  Address? address;

  Hotels(
      {this.sId,
      this.name,
      this.type,
      this.city,
      this.destanceFromCityCenter,
      this.desc,
      this.rating,
      this.featured,
      this.category,
      this.imgs,
      this.address});

  Hotels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    city = json['city'];
    destanceFromCityCenter = json['destanceFromCityCenter'];
    desc = json['desc'];
    rating = json['rating'];
    featured = json['featured'];
    category = json['category'].cast<String>();
    imgs = json['imgs'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['city'] = this.city;
    data['destanceFromCityCenter'] = this.destanceFromCityCenter;
    data['desc'] = this.desc;
    data['rating'] = this.rating;
    data['featured'] = this.featured;
    data['category'] = this.category;
    data['imgs'] = this.imgs;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? placeId;
  double? longitude;
  double? latitude;
  String? sId;

  Address({this.placeId, this.longitude, this.latitude, this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    placeId = json['placeId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['placeId'] = this.placeId;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['_id'] = this.sId;
    return data;
  }
}
