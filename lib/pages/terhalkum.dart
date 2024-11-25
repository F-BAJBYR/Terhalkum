import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:terhalkum/Controller/user_dashboard.dart';
import 'terhalkum.dart';


// Firestore instance
FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> login(BuildContext context, TextEditingController emailController, TextEditingController passwordController) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // If login is successful, store user data in Firestore
    firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': userCredential.user!.email,
      'lastLogin': DateTime.now(),
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login Successful')),
    );

    // Navigate to TerhAlkM screen after login
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TrhAlkM()),  // Navigate to Trhalkum
      );
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided.';
    } else {
      errorMessage = 'Something went wrong. Please try again.';
    }
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }
}
