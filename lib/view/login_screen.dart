import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:trioangle/view/register_screen.dart';
import '../serviece/phone_auth_service.dart';
import '../utils/login_background_design.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _validateKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();
  final PhoneAuthService _authService = PhoneAuthService();
  String countryCode = '';
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Stack(
            children: [
              Container(
                height: screenHeight * 1,
                width: screenWidth * 1,
                color: Colors.black,
                child: CustomPaint(
                  painter: BackgroundDesign(),
                ),
              ),
              Positioned(
                top: screenHeight * 0.15,
                bottom: screenHeight * 0.15,
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
                child: Container(
                    height: screenHeight * 0.7,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IntlPhoneField(
                            controller: _phone,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15)),
                              contentPadding: const EdgeInsets.all(15),
                            ),
                            initialCountryCode: 'IN',
                            onChanged: (phone) {
                              countryCode = phone.countryCode;
                            },
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "don't have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen()));
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                        Divider(
                            thickness: 3,
                            color: Colors.grey.shade300,
                            indent: 20,
                            endIndent: 20),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade800),
                            onPressed: () {
                              String phoneNumber = countryCode + _phone.text;
                              if (_validateKey.currentState!.validate()) {
                                _authService.phoneAuth(phoneNumber, context);
                              }
                            },
                            icon: const Icon(
                              Icons.facebook,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Login with facebook",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            )),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200),
                            onPressed: () {},
                            icon: Image(
                              image: const AssetImage("assets/google_logo.png"),
                              width: screenWidth * 0.05,
                              height: screenHeight * 0.05,
                            ),
                            label: const Text(
                              "Login with facebook",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            )),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
