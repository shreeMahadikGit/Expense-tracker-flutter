import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/provider/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      var user = FirebaseAuth.instance.currentUser!;
      await initalize(user.uid);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  initalize(var uid) async {
    await FirebaseFirestore.instance
        .collection('expenses')
        .doc(uid)
        .collection('transactions')
        .doc('transactions')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
      } else {
          await SetTransaction(
          uid: uid,
          t_name: 't_name',
          t_amt: '0',
          isIncome: true,
          Category: 'Any'
          );
      }
    });
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
