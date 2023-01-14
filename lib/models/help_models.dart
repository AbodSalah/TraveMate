class HelpModel {
  List<Topics>? topics;

  HelpModel({this.topics});

  HelpModel.fromJson(Map<String, dynamic> json) {
    if (json['Topics'] != null) {
      topics = <Topics>[];
      json['Topics'].forEach((v) {
        topics!.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topics != null) {
      data['Topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  String? sId;
  String? topic;
  List<HelpQuestions>? helpQuestions;

  Topics({this.sId, this.topic, this.helpQuestions});

  Topics.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    topic = json['topic'];
    if (json['helpQuestions'] != null) {
      helpQuestions = <HelpQuestions>[];
      json['helpQuestions'].forEach((v) {
        helpQuestions!.add(new HelpQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['topic'] = this.topic;
    if (this.helpQuestions != null) {
      data['helpQuestions'] =
          this.helpQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HelpQuestions {
  String? question;
  String? answer;
  String? sId;

  HelpQuestions({this.question, this.answer, this.sId});

  HelpQuestions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['_id'] = this.sId;
    return data;
  }
}
