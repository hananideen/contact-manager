import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListViewJsonapi extends StatefulWidget {
  _ListViewJsonapiState createState() => _ListViewJsonapiState();
}

class _ListViewJsonapiState extends State<ListViewJsonapi> {
  final String uri = 'https://mock-rest-api-server.herokuapp.com/api/v1/user';

  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      Data data = new Data.fromJson(items);
      List<Users> contactList = data.users;

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
      body: FutureBuilder<List<Users>>(
        future: _fetchUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          if(snapshot.connectionState == ConnectionState.done) {
            if(snapshot.hasError){
              return Text("Error");
            }

            return ListView(
              children: snapshot.data
                  .map((user) => ListTile(
                title: Text(user.firstName),
                subtitle: Text(user.email),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(user.firstName[0],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      )),
                ),
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

class Data {
  final List<Users> users;

  Data({this.users});

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    print(list.runtimeType);
    List<Users> usersList = list.map((i) => Users.fromJson(i)).toList();

    return new Data(
      users: usersList
    );
  }
}

class Users {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String phoneNo;

  Users({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.phoneNo});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        gender: json['gender'],
        dateOfBirth: json['date_of_birth'],
        phoneNo: json['phone_no']
    );
  }
}