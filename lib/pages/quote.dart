import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:self_motivate/components/heart.dart';
import 'package:self_motivate/common/hash.dart';

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage>
    with SingleTickerProviderStateMixin {
  //Vertical drag details
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  Map data = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 0.50),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void hearted(bool isFav) async {
    print('[quote.dart] $isFav');
    String keyHash = generateMd5(data['quoteText']);
    print('[quote.dart] KEY HASH ---> $keyHash');
    final prefs = await SharedPreferences.getInstance();
    isFav
        ? prefs.setStringList(keyHash, [data['quoteText'], data['quoteAuthor']])
        : prefs.remove(keyHash);
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text('Self Motivate'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.list,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/saved');
            },
          )
        ],
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
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        data['quoteText'],
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.grey[100],
                            backgroundColor: Colors.red,
                            fontFamily: 'PTSans',
                            fontStyle: FontStyle.italic),
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
                            fontSize: 24.0,
                            color: Colors.grey[100],
                            backgroundColor: Colors.red,
                            fontFamily: 'PTSans',
                          ),
                        )),
                    SizedBox(
                      height: 100,
                    ),
                    Heart(
                      hearted: hearted,
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.grey[400],
                        size: 30.0,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share('${data['quoteText']} - ${data['quoteAuthor']}');
        },
        child: Icon(
          Icons.share,
          color: Colors.grey[100],
        ),
        backgroundColor: Colors.grey[800],
      ),
    );
  }
}
