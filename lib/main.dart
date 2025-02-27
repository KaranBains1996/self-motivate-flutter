import 'package:flutter/material.dart';
import 'package:self_motivate/pages/loading.dart';
import 'package:self_motivate/pages/quote.dart';
import 'package:self_motivate/pages/saved_quotes.dart';
import 'package:self_motivate/pages/error_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoadingPage(),
      '/quote': (context) => QuotePage(),
      '/saved': (context) => SavedQuotes(),
      '/error': (context) => ErrorPage()
    },
  ));
}
