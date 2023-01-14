import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/main.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getCatogeryRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    MangeAPi.getminslection,
  );
  return respons;
}

aDDCatogeryRespon(String catogorys) async {
  Curd curd = Curd();
  print(
      '===========================${MangeAPi.addminslection}/${sharedPreferences.getString('id')}/?categories=${catogorys}=========================');
  var respons = await curd.putrequest(
      '${MangeAPi.addminslection}/${sharedPreferences.getString('id')}/?categories=${catogorys}',
      //https://hotel-booking-8qw1.onrender.com/api/users/addUserCategories/63a121b56cc98ab64c281828/?categories=متنزهات,ملاعب',',
      {
        // "categories": catogorys,
      },
      encode: false);
  print(respons);
  return respons;
}

getUserCatogeryRespon() async {
  Curd curd = Curd();
  print('${MangeAPi.getusercato}/${sharedPreferences.getString('id')}');
  var respons = await curd.getrequest(
    '${MangeAPi.getusercato}/${sharedPreferences.getString('id')}',
  );
  return respons;
}

getRecommendAiRespon() async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    'https://hotel-booking-8qw1.onrender.com/api/rooms/recommender',
  );
  return respons;
}
