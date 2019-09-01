import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './contact.dart';

class EditContact extends StatefulWidget {

  final Contact contact;
  EditContact({Key key, @required this.contact}) : super(key: key);

  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

  TextEditingController firstNameController = TextEditingController(text: "");
  TextEditingController lastNameController = TextEditingController(text: "");
  TextEditingController phoneNoController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController dobController = TextEditingController(text: "");
  TextEditingController genderController = TextEditingController(text: "");

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNoController.dispose();
    emailController.dispose();
    dobController.dispose();
    genderController.dispose();
    super.dispose();
  }

  updateContact(Contact contact) async {
    final String uri = 'https://mock-rest-api-server.herokuapp.com/api/v1/user/' +contact.id;
    print(uri);

    Map<String, String> headers = {"Content-type": "application/json"};
    String json = jsonEncode(contact);
    print(json);

    var response = await http.put(uri, headers: headers, body: json);
    if (response.statusCode == 200) {
      String body = response.body;
      print("success");
    } else{
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: lastNameController = TextEditingController(text: widget.contact.lastName),
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: phoneNoController = TextEditingController(text: widget.contact.phoneNo),
                decoration: InputDecoration(
                    labelText: 'Phone Number'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: emailController = TextEditingController(text: widget.contact.email),
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: dobController = TextEditingController(text: widget.contact.dateOfBirth),
                decoration: InputDecoration(
                    labelText: 'Date of Birth'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: genderController = TextEditingController(text: widget.contact.gender),
                decoration: InputDecoration(
                    labelText: 'Gender'
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                Contact contact = new Contact(id: widget.contact.id, firstName: firstNameController.text,
                    lastName: lastNameController.text, email: emailController.text, gender: genderController.text,
                    dateOfBirth: dobController.text, phoneNo: phoneNoController.text);
                updateContact(contact);
              },
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