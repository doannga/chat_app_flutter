import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:message_app_flutter/models/user.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  Future signUp(
      {required String email,
      required String password,
      required String name,
      required String phoneNumber}) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? userAuth = result.user;

      AppUser user = AppUser(
              uid: '',
              name: name,
              avatar: '',
              phoneNumber: phoneNumber,
              email: email,
              aboutMe: '')
          .copyWith(
              uid: userAuth?.uid,
              name: name,
              avatar: '',
              phoneNumber: phoneNumber,
              email: email,
              aboutMe: '');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'unknown') {
        print('AppUser not found');
        throw Exception('AppUser is not found.');
      }
      if (e.code == 'AppUser-not-found') {
        print('AppUser not found');
        throw Exception('Wrong email or password for that AppUser');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong email or password for that AppUser');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAppUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleAppUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Future<Map<String, dynamic>?> getUserDetail({required String uid}) async {
  //   final userQuerySnap = await firestore.collection('users').doc(uid).get();
  //   return userQuerySnap.data();
  // }

  Future<AppUser?> getUserDetail({required String? uid}) async {
    Map<String, dynamic>? mapUser;
    final userQuerySnap =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    mapUser = userQuerySnap.data();
    if (mapUser != null) {
      return AppUser.fromMap(mapUser);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getPeopleFromFirebase(
      {required String loginUID}) async {
    final userQuerySnap = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isNotEqualTo: loginUID)
        .get();
    return userQuerySnap.docs
        .map((queryDocSnap) => queryDocSnap.data())
        .toList();
  }

  Future<List<AppUser>> getPeople({required String loginUID}) async {
    final listPeople = await getPeopleFromFirebase(loginUID: loginUID);
    return listPeople.map((peopleMap) => AppUser.fromMap(peopleMap)).toList();
  }
}
