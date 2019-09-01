import 'package:flutter/material.dart';
import './contact_list_view.dart';
import './listview_json_api_task-4.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: ContactListView(),
      home: ListViewJsonapi(),
    );
  }
}