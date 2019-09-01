import 'package:flutter/material.dart';
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
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: firstNameController = TextEditingController(text: widget.contact.firstName),
                decoration: InputDecoration(
                  labelText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: firstNameController = TextEditingController(text: widget.contact.lastName),
                decoration: InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: firstNameController = TextEditingController(text: widget.contact.phoneNo),
                decoration: InputDecoration(
                    labelText: 'Phone Number'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: firstNameController = TextEditingController(text: widget.contact.email),
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: firstNameController = TextEditingController(text: widget.contact.dateOfBirth),
                decoration: InputDecoration(
                    labelText: 'Date of Birth'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:16.0, right: 16.0),
              child: TextFormField(
                controller: firstNameController = TextEditingController(text: widget.contact.gender),
                decoration: InputDecoration(
                    labelText: 'Gender'
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(firstNameController.text),
                    );
                  },
                );
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