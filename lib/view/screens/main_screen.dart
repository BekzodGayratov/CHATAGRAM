import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseapp/helpers/show_message_widget.dart';
import 'package:firebaseapp/provider/home/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: context.read<HomeProvider>().productStream,
      builder: (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("SERVER ERROR"),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<Map<String, dynamic>> data = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            data.add(document.data() as Map<String, dynamic>);
          }).toList();
          if (data.isEmpty) {
            return const Center(
              child: Text("HALI MAHSULOTLAR QO'SHILMAGAN"),
            );
          } else {
            return PageView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(
                                  data[index]['image'].toString()))),
                    ),
                    Text(data[index]['title']),
                    Text(data[index]['desc'])
                  ],
                );
              },
              itemCount: data.length,
            );
          }
        }
      },
    );
  }
}
