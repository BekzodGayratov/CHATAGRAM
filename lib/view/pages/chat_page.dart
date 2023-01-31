import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/helpers/show_message_widget.dart';
import 'package:firebaseapp/provider/chat/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      builder: (context, child) => _scaffold(context),
    );
  }

  Scaffold _scaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Icon(Icons.menu), title: Text("Telegram")),
      body: StreamBuilder(
          stream: context.read<ChatProvider>().productStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              List<Map<String, dynamic>> data = [];

              snapshot.data!.docs.map((DocumentSnapshot document) {
                data.add(document.data() as Map<String, dynamic>);
              }).toList();
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: data[index]['token'] ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child: Text(
                            data[index]['message'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              );
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 9,
                  child: TextFormField(
                    controller: context.watch<ChatProvider>().messageController,
                    decoration: InputDecoration(
                        hintText: "Write message",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  )),
              Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {
                        context.read<ChatProvider>().writeMessage();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
