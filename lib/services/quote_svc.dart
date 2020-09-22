import 'package:http/http.dart';
import 'dart:convert';
import 'dart:math';

class QuoteSvc {
  String quoteText;
  String quoteAuthor;

  Future<void> getQuote() async {
    try {
      Random rnd = new Random();
      int key = rnd.nextInt(999999);
      print('KEY ----> $key');
      Response response = await get(
          'http://api.forismatic.com/api/1.0/?method=getQuote&key=$key&format=json&lang=en');
      Map data = jsonDecode(response.body.replaceAll(r"\'", "'"));
      this.quoteText = data['quoteText'];
      this.quoteAuthor = data['quoteAuthor'];
      print(data);
    } catch (ex) {
      print(ex);
    }
  }
}
