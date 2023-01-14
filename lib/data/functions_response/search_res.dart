import 'package:hotelbooking/data/database/connectdatabase.dart';
import 'package:hotelbooking/resourse/mange_link_api.dart';

getSearchRespon(String textsearch) async {
  Curd curd = Curd();
  var respons = await curd.getrequest(
    '${MangeAPi.searchBytext}=$textsearch',
  );

  return respons;
}

getFiltterRespon({
  String? city,
  int? maxprice,
  int? minprice,
  List<String>? x,
  String? type,
  int? distance,
}) async {
  print(
      '->city $city <- maxprice: $maxprice minprice: $minprice :x $x :type $type distance: $distance ');
  Curd curd = Curd();
  var respons = await curd.postrequest(
    MangeAPi.roomsFilter,
    {
      "city": city,
      "maxPrice": maxprice,
      "minPrice": minprice,
      "features": x,
      "type": type,
      "distance": distance,
    },
    encode: true,
  );
  print(respons);
  return respons;
}
