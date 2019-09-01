import 'package:flutter/material.dart';
import './info_card.dart';

class ContactDetails extends StatefulWidget {
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {

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
                'Hanani B',
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
                text: "+09097987",
                icon: Icons.phone,
              ),
              InfoCard(
                text: "h@g.com",
                icon: Icons.email,
              ),
              InfoCard(
                text: "3/10/1992",
                icon: Icons.cake,
              ),
              InfoCard(
                text: "female",
                icon: Icons.person,
              )
            ],
          ),
        ),
    );
  }
}