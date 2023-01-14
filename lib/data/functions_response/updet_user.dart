// ignore_for_file: file_names

import 'dart:io';

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

updetUserRespons({
  String? username,
  String? country,
  String? phone,
  String? imgs,
  String? email,
  String? city,
  File? isfile,
}) async {
  Curd curd = Curd();
  var respons = isfile == null
      ? await curd.putrequest(
          '${MangeAPi.updateUser}/${sharedPreferences.getString('id')}',
          {
            'username': username,
            'country': country,
            'city': city,
            'phone': phone,
            'email': sharedPreferences.getString('email'),
          },
        )
      : await curd.putrequestforFile(
          '${MangeAPi.updateUser}/${sharedPreferences.getString('id')}',
          {
            'username': username,
            'country': country,
            'city': city,
            'phone': phone,
            'imgs[]': isfile.path,
            'email': sharedPreferences.getString('email'),
          },
          isfile,
        );
  print(respons);
  return respons;
}
