import 'package:flutter/material.dart';
import 'package:self_motivate/entities/quote_entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedQuotes extends StatefulWidget {
  @override
  _SavedQuotesState createState() => _SavedQuotesState();
}

class _SavedQuotesState extends State<SavedQuotes> {
  var quotes = new List<QuoteEntity>();

  void getSavedQuotes() async {
    final prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    print('[saved_quotes] $keys');
    var quoteList = new List<QuoteEntity>();
    keys.forEach((key) {
      print(prefs.get(key));
      QuoteEntity quoteEntity = QuoteEntity();
      quoteEntity.parseJSON(prefs.get(key));
      quoteList.add(quoteEntity);
    });
    setState(() {
      quotes = quoteList;
    });
  }

  @override
  void initState() {
    super.initState();
    getSavedQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text('Saved Quotes'),
        ),
        body: ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.list),
                trailing: Text(quotes[index].quoteAuthor),
                title: Text(quotes[index].quoteText),
              );
            }));
  }
}
