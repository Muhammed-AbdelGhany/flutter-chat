import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/gqNcJmSZ64nKynuVdIOh/messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = snapshot.data.docs;
          return ListView.builder(
            itemBuilder: (ctx, i) => Container(
              margin: EdgeInsets.all(10),
              child: Text(docs[i]['text']),
            ),
            itemCount: docs.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/gqNcJmSZ64nKynuVdIOh/messages')
              .add({'text': 'added'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
