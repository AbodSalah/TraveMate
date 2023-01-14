// ignore_for_file: file_names

import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getInfoRoomRespon(String idroom) async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    '${MangeAPi.getinfoRatingandBoking}/$idroom',
  );
  print(respons);
  return respons;
}

// addSearchmapRespon(String idhotel) async {
//   Curd curd = Curd();
//   var respons = await curd.getrequest(
//   ,
//   );
//   print(respons);
//   return respons;
// }

addSearchmapRespon({double? longitude, double? latitude}) async {
  Curd curd = Curd();
  var respons = await curd.putrequest(
    'https://hotel-booking-8qw1.onrender.com/api/users/coordinates',
    {
      "userId": sharedPreferences.getString('id') ?? '63bc4b544adc57da5485eb3b',
      "longitude": longitude,
      "latitude": latitude
    },
    encode: true,
    headersss: myheaders3,
  );
  print('data');
  print(respons);
  return respons;
}

getInfoHotelRespon(String idhotel) async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    '${MangeAPi.getinfohotel}/$idhotel',
  );
  print(respons);
  return respons;
}

addDataRespon({String? data, String? placeid}) async {
  Curd curd = Curd();
  var respons = await curd.putrequest(
    '${MangeAPi.addData}/${placeid ?? '63b1db60cdf4dc13bf830abb'}',
    {
      "dates":
          data ?? "2022-11-27T07:45:56.763+00:00,2022-11-27T07:45:56.763+00:00",
    },
    encode: true,
    headersss: myheaders3,
  );
  print('data');
  print(respons);
  return respons;
}
