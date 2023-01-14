class DataofCatogeryModels {
  List<NearestPlaces>? nearestPlaces;
  List<NearestHotels>? nearestHotels;

  DataofCatogeryModels({this.nearestPlaces, this.nearestHotels});

  DataofCatogeryModels.fromJson(Map<String, dynamic> json) {
    if (json['NearestPlaces'] != null) {
      nearestPlaces = <NearestPlaces>[];
      json['NearestPlaces'].forEach((v) {
        nearestPlaces!.add(new NearestPlaces.fromJson(v));
      });
    }
    if (json['NearestHotels'] != null) {
      nearestHotels = <NearestHotels>[];
      json['NearestHotels'].forEach((v) {
        nearestHotels!.add(new NearestHotels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nearestPlaces != null) {
      data['NearestPlaces'] =
          this.nearestPlaces!.map((v) => v.toJson()).toList();
    }
    if (this.nearestHotels != null) {
      data['NearestHotels'] =
          this.nearestHotels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearestPlaces {
  String? sId;
  String? title;
  int? price;
  String? city;
  double? averageRating;
  List<String>? category;
  String? imgs;

  NearestPlaces(
      {this.sId,
      this.title,
      this.price,
      this.city,
      this.averageRating,
      this.category,
      this.imgs});

  NearestPlaces.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    city = json['city'];
    averageRating = double.parse(json['averageRating'].toString());
    category = json['category'].cast<String>();
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['city'] = this.city;
    data['averageRating'] = this.averageRating;
    data['category'] = this.category;
    data['imgs'] = this.imgs;
    return data;
  }
}

class NearestHotels {
  String? sId;
  String? name;
  String? city;
  String? destanceFromCityCenter;
  double? rating;
  List<String>? category;
  String? imgs;

  NearestHotels(
      {this.sId,
      this.name,
      this.city,
      this.destanceFromCityCenter,
      this.rating,
      this.category,
      this.imgs});

  NearestHotels.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    city = json['city'];
    destanceFromCityCenter = json['destanceFromCityCenter'];
    rating = double.parse(json['rating'].toString());
    category = json['category'].cast<String>();
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['destanceFromCityCenter'] = this.destanceFromCityCenter;
    data['rating'] = this.rating;
    data['category'] = this.category;
    data['imgs'] = this.imgs;
    return data;
  }
}
