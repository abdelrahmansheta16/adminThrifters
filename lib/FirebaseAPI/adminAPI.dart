import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminAPI {
  static final _adminInstance = FirebaseFirestore.instance.collection('admins');
  static final _auth = FirebaseAuth.instance;

  static bool login(String email, String password) {
    _adminInstance
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then((QuerySnapshot querySnapshot) =>
            querySnapshot.docs.forEach((admin) {
              if (admin.exists) {
                _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                return true;
              } else {
                return false;
              }
            }));
  }

  static logout() {
    _auth.signOut();
  }
}
