import 'package:flutter/material.dart';
import './contact.dart';

class EditContact extends StatelessWidget {

  final Contact contact;
  EditContact({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Contact'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.person),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Name'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Phone Number'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Date of Birth'
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Gender'
              ),
            ),
            RaisedButton(
              padding: const EdgeInsets.all(8.0),
              textColor: Colors.white,
              color: Colors.blue,
              child: new Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}