import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({Key? key, required this.id}) : super(key: key);

  final TextEditingController commentTextController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePost(id);
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: commentController.comments.length,
                  itemBuilder: (context, index) {
                    final data = commentController.comments[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(
                          data.profilePhoto,
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            data.username,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            data.comment,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            tago.format(
                              data.datePuplished.toDate(),
                            ),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Text(
                                data.likes.length.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.favorite,
                                size: 12,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                      trailing: InkWell(
                        onTap: () => commentController.likeComment(data.id),
                        child: Icon(
                          data.likes.contains(authController.user.uid)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 25,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const Divider(),
            ListTile(
              title: TextFormField(
                controller: commentTextController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              trailing: TextButton(
                onPressed: () =>
                    commentController.postComment(commentTextController.text),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
