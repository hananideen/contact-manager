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

  deleteContact(id) async {
    final String uri = 'https://mock-rest-api-server.herokuapp.com/api/v1/user/' +id;

    var response = await http.delete(uri);
    if (response.statusCode == 200) {
//      String body = response.body;
      print("success");
    } else{
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // Remove the item from the data source. Need to call API later
                    setState(() {
                      deleteContact(contact.id);

                      snapshot.data.removeAt(index);
                      fetchContact();
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('${contact.firstName} ${contact.lastName} deleted')));

//                      return showDialog(
//                        context: context,
//                        builder: (context) {
//                          return AlertDialog(
//                            content: Text("Are you sure you want to delete?"),
//                            actions: <Widget>[
//                              FlatButton(
//                                child: const Text('NO'),
//                                onPressed: () {
//                                  Navigator.of(context).pop(ConfirmAction.CANCEL);
//                                },
//                              ),
//                              FlatButton(
//                                child: const Text('YES'),
//                                onPressed: () {
//                                  snapshot.data.removeAt(index);
//
//                                  Scaffold.of(context)
//                                      .showSnackBar(SnackBar(content: Text('${contact.firstName} ${contact.lastName} deleted')));
//
//                                  Navigator.of(context).pop(ConfirmAction.ACCEPT);
//                                },
//                              )
//                            ],
//                          );
//                        },
//                      );
                    });
                  },

                  background: Container(color: Colors.grey),
                  child: ListTile(
                    title: Text('${contact.firstName} ${contact.lastName}'),
                    subtitle: Text('${contact.phoneNo}'),
                    trailing: Icon(Icons.star_border),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person),
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
    );
  }
}

