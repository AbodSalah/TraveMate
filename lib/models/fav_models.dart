class FavoriteModel {
  List<FavouritePlaces>? favouritePlaces;

  FavoriteModel({this.favouritePlaces});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    if (json['favouritePlaces'] != null) {
      favouritePlaces = <FavouritePlaces>[];
      json['favouritePlaces'].forEach((v) {
        favouritePlaces!.add(new FavouritePlaces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.favouritePlaces != null) {
      data['favouritePlaces'] =
          this.favouritePlaces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavouritePlaces {
  String? sId;
  String? title;
  String? type;
  int? price;
  int? maxPeople;
  String? desc;
  String? city;
  int? destanceFromCityCenter;
  double? averageRating;
  int? discount;
  String? imgs;
  Address? address;

  FavouritePlaces(
      {this.sId,
      this.title,
      this.type,
      this.price,
      this.maxPeople,
      this.desc,
      this.city,
      this.destanceFromCityCenter,
      this.averageRating,
      this.discount,
      this.imgs,
      this.address});

  FavouritePlaces.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    price = json['price'];
    maxPeople = json['maxPeople'];
    desc = json['desc'];
    city = json['city'];
    destanceFromCityCenter = json['destanceFromCityCenter'];
    averageRating = double.parse(json['averageRating'].toString());
    discount = json['discount'];
    imgs = json['imgs'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['price'] = this.price;
    data['maxPeople'] = this.maxPeople;
    data['desc'] = this.desc;
    data['city'] = this.city;
    data['destanceFromCityCenter'] = this.destanceFromCityCenter;
    data['averageRating'] = this.averageRating;
    data['discount'] = this.discount;
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
