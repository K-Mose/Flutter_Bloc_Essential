import 'package:fb_auth/constatns/db_constants.dart';
import 'package:fb_auth/models/custom_error.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:cloud_firestore/cloud_firestore.dart';

// Repository가 수행하는 활동을 생각하고 작성
/// AuthRepository
/// Firebase와 연동하여 회원가입, 로그인, 로그아웃을 수행
/// 회원가입한 정보를 FireStore에 저장
class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;

  const AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  // User 상태 정보를 Stream으로 알려줌
  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  Future<void> signup ({
    required String name,
    required String email,
    required String password
  }) async {
    try {
      print("signup1:: $name / $email / $password");
      final fbAuth.UserCredential userCredential =
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      print("signup2: $userCredential");
      // 로그인 성공 시 user 값은 not null
      final signedInUser = userCredential.user!;
      // 로그인 유저 정보 저장
      await usersRef.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        'profileImage': 'https://picsum.photos/123',
        'point': 0,
        'rank': 'bronze'
      });
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error'
      );
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
          code: e.code,
          message: e.message!,
          plugin: e.plugin
      );
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error'
      );
    }
  }

  Future<void> signout() async {
    try {
      await firebaseAuth.signOut();
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
          code: e.code,
          message: e.message!,
          plugin: e.plugin
      );
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error'
      );
    }
  }
}