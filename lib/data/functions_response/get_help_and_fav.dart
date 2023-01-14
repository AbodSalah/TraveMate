// ignore_for_file: file_names

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getHelpRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    MangeAPi.getHelpQuestions,
  );

  return respons;
}

getFavoritRespon(String idUser) async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    '${MangeAPi.getfavouritePlaces}/$idUser',
  );

  return respons;
}

addFavoritRespon({String? userId, String? placeId}) async {
  Curd curd = Curd();
  var respons = await curd.putrequest(
    MangeAPi.updatefavouritePlaces,
    {
      "userId": userId ?? "63a121b56cc98ab64c281828",
      "placeId": placeId ?? "638e12d4387bd697991743a6"
    },
    encode: true,
    headersss: myheaders3,
  );
  print('Favorite');
  print(respons);
  return respons;
}
