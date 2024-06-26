import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int point;
  final String rank;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>? ?? {};
    print("User.fromDoc:: $userData}");
    return User(
      id: userDoc.id,
      name: userData['name'],
      email: userData['email'],
      profileImage: userData['profileImage'],
      point: userData['point'],
      rank: userData['rank']
    );
  }

  factory User.initial() {
    return const User(
      id: '',
      name: '',
      email: '',
      profileImage: '',
      point: -1,
      rank: '',
    );
  }

  @override
  List<Object> get props => [id, name, email, profileImage, point, rank];

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, profileImage: $profileImage, point: $point, rank: $rank}';
  }
}