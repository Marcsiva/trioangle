import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:trioangle/firebase_options.dart';
import 'package:trioangle/view/home_screen.dart';
import 'package:trioangle/view/login_screen.dart';
import 'package:trioangle/view_model/register_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InAppWebViewPlatform.instance = InAppWebViewPlatform.instance!;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Widget initialScreen =
        user != null ? const HomeScreen() : const LoginScreen();
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
         home: initialScreen,
      ),
    );
  }
}
