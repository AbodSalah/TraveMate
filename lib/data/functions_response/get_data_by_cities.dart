// ignore_for_file: file_names

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getdataFromCitesRespon(String idcity) async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    '${MangeAPi.getdatabycities}/$idcity',
  );
  print(respons);
  return respons;
}

getNotfyRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    '${MangeAPi.getnotfy}=${sharedPreferences.getString('id')}',
  );
  print(respons);
  return respons;
}

addFeedbackRespon({String? idRoomFeed, int? reating, String? review}) async {
  Curd curd = Curd();
  var respons = await curd.putrequest(
    '${MangeAPi.Feedback}/${idRoomFeed}',
    {
      "feedbacks": {
        "userId": sharedPreferences.getString('id'),
        "rating": reating,
        "review": review
      },
    },
    encode: true,
    headersss: myheaders3,
  );
  print('feeeeeeeeed');
  print(respons);
  return respons;
}
