import 'package:firebaseapp/provider/auth/sign_up_provider.dart';
import 'package:firebaseapp/view/home_page.dart';
import 'package:firebaseapp/view/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      builder: (context, child) {
        return _scaffold(context);
      },
    );
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: "Ismingizni kiriting",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextFormField(
                controller: context.watch<SignUpProvider>().emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: "Email kiriting",
                ),
              ),
            ),
            TextFormField(
              controller: context.watch<SignUpProvider>().passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: "Parol kiriting",
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
           TextButton(onPressed: (){
              Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
           }, child: Text("Sign In")),
          FloatingActionButton.extended(
              onPressed: () async {
                await context.read<SignUpProvider>().signUp().then((value) {
                  if (value == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                });
              },
              label: !context.watch<SignUpProvider>().isLoading
                  ? const Text("Ro'yhatdan o'tish")
                  : const CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}
