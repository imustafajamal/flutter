import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  //Getter to get profile photo

  File? get profilePic => _pickedImage.value;

  User get user => _user.value!;

  //pick image
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      Get.snackbar('Image Picked', 'You have select your profile pic');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload image to firebase storage
  Future<String> _uploadProfileImage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  //register new user
  void registerUser(
      String userName, String email, String password, File? image) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadProfileImage(image);

        model.User user = model.User(
          name: userName,
          email: email,
          profilePhoto: downloadUrl,
          uid: cred.user!.uid,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error Creating Account', 'Please Enter all data');
      }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  //log in user
  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar(
            'Error Logging in', 'Please check your email and password');
      }
    } catch (e) {
      Get.snackbar('Error Logging in', e.toString());
    }
  }

  //sign out
  void signOut() async {
    await firebaseAuth.signOut();
  }
}
