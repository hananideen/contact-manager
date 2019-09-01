import 'package:flutter/material.dart';

import './contact.dart';
import './contact_details.dart';

class FavoritesContact extends StatelessWidget {

  final List<Contact> contacts;
  FavoritesContact({Key key, @required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView(
        children: contacts
          .map((user) => ListTile(
          title: Text(user.firstName + " " + user.lastName),
          subtitle: Text(user.phoneNo),
          trailing: Icon(Icons.star),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person),
          ),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactDetails(contact: user),
          ),
        );
      },
    ))
    .toList(),
    )
    );
  }
}