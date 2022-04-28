import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:im_chat_app/widgets/chat/messages.dart';
import 'package:im_chat_app/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  get flase => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [Colors.purple, Colors.pink],
      //     tileMode: TileMode.clamp,
      //     begin: Alignment.topRight,
      //     end: Alignment.bottomLeft,
      //   ),
      // ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'IM Chat',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
          actions: [
            DropdownButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  child: Row(children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.pink,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout')
                  ]),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
        body: Container(
          color: Color.fromARGB(131, 253, 193, 229),
          child: Column(
            children: const [
              Expanded(
                child: Messsages(),
              ),
              NewMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
