import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/video_controller.dart';
import 'package:tiktok_clone/views/screens/comment_screen.dart';
import 'package:tiktok_clone/views/widgets/circle_animation.dart';
import 'package:get/get.dart';

import '../widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);
  final VideoController videoController = Get.put(VideoController());

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            itemCount: videoController.videoList.length,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 1,
            ),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  VideoPlayerItem(
                      videoUrl: videoController.videoList[index].videoUrl),
                  Column(
                    children: [
                      const SizedBox(height: 200),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      videoController.videoList[index].userName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      videoController.videoList[index].caption,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.music_note,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          videoController
                                              .videoList[index].songName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildProfile(videoController
                                      .videoList[index].profilePhoto),
                                  const SizedBox(height: 15),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () => videoController.likeVideo(
                                            videoController
                                                .videoList[index].id),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 35,
                                          color: videoController
                                                  .videoList[index].likes
                                                  .contains(
                                                      authController.user.uid)
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        videoController
                                            .videoList[index].likes.length
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => CommentScreen(
                                                id: videoController
                                                    .videoList[index].id),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.comment,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        videoController
                                            .videoList[index].commentCount
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                          'assets/icons/share.png',
                                          width: 37,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                      Text(
                                        videoController
                                            .videoList[index].shareCount
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  CircleAnimation(
                                    child: buildMusicAlbum(videoController
                                        .videoList[index].profilePhoto),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            });
      }),
    );
  }
}
