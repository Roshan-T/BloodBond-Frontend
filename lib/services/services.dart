import 'package:bloodbond/routes/url.dart';
import 'package:http/http.dart';

import '../controller/nearby_donor.controller.dart';

class ApiService {
  static Future<List<NearbyDonor>?> fetchDonors() async {
    var response = await get(
      Uri.parse(Url.nearbyDonor),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      var data = response.body;
      return nearbyDonorFromJson(data);
    } else {
      return null;
    }
  }

  static void forgetPassword() async {}
}
