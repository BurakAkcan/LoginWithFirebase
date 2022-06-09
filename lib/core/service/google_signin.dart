import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Singleton Kullanımı
class GoogleHelper {
  static GoogleHelper _googleHelper = GoogleHelper._private();

  GoogleHelper._private();
  static GoogleHelper get instance => _googleHelper;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<GoogleSignInAccount?> googleSign() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<GoogleSignInAccount?> googleSignOut() async {
    final user = await _googleSignIn.signOut();
    if (user != null) {
      print(user.email);
    } else {
      print('çıkış');
    }
  }

  Future googleAuthentication() async {
    if (await _googleSignIn.isSignedIn()) {
      final user = _googleSignIn.currentUser;
      final userData = await user?.authentication;
      print(userData!.accessToken);
    }

    return null;
  }

  Future<FirebaseAuth?> firebaseSign() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication gooleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gooleAuth.accessToken, idToken: gooleAuth.idToken);

    final User? user = (await _auth.signInWithCredential(credential)).user;
  }
}
