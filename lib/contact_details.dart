import 'package:flutter/material.dart';
import './info_card.dart';
import './contact.dart';

class ContactDetails extends StatelessWidget {

  final Contact contact;
  ContactDetails({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          CircleAvatar(
          radius: 50,
          child: Icon(Icons.person),
        ),
        Text(
          contact.firstName + " " + contact.lastName,
          style: TextStyle(
          fontSize: 40.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pacifico',
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: 20,
        width: 200,
        child: Divider(
          color: Colors.black12,
        ),
      ),
      InfoCard(
        text: contact.phoneNo,
        icon: Icons.phone,
      ),
      InfoCard(
        text: contact.email,
        icon: Icons.email,
      ),
      InfoCard(
        text: contact.dateOfBirth,
        icon: Icons.cake,
      ),
      InfoCard(
        text: contact.gender,
        icon: Icons.person,
      )
      ],
    ),
    ),
    );
  }
}