import 'package:equatable/equatable.dart';

/// This is the primary user model
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  static const empty = User(
    id: '',
    name: '',
    email: '',
    photoUrl: '',
  );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        photoUrl,
      ];

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory User.fromDocument(final doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return User(
      id: doc.id ?? '',
      name: data?['name'] ?? '',
      email: data?['email'] ?? '',
      photoUrl: data?['photoUrl'] ?? '',
    );
  }
}
