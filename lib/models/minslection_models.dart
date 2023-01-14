class GetCatogerys {
  List<Message>? message;

  GetCatogerys({this.message});

  GetCatogerys.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
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

class Message {
  String? sId;
  String? name;
  String? imgs;

  Message({this.sId, this.name, this.imgs});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['imgs'] = this.imgs;
    return data;
  }
}

class GetUserCatogerys {
  List<UserCategories>? userCategories;

  GetUserCatogerys({this.userCategories});

  GetUserCatogerys.fromJson(Map<String, dynamic> json) {
    if (json['userCategories'] != null) {
      userCategories = <UserCategories>[];
      json['userCategories'].forEach((v) {
        userCategories!.add(new UserCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userCategories != null) {
      data['userCategories'] =
          this.userCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCategories {
  String? sId;
  String? name;
  String? imgs;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UserCategories(
      {this.sId,
      this.name,
      this.imgs,
      this.createdAt,
      this.updatedAt,
      this.iV});

  UserCategories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    imgs = json['imgs'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['imgs'] = this.imgs;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
