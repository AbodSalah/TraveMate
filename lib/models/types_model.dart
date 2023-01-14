class TypesModel {
  List<Message>? message;

  TypesModel({this.message});

  TypesModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? title;
  String? desc;
  String? imgs;

  Message({this.type, this.title, this.desc, this.imgs});

  Message.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    desc = json['desc'];
    imgs = json['imgs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['imgs'] = this.imgs;
    return data;
  }
}
