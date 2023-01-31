import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/helpers/show_message_widget.dart';
import 'package:firebaseapp/provider/chat/chat_provider.dart';
import 'package:firebaseapp/view/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage()));
        },
        child: Text("Chatga o'tish"));
  }
}
