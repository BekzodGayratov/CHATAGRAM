import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseapp/provider/add/add_product_provider.dart';
import 'package:firebaseapp/provider/auth/sign_in_provider.dart';
import 'package:firebaseapp/provider/auth/sign_up_provider.dart';
import 'package:firebaseapp/provider/chat/chat_provider.dart';
import 'package:firebaseapp/provider/home/home_provider.dart';
import 'package:firebaseapp/view/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ChangeNotifierProvider(create: (context) => SignInProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => AddProductProvider()),
      ChangeNotifierProvider(create: (context) => ChatProvider())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScrenn(),
    );
  }
}
