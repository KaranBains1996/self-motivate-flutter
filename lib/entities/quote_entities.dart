import 'dart:convert';

class QuoteEntity {
  String quoteText;
  String quoteAuthor;

  QuoteEntity({this.quoteText, this.quoteAuthor});

  String toJSONString() {
    return '{"quoteText":"$quoteText","quoteAuthor": "$quoteAuthor"}';
  }

  void parseJSON(String jsonQuote) {
    Map data = jsonDecode(jsonQuote.replaceAll(r"\'", "'"));
    this.quoteText = data['quoteText'];
    this.quoteAuthor = data['quoteAuthor'];
  }
}
