class InfoRoomModel {
  Room? room;
  List<RelatedRooms>? relatedRooms;
  UserContactInfo? userContactInfo;

  InfoRoomModel({this.room, this.relatedRooms, this.userContactInfo});

  InfoRoomModel.fromJson(Map<String, dynamic> json) {
    room = json['Room'] != null ? new Room.fromJson(json['Room']) : null;
    if (json['relatedRooms'] != null) {
      relatedRooms = <RelatedRooms>[];
      json['relatedRooms'].forEach((v) {
        relatedRooms!.add(new RelatedRooms.fromJson(v));
      });
    }
    userContactInfo = json['UserContactInfo'] != null
        ? new UserContactInfo.fromJson(json['UserContactInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.room != null) {
      data['Room'] = this.room!.toJson();
    }
    if (this.relatedRooms != null) {
      data['relatedRooms'] = this.relatedRooms!.map((v) => v.toJson()).toList();
    }
    if (this.userContactInfo != null) {
      data['UserContactInfo'] = this.userContactInfo!.toJson();
    }
    return data;
  }
}

class Room {
  String? sId;
  String? title;
  String? type;
  int? price;
  int? maxPeople;
  String? desc;
  String? city;
  int? destanceFromCityCenter;
  double? averageRating;
  List<String>? features;
  bool? featured;
  int? bookingNumber;
  List<String>? unavailableDates;
  List<String>? category;
  int? discount;
  List<Feedbacks>? feedbacks;
  List<RoomNumbers>? roomNumbers;
  String? imgs;
  Address? address;

  Room(
      {this.sId,
      this.title,
      this.type,
      this.price,
      this.maxPeople,
      this.desc,
      this.city,
      this.destanceFromCityCenter,
      this.averageRating,
      this.features,
      this.featured,
      this.bookingNumber,
      this.unavailableDates,
      this.category,
      this.discount,
      this.feedbacks,
      this.roomNumbers,
      this.imgs,
      this.address});

  Room.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    price = json['price'];
    maxPeople = json['maxPeople'];
    desc = json['desc'];
    city = json['city'];
    destanceFromCityCenter = json['destanceFromCityCenter'];
    averageRating = double.parse(json['averageRating'].toString());
    features = json['features'].cast<String>();
    featured = json['featured'];
    bookingNumber = json['bookingNumber'];
    unavailableDates = json['unavailableDates'].cast<String>();
    category = json['category'].cast<String>();
    discount = json['discount'];
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new Feedbacks.fromJson(v));
      });
    }
    if (json['roomNumbers'] != null) {
      roomNumbers = <RoomNumbers>[];
      json['roomNumbers'].forEach((v) {
        roomNumbers!.add(new RoomNumbers.fromJson(v));
      });
    }
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
    data['features'] = this.features;
    data['featured'] = this.featured;
    data['bookingNumber'] = this.bookingNumber;
    data['unavailableDates'] = this.unavailableDates;
    data['category'] = this.category;
    data['discount'] = this.discount;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    if (this.roomNumbers != null) {
      data['roomNumbers'] = this.roomNumbers!.map((v) => v.toJson()).toList();
    }
    data['imgs'] = this.imgs;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Feedbacks {
  String? userId;
  double? rating;
  String? review;
  String? date;
  String? sId;

  Feedbacks({this.userId, this.rating, this.review, this.date, this.sId});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    rating = double.parse(json['rating'].toString());
    review = json['review'];
    date = json['date'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['date'] = this.date;
    data['_id'] = this.sId;
    return data;
  }
}

class RoomNumbers {
  int? number;
  List<String>? unavailableDates;
  String? sId;

  RoomNumbers({this.number, this.unavailableDates, this.sId});

  RoomNumbers.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    unavailableDates = json['unavailableDates'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['unavailableDates'] = this.unavailableDates;
    data['_id'] = this.sId;
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

class RelatedRooms {
  String? sId;
  String? title;
  int? price;
  String? city;
  double? averageRating;
  String? imgs;

  RelatedRooms(
      {this.sId,
      this.title,
      this.price,
      this.city,
      this.averageRating,
      this.imgs});

  RelatedRooms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    city = json['city'];
    averageRating = double.parse(json['averageRating'].toString());
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['city'] = this.city;
    data['averageRating'] = this.averageRating;
    data['imgs'] = this.imgs;
    return data;
  }
}

class UserContactInfo {
  String? sId;
  String? username;
  String? email;
  String? img;
  String? phone;

  UserContactInfo({this.sId, this.username, this.email, this.img, this.phone});

  UserContactInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    img = json['img'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['img'] = this.img;
    data['phone'] = this.phone;
    return data;
  }
}

class InfoHotelModel {
  Message? message;
  UserContactInfoHotel? userContactInfo;
  List<HotelRooms>? hotelRooms;

  InfoHotelModel({this.message, this.userContactInfo, this.hotelRooms});

  InfoHotelModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    userContactInfo = json['userContactInfo'] != null
        ? new UserContactInfoHotel.fromJson(json['userContactInfo'])
        : null;
    if (json['HotelRooms'] != null) {
      hotelRooms = <HotelRooms>[];
      json['HotelRooms'].forEach((v) {
        hotelRooms!.add(new HotelRooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.userContactInfo != null) {
      data['userContactInfo'] = this.userContactInfo!.toJson();
    }
    if (this.hotelRooms != null) {
      data['HotelRooms'] = this.hotelRooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? sId;
  String? userId;
  String? name;
  String? type;
  String? city;
  String? destanceFromCityCenter;
  String? desc;
  double? rating;
  int? featured;
  List<String>? category;
  String? imgs;
  AddressHotel? address;

  Message(
      {this.sId,
      this.userId,
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

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    type = json['type'];
    city = json['city'];
    destanceFromCityCenter = json['destanceFromCityCenter'];
    desc = json['desc'];
    rating = json['rating'];
    featured = json['featured'];
    category = json['category'].cast<String>();
    imgs = json['imgs'];
    address = json['address'] != null
        ? new AddressHotel.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
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

class AddressHotel {
  String? placeId;
  double? longitude;
  double? latitude;
  String? sId;

  AddressHotel({this.placeId, this.longitude, this.latitude, this.sId});

  AddressHotel.fromJson(Map<String, dynamic> json) {
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

class UserContactInfoHotel {
  String? sId;
  String? username;
  String? email;
  String? country;
  String? city;
  String? phone;

  UserContactInfoHotel(
      {this.sId,
      this.username,
      this.email,
      this.country,
      this.city,
      this.phone});

  UserContactInfoHotel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['country'] = this.country;
    data['city'] = this.city;
    data['phone'] = this.phone;
    return data;
  }
}

class HotelRooms {
  String? sId;
  String? title;
  int? price;
  String? desc;
  String? city;
  int? averageRating;
  bool? featured;
  String? imgs;

  HotelRooms(
      {this.sId,
      this.title,
      this.price,
      this.desc,
      this.city,
      this.averageRating,
      this.featured,
      this.imgs});

  HotelRooms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    desc = json['desc'];
    city = json['city'];
    averageRating = json['averageRating'];
    featured = json['featured'];
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['desc'] = this.desc;
    data['city'] = this.city;
    data['averageRating'] = this.averageRating;
    data['featured'] = this.featured;
    data['imgs'] = this.imgs;
    return data;
  }
}
