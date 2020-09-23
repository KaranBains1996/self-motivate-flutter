import 'package:flutter/material.dart';

class SavedQuotes extends StatefulWidget {
  @override
  _SavedQuotesState createState() => _SavedQuotesState();
}

class _SavedQuotesState extends State<SavedQuotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Saved Quotes'),
      ),
    );
  }
}
