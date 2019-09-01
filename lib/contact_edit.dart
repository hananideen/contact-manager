import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './contact.dart';

class EditContact extends StatefulWidget {

  final Contact contact;
  EditContact({Key key, @required this.contact}) : super(key: key);

  _EditContactState createState() => _EditContactState(contact);
}

class _EditContactState extends State<EditContact> {

  final Contact contact;

  _EditContactState(this.contact);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();

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

  @override
  void initState() {
    firstNameController.text = contact.firstName;
    lastNameController.text = contact.lastName;
    phoneNoController.text = contact.phoneNo;
    emailController.text = contact.email;
    dobController.text = contact.dateOfBirth;
    genderController.text = contact.gender;
    super.initState();
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
                controller: lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: phoneNoController,
                decoration: InputDecoration(
                    labelText: 'Phone Number'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: dobController,
                decoration: InputDecoration(
                    labelText: 'Date of Birth'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: genderController,
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