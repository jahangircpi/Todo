import 'package:http/http.dart' as http;

import 'ModelQuran/individualsuramodel.dart';
import 'modelsurah.dart';

class ApiQuran {
  var link = "https://api.alquran.cloud/v1/surah";
  var link2 = "https://api.alquran.cloud/v1/surah/1/en.asad";
  Future fetchdata() async {
    var response = await http.get(Uri.parse(link));
    if (response.statusCode == 200) {
      return surahlistsFromJson(response.body);
    }
  }

  Future fetchdata2(number) async {
    var response = await http
        .get(Uri.parse("https://api.alquran.cloud/v1/surah/$number/en.asad"));
    if (response.statusCode == 200) {
      return individualSurahFromJson(response.body);
    }
  }

  Future fetchdata3() async {
    var response = await http.get(Uri.parse(link2));
    if (response.statusCode == 200) {
      return individualSurahFromJson(response.body);
    }
  }
}
