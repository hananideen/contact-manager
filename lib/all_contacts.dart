import 'package:flutter/material.dart';
import './contact_list_view.dart';

class AllContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListView(),
    );
  }
}