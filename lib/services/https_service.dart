
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpsService {

  final baseUrl = Uri.parse(
      'https://asia-northeast3-project-indian.cloudfunctions.net/indian');

  Future<void> getUser() async {
    try {
      var response = await http.post(baseUrl,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "type" : "get_user",
            "doc_id": "qyxSJQr5CbwLLke0qQoW",
          })
      );

      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        print(decodeData);
      } else {
        print("error ${response.statusCode}");
      }
    } catch (error) {
      print("error: $error");
    }
  }

}
