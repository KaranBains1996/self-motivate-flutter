import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Internet connection required',
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 22.0,
                    fontFamily: 'PTSans'),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.grey[100],
              tooltip: 'Retry',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            )
          ],
        ),
      ),
    );
  }
}
