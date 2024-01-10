import 'package:firebase_auth/firebase_auth.dart';

Map<String, dynamic> getCurrentUserData() {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // User is logged in, extract user data into a map
    Map<String, dynamic> userData = {
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      // Add more fields as needed
    };

    return userData;
  } else {
    // User is not logged in
    return {};
  }
}
