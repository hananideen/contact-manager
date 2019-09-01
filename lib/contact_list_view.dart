import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './contact.dart';
import './contact_details.dart';


class ContactListView extends StatefulWidget {
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final String uri = 'https://mock-rest-api-server.herokuapp.com/api/v1/user';

  Future<List<Contact>> fetchContact() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      Data data = new Data.fromJson(items);
      List<Contact> contactList = data.contacts;

      return contactList;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Contact>>(
        future: fetchContact(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError){
              return Text("Error");
            }

            return ListView(
              children: snapshot.data
                  .map((user) => ListTile(
                title: Text(user.firstName + " " + user.lastName),
                subtitle: Text(user.phoneNo),
                trailing: Icon(Icons.star_border),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.person),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactDetails(contact: user),
                    ),
                  );
                },
              ))
                  .toList(),
            );

          } else{
            return null;
          }
        },
      ),
    );
  }
}

