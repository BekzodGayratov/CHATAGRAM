import 'package:firebaseapp/provider/auth/sign_in_provider.dart';
import 'package:firebaseapp/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInProvider(),
      builder: (context, child) {
        return _scaffold(context);
      },
    );
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SignIn page")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextFormField(
              controller: context.watch<SignInProvider>().emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                hintText: "Email kiriting",
              ),
            ),
          ),
          TextFormField(
            controller: context.watch<SignInProvider>().passwordController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              hintText: "Parol kiriting",
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await context.read<SignInProvider>().signIn().then((value) {
              if (value == true) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            });
          },
          label: !context.watch<SignInProvider>().isLoading
              ? const Text("Ro'yhatdan o'tish")
              : const CircularProgressIndicator.adaptive()),
    );
  }
}
