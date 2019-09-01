import 'package:flutter/material.dart';
import './all_contacts.dart';
import './favorites_contact.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "All"),
                Tab(text: "Favorites")
              ],
            ),
            title: Text('Contact Manager'),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              AllContact(),
              FavoritesContact(),
            ],
          ),
        ),
      ),
    );
  }
}