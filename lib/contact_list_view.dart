import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './contact.dart';


class ContactListView extends StatefulWidget {
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final String uri = 'https://mock-rest-api-server.herokuapp.com/api/v1/user';

  Future<List<Contact>> _fetchContacts() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Contact> contactList = items.map<Contact>((json) {
        return Contact.fromJson(json);
      }).toList();

      return contactList;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Manager'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: _fetchContacts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data
                .map((contact) => ListTile(
              title: Text(contact.firstName + contact.lastName),
              subtitle: Text(contact.phoneNo),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(contact.firstName[0],
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    )),
              ),
            ))
                .toList(),
          );
        },
      ),
    );
  }
}

