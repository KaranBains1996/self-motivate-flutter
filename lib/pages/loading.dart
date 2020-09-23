import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:self_motivate/services/quote_svc.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  void fetchQuote() async {
    QuoteSvc quoteSvc = QuoteSvc();
    await quoteSvc.getQuote();
    Navigator.pushReplacementNamed(context, '/quote', arguments: {
      'quoteText': quoteSvc.quoteText,
      'quoteAuthor': quoteSvc.quoteAuthor
    });
  }

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        )));
  }
}
