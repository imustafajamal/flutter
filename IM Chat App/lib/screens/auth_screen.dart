import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:im_chat_app/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String userName,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .catchError((error) {
          if (error != null) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                content: Text(error.message),
                backgroundColor: const Color.fromARGB(192, 255, 228, 228),
              ),
            );
          }
        });
      } else {
        authResult = await _auth
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .catchError((error) {
          if (error != null) {
            ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(
                content: Text(
                  error.message,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: const Color.fromARGB(192, 255, 228, 228),
              ),
            );
          }
        });
        if (!isLogin) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child(authResult.user!.uid + '.jpg');

          await ref.putFile(image!);
          final url = await ref.getDownloadURL();

          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user!.uid)
              .set({
            'username': userName,
            'email': email,
            'image_url': url,
          });
        }
      }
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
