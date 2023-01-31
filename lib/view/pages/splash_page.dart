import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/view/home_page.dart';
import 'package:firebaseapp/view/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class SplashScrenn extends StatefulWidget {
  const SplashScrenn({super.key});

  @override
  State<SplashScrenn> createState() => _SplashScrennState();
}

class _SplashScrennState extends State<SplashScrenn> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      checkUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("SPLASH SCREEN"),
      ),
    );
  }

  void checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignUpPage()));
      }
    });
  }
}
