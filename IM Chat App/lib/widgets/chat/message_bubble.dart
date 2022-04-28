import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String imageUrl;
  final bool isMe;
  final Key? key;

  MessageBubble(
    this.message,
    this.userName,
    this.imageUrl,
    this.isMe, {
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
              decoration: BoxDecoration(
                // gradient: const LinearGradient(
                //   colors: [
                //     Color.fromARGB(255, 155, 39, 176),
                //     Color.fromARGB(255, 233, 30, 98)
                //   ],
                //   tileMode: TileMode.clamp,
                //   begin: Alignment.topRight,
                //   end: Alignment.bottomLeft,
                // ),
                color: !isMe ? Colors.pink : Colors.purple,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe ? Radius.zero : const Radius.circular(12),
                  bottomRight: isMe ? Radius.zero : const Radius.circular(12),
                ),
                border: Border.all(
                    width: 2, color: Color.fromARGB(255, 255, 255, 255)),
              ),
              width: 200,
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(162, 255, 255, 255),
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 180,
          right: isMe ? 180 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
