import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:trioangle/serviece/phone_auth_service.dart';
import 'package:trioangle/view/home_screen.dart';
import 'package:trioangle/view/login_screen.dart';
import 'package:trioangle/view_model/register_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _validateKey = GlobalKey<FormState>();
  String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
  final PhoneAuthService _authService = PhoneAuthService();
  String countryCode = '';
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ChangeNotifierProvider(
          create: (context) => RegisterViewModel(),
          child: Consumer<RegisterViewModel>(
            builder: (context, register, _) {
              return Form(
                key: _validateKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _firstName,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            labelText: "First Name",
                            labelStyle: TextStyle(color: Colors.grey.shade400)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter first Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _lastName,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            labelText: "Last Name *",
                            labelStyle: TextStyle(color: Colors.grey.shade400)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _email,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.mail),
                            labelText: "Mail",
                            labelStyle: TextStyle(color: Colors.grey.shade400)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: IntlPhoneField(
                        style: const TextStyle(color: Colors.white),
                        controller: _phone,
                        decoration: const InputDecoration(),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          countryCode = phone.countryCode;
                        },
                        validator: (value) {
                          if (value?.countryCode == null) {
                            return 'Please enter a valid phone number';
                          }
                          if (value == null) {
                            return "Please enter first Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: isPassword,
                        style: const TextStyle(color: Colors.white),
                        controller: _password,
                        decoration: InputDecoration(
                            prefixIcon: isPassword == false
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.grey.shade400)),
                        validator: (value) {
                          RegExp passwordPattern = RegExp(
                              r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
                          if (value!.isEmpty) {
                            return "Please enter first Name";
                          } else if (value.length < 8) {
                            return "Please enter minimum 8 character ";
                          } else if (!passwordPattern.hasMatch(value)) {
                            return "Please enter one uppercase letter \n one lower case \n one number \n one special character";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    UnconstrainedBox(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            String phoneNumber = countryCode + _phone.text;

                            if (_validateKey.currentState!.validate()) {
                                _authService.phoneAuth(phoneNumber, context);
                                register.addData(
                                    FirebaseAuth.instance.currentUser?.uid ??
                                        "",
                                    _firstName.text,
                                    _lastName.text,
                                    phoneNumber,
                                    _email.text,
                                    _password.text);
                            }
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          )),
                    )
                  ],
                ),
              );
            },
          )),
      backgroundColor: Colors.black,
    );
  }
}
