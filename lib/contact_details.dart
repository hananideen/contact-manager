import 'package:flutter/material.dart';
import './info_card.dart';
import './contact.dart';
import './contact_edit.dart';

class ContactDetails extends StatelessWidget {

  final Contact contact;
  ContactDetails({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditContact(contact: contact),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person),
            ),
            Text(
              contact.firstName + " " + contact.lastName,
              style: TextStyle(
                fontSize: 30,
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