import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth/constatns/db_constants.dart';
import 'package:fb_auth/models/custom_error.dart';
import 'package:fb_auth/models/user.dart';

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;

  const ProfileRepository({
    required this.firebaseFirestore,
  });

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();
      print("getProfile:: ${userDoc.id}");
      print("getProfile:: ${userDoc.exists}");
      print("getProfile:: ${userDoc.get('email')}");
      print("getProfile:: ${userDoc.get('name')}");
      print("getProfile:: ${userDoc.get('point')}");
      print("getProfile:: ${userDoc.get('profileImage')}");
      print("getProfile:: ${userDoc.get('rank')}");
      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }

      throw 'UserNotFound';
    } on FirebaseException catch(e) {
      throw CustomError(
          code: e.code,
          message: e.message!,
          plugin: e.plugin
      );
    } catch(e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error'
      );
    }
  }
}