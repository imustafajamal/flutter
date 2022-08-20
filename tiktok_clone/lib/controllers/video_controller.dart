import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
      firestore.collection('videos').snapshots().map(
        (QuerySnapshot query) {
          List<Video> retVal = [];
          for (var elm in query.docs) {
            retVal.add(Video.fromSnap(elm));
          }
          return retVal;
        },
      ),
    );
  }

  //Likes method

  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    final uid = authController.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
