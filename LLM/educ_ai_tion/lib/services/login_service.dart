import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:educ_ai_tion/screens/teacher_home_page.dart';
import 'package:educ_ai_tion/screens/student_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateSignedInStatus(String email, bool signedIn) async {
  print("in update stats and email is $email and signedIn will be $signedIn");
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .update({'signedIn': signedIn ? true : false});
  } catch (e) {
    print('Error updating signedIn status: $e');
  }
}
