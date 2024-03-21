import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterModel {
  String? id;
  String? uid;
  String firstName;
  String lastName;
  String phone;
  String email;
  String password;

  RegisterModel({
    this.id,
     this.uid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
  });
  factory RegisterModel.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return RegisterModel(
        uid: data['uid'] ?? "",
        firstName: data['firstName'] ?? "",
        lastName: data['lastName'] ?? "",
        phone: data['phone'] ?? "",
        email: data['email'],
        password: data['password'] ?? "");
  }

  Map<String,dynamic> toJson() =>{
    'id':id,
    'uid':uid,
    'firstName': firstName,
    'lastName': lastName,
    'phone':phone,
    'email':email,
    'password':password
  };
}
