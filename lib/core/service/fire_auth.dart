import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyAuthServices {
  static MyAuthServices _instance = MyAuthServices._private();

  MyAuthServices._private();
  static MyAuthServices get instance => _instance;

  registerWithEmail(
      {required String mail,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: mail, password: password);
      print("Kullanıcı kaydedildi");
    } on FirebaseAuthException catch (e) {
      if (e.code == "week-password") {
        print("Girdiğiniz şifre zayıf");
      } else if (e.code == "email-already-in-use") {
        print("Bu e mail kullanılıyor");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Bu e mail kullanılıyor"),
        ));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<User?> signWithEmail(
      {required String mail, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: mail, password: password);
      print("Kullanıcı giriş yaptı");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Girdiğiniz bilgilerle eşleşen kullanıcı bulunamadı");
      } else if (e.code == "wrong-password") {
        print("Yanlış şifre girdiniz");
      }
    }
  }

  passwordResetWithMail({required String mail}) async {
    try {
      await _auth.sendPasswordResetEmail(email: mail);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserCredential> signWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }
}
