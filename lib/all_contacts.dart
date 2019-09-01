import 'package:flutter/material.dart';
import './contact_list_view.dart';

class AllContact extends StatefulWidget {
  _AllContactState createState() => _AllContactState();
}

class _AllContactState extends State<AllContact> with AutomaticKeepAliveClientMixin<AllContact>{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListView(),
    );
  }
}
