import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trioangle/serviece/register_service.dart';
import 'package:trioangle/view/home_screen.dart';

class PhoneAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  final RegisterController _controller = RegisterController();

  Future<void> phoneAuth(String phone, BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: const Duration(minutes: 1),
          verificationCompleted: (PhoneAuthCredential credential) {
            showSnackBar(context, "Verification Complete", Colors.green);
          },
          verificationFailed: (FirebaseAuthException e) {
            showSnackBar(context, "Verification failed", Colors.red);
          },
          codeSent: (String verId, int? resendToken) {
            showSnackBar(context, "Code send successfully", Colors.green);
            otpVerifiedAlertDialog(context, verId,phone);
          },
          codeAutoRetrievalTimeout: (String verId) {
            showSnackBar(context, "Time out", Colors.red);
          });
    } on FirebaseAuthException catch (e) {
      //ignore:avoid_print
      print(e);
    }
  }

  void showSnackBar(BuildContext context, String content, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: color,
    ));
  }

  otpVerification(String verId, String otpCode) async {
    await _auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: verId, smsCode: otpCode));
  }

  otpVerifiedAlertDialog(BuildContext context, String verId,String phone) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Enter your OTP"),
          content: TextFormField(
            controller: _otpController,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  otpVerification(verId, _otpController.text);
                  _controller.update(phone, FirebaseAuth.instance.currentUser!.uid);
                  if (FirebaseAuth.instance.currentUser?.uid != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  }
                },
                child: const Text("Submit")),
          ],
        );
      },
    );
  }

  signOut() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
