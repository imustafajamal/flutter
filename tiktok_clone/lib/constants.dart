import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/add_video_screen.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/views/screens/search_screen.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';

//BOTTOM NAVIGATION BAR SCREENS

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  const Text('Messeges Screen'),
  ProfileScreen(uid: authController.user.uid),
];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = const Color.fromRGBO(233, 51, 83, 1);
const borderColor = Colors.grey;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLER
var authController = AuthController.instance;
