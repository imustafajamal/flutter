import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UplaodVideoController extends GetxController {
  static UplaodVideoController instace = Get.find();
  //Compress Video file
  _compressVideo(String vPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      vPath,
      quality: VideoQuality.MediumQuality,
    );

    return compressedVideo!.file;
  }

  //uploading...
  Future<String> _uploadVideoToStorage(String id, String path) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(path));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //get thumnail image from video

  _getThumbnial(String videoPath) async {
    final thumbnial = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnial;
  }

  //upload thumbnail method
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnial(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //upload video method
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      //get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnailUrl =
          await _uploadImageToStorage("Video $len", videoPath);
      Video video = Video(
          userName: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: "Video $len",
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnial: thumbnailUrl,
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)['profilePhoto']);
      await firestore
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar('An error Occoured', e.toString());
    }
  }
}
