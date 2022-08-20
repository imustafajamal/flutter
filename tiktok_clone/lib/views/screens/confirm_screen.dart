import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key, required this.video, required this.videoPath})
      : super(key: key);
  final File video;
  final String videoPath;

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  UplaodVideoController uplaodVideoController =
      Get.put(UplaodVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.video);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: VideoPlayer(controller),
          ),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextInputField(
                    textEditingController: _songController,
                    lable: 'Song Name',
                    icon: Icons.music_note,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width - 20,
                  child: TextInputField(
                    textEditingController: _captionController,
                    lable: 'Caption',
                    icon: Icons.closed_caption,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => uplaodVideoController.uploadVideo(
                      _songController.text,
                      _captionController.text,
                      widget.videoPath),
                  child: const Text(
                    'Share!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
