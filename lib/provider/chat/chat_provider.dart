import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/data/remote/chat_service.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider extends ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
      .collection('message')
      .orderBy('created_at')
      .snapshots();

  void writeMessage() async {
    await ChatagramChatService.writeMessage(message: messageController.text);
    messageController.clear();
  }
}
