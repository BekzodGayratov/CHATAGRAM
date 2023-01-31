import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/helpers/show_message_widget.dart';
import 'package:firebaseapp/provider/home/home_provider.dart';
import 'package:firebaseapp/view/screens/add_product_screen.dart';
import 'package:firebaseapp/view/screens/chat_screen.dart';
import 'package:firebaseapp/view/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello Home')),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
           BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat")
        ],
        onTap: (v) {
          setState(() {
            _currentIndex = v.toInt();
          });
        },
      ),
    );
  }

  List<Widget> _screens = [
    MainScreen(),
    AddProductScreen(),
    ChatScreen()
  ];
}
