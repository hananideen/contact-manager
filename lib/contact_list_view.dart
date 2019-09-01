import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './contact.dart';
import './contact_add.dart';
import './contact_details.dart';
import './favorites_contact.dart';

class ContactListView extends StatefulWidget {
  _ContactListViewState createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView>{
  List<Contact> savedList = new List();
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

  deleteContact(id) async {
    final String uri = 'https://mock-rest-api-server.herokuapp.com/api/v1/user/' + id;

    var response = await http.delete(uri);
    if (response.statusCode == 200) {
      print("success");
    } else{
      throw Exception('Failed');
    }
  }

  void pressFavorite(Contact contact) {
    if (isSaved(contact))
      savedList.remove(contact);
    else
      savedList.add(contact);

    print(savedList);
  }

  bool isSaved(Contact contact) {
    return savedList.contains(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesContact(contacts: savedList),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List<Contact>>(
        future: fetchContact(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || (snapshot.connectionState != ConnectionState.done)) return Center(child: CircularProgressIndicator());

          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError){
              return Text("Error");
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                final contact = snapshot.data[index];

                return Dismissible(
                  key: new ObjectKey(contact.id),
                  onDismissed: (direction) {
                    setState(() {
                      deleteContact(contact.id);
                      snapshot.data.removeAt(index);

                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('${contact.firstName} ${contact.lastName} deleted')));
                    });
                  },

                  background: Container(color: Colors.grey),
                  child: ListTile(
                    title: Text('${contact.firstName} ${contact.lastName}'),
                    subtitle: Text('${contact.phoneNo}'),
                    trailing: IconButton(icon: (isSaved(contact)) ? Icon(Icons.star) : Icon(Icons.star_border),
                        onPressed: () {
                        pressFavorite(contact);
//                      setState(() {
//                      });
                    }),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('${contact.firstName[0]}${contact.lastName[0]}'),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDetails(contact: contact),
                        ),
                      );
                    },
                  ),
                );
              }
            );

          } else{
            return null;
          }
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddContact()));
          },
          child: Icon(Icons.person_add),
          backgroundColor: Colors.blue,
        )
    );
  }
}

