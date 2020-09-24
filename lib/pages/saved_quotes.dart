import 'package:flutter/material.dart';
import 'package:self_motivate/entities/quote_entities.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedQuotes extends StatefulWidget {
  @override
  _SavedQuotesState createState() => _SavedQuotesState();
}

class _SavedQuotesState extends State<SavedQuotes> {
  var quotes = new List<QuoteEntity>();
  SharedPreferences prefs;

  void getSavedQuotes() async {
    prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    var quoteList = new List<QuoteEntity>();
    keys.forEach((key) {
      QuoteEntity quoteEntity = QuoteEntity();
      quoteEntity.parseJSON(prefs.get(key));
      quoteEntity.key = key;
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

  Future<void> _showMyDialog(String key) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete quote'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this quote?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                prefs.remove(key);
                getSavedQuotes();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
              return Column(
                children: [
                  ListTile(
                    title: Column(
                      children: [
                        Text(
                          quotes[index].quoteText,
                          // overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                    subtitle: Text(quotes[index].quoteAuthor.compareTo('') != 0
                        ? quotes[index].quoteAuthor
                        : 'Anonymous'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Colors.grey[800],
                      onPressed: () {
                        _showMyDialog(quotes[index].key);
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  )
                ],
              );
            }));
  }
}
