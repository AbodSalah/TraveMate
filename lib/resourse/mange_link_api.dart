import '../main.dart';

class MangeAPi {
  static const String baseurl = "https://hotel-booking-8qw1.onrender.com";
  /////////////////////////////Auth///////////////////////////////////////
  static const String login = "$baseurl/api/users/auth/login";

  //////////////////////////////////main//////////////////////////////
  static const String topRatingRooms = "$baseurl/api/rooms/topRating";
  static const String Feedback = "$baseurl/api/rooms/Feedback"; //id
  static const String topBookingRooms = "$baseurl/api/rooms/topBooking";
  static const String getHotelTypes = "$baseurl/api/hotels/getHotelTypes";
  static const String getCities = "$baseurl/api/hotels/getCities";

  //////////////////////////////////////////////////////////////////////
  static const String updateUser = "$baseurl/api/users/updateUser"; //id user
  static const String getinfoRatingandBoking =
      "$baseurl/api/rooms/getRoom"; //id room

  static const String getdatabycities = "$baseurl/api/rooms/getCity"; //idcity
  static const String getInfoUser =
      "$baseurl/api/users/getUserInformation"; //id user

  static const String searchBytext =
      "$baseurl/api/rooms/roomSearch?searchText"; //id user
  static const String getHelpQuestions =
      "$baseurl/api/admin/getHelpQuestions"; //id user

  static const String getfavouritePlaces =
      "$baseurl/api/users/getfavouritePlaces"; //id
  static const String getminslection = "$baseurl/api/hotels/getCategories";
  static const String getnotfy =
      "$baseurl/api/owner/feedbackNotification?userId";
  static const String addminslection = "$baseurl/api/users/addUserCategories";
  static const String getusercato = "$baseurl/api/users/getUserCategories";
  static const String nearestPlaces =
      "$baseurl/api/users/nearestPlaces"; //;?userId=639caf058434dde492ead5f6&category=ملاعب;
  static const String updatefavouritePlaces =
      "$baseurl/api/users/updatefavouritePlaces";
  static const String getRoomsByType =
      "$baseurl/api/rooms/getRoomsByType/?type";
  static const String roomsFilter = "$baseurl/api/rooms/roomsFilter";
  static const String offers = "$baseurl/api/rooms/offers";
  static const String addData = "$baseurl/api/rooms/availability"; //id
  ///637cf32c33762baba63f1827";
  static const String getinfohotel =
      "$baseurl/api/hotels/getHotel"; ////63b1dae6cdf4dc13bf830aae
  ///637cf32c33762baba63f1827/?categories=متنزهات,ملاعب"; //id
  ///63a121b56cc98ab64c281828 : auth
}
