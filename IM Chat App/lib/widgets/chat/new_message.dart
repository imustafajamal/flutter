import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final _currentUsre = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUsre!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': _currentUsre.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
    });
    _enteredMessage = '';
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // gradient: const LinearGradient(colors: [
        //   Color.fromARGB(255, 155, 39, 176),
        //   Color.fromARGB(255, 233, 30, 98)
        // ]),
        color: Colors.purple,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.only(bottom: 2),
      margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Send a message',
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              color: Colors.white,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            )
          ],
        ),
      ),
    );
  }
}
