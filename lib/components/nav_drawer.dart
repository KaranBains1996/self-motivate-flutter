import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.grey
            ),
          ),
          ListTile(
            title: Text('Quotes'),
            onTap: () {
              // close drawer
              // Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Saved'),
            onTap: () {
              // close drawer
              // Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

