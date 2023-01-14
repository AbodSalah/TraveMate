// ignore_for_file: file_names

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getProfileRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    '${MangeAPi.getInfoUser}/${sharedPreferences.getString('id')}',
  );
  print(respons);
  return respons;
}
