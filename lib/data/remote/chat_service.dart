import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/helpers/show_message_widget.dart';

class ChatagramChatService {
  static CollectionReference messageCollection =
      FirebaseFirestore.instance.collection("message");

  static Future<void> writeMessage({required String message}) async {
    try {
      await messageCollection.add({
        "message": message,
        "token": FirebaseAuth.instance.currentUser!.uid,
        "created_at": FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      showErrorMessage(e.message.toString());
    }
  }
}
