import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  late File videoFile;
  late String path;

  //method to pick a video
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      videoFile = File(video.path);
      path = video.path;
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ConfirmScreen(video: videoFile, videoPath: path)));
    }
  }

  //Show dailog to choose video source
  showOptionDailog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: buttonColor,
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: const [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Gallery', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera, context),
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Camera', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Cancel', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionDailog(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
            ),
            child: const Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
