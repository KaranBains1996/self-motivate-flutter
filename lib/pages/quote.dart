import 'package:flutter/material.dart';
import 'package:self_motivate/components/nav_drawer.dart';

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  //Vertical drag details
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text('Self Motivate'),
        ),
        body: GestureDetector(
          onVerticalDragStart: (dragDetails) {
            startVerticalDragDetails = dragDetails;
          },
          onVerticalDragUpdate: (dragDetails) {
            updateVerticalDragDetails = dragDetails;
          },
          onVerticalDragEnd: (endDetails) {
            double dx = updateVerticalDragDetails.globalPosition.dx -
                startVerticalDragDetails.globalPosition.dx;
            double dy = updateVerticalDragDetails.globalPosition.dy -
                startVerticalDragDetails.globalPosition.dy;
            double velocity = endDetails.primaryVelocity;

            //Convert values to be positive
            if (dx < 0) dx = -dx;
            if (dy < 0) dy = -dy;

            if (velocity < 0) {
              Navigator.pushReplacementNamed(context, '/');
            } else {
              print('swipe down');
            }
          },
          child: Container(
            color: Colors.grey[900],
            padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    data['quoteText'],
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[100],
                        backgroundColor: Colors.red),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '- ${data['quoteAuthor'].length > 0 ? data['quoteAuthor'] : 'Anonymous'}',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[100],
                          backgroundColor: Colors.red),
                    ))
              ],
            ),
          ),
        ));
  }
}
