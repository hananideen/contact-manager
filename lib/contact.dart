class Data {
  final List<Contact> contacts;

  Data({this.contacts});

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    print(list.runtimeType);
    List<Contact> contactsList = list.map((i) => Contact.fromJson(i)).toList();

    return new Data(
        contacts: contactsList
    );
  }
}

class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String dateOfBirth;
  final String phoneNo;

  Contact({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.phoneNo});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        gender: json['gender'],
        dateOfBirth: json['date_of_birth'],
        phoneNo: json['phone_no']
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'first_name' : firstName,
    'last_name' : lastName,
    'email' : email,
    'gender' : gender,
    'date_of_birth' : dateOfBirth,
    'phone_no' : phoneNo
  };
}