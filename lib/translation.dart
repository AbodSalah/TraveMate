import 'package:get/get.dart';
import 'langs/en.dart';
import 'langs/ar.dart';

class Translation extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    "en": en,
    "ar": ar,
  };

}
