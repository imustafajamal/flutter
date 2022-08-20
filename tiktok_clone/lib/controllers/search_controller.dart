import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _serachedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _serachedUsers.value;

  searchUser(String typeUser) async {
    try {
      if (typeUser.isNotEmpty) {
        _serachedUsers.bindStream(
          firestore
              .collection('users')
              .where('name', isGreaterThanOrEqualTo: typeUser)
              .snapshots()
              .map((QuerySnapshot qeury) {
            List<User> retValue = [];
            for (var elem in qeury.docs) {
              retValue.add(
                User.fromSnap(elem),
              );
            }
            return retValue;
          }),
        );
      }
    } catch (e) {
      Get.snackbar('Error!', e.toString());
    }
  }
}
