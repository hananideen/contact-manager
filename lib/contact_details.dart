import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import './info_card.dart';
import './contact.dart';
import './contact_edit.dart';

class ContactDetails extends StatelessWidget {

  final Contact contact;
  ContactDetails({Key key, @required this.contact}) : super(key: key);

  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        RaisedButton(
          color: Colors.teal,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (context) => EditContact(contact: contact));
              Navigator.pushReplacement(context, route);
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
              onPressed: () async {
                String removeSpaceFromPhoneNumber = contact.phoneNo.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
                final phoneCall = 'tel:$removeSpaceFromPhoneNumber';

                if (await launcher.canLaunch(phoneCall)) {
                  await launcher.launch(phoneCall);
                } else {
                  _showDialog(
                    context,
                    title: 'Oops',
                    msg: 'Phone number can not be called.',
                  );
                }
              },
            ),
            InfoCard(
              text: contact.email,
              icon: Icons.email,
              onPressed: () async {
                final emailAddress = 'mailto:${contact.email}';

                if (await launcher.canLaunch(emailAddress)) {
                  await launcher.launch(emailAddress);
                } else {
                  _showDialog(
                    context,
                    title: 'Oops',
                    msg: 'Email cannot be send.',
                  );
                }
              },
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