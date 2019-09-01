import 'package:flutter/material.dart';

import './contact.dart';
import './contact_details.dart';

class FavoritesContact extends StatefulWidget {

  final List<Contact> contacts;
  FavoritesContact({Key key, @required this.contacts}) : super(key: key);
  _FavoritesContactState createState() => _FavoritesContactState();

}

class _FavoritesContactState extends State<FavoritesContact> {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Favorites'),
          ),

          body: ListView(
            children: widget.contacts
                .map((contact) => ListTile(
              title: Text(contact.firstName + " " + contact.lastName),
              subtitle: Text(contact.phoneNo),
              trailing: IconButton(icon: Icon(Icons.star),
                onPressed: (){
                  setState(() {
                    widget.contacts.remove(contact);
                  });
                },),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactDetails(contact: contact),
                  ),
                );
              },
            ))
                .toList(),
          )
      );
  }
}