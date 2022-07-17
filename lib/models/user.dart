import 'dart:convert';

import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String name;
  final String avatar;
  final String phoneNumber;
  final String email;
  final String aboutMe;

  const AppUser(
      {required this.uid,
      required this.name,
      required this.avatar,
      required this.phoneNumber,
      required this.email,
      required this.aboutMe});
  AppUser copyWith(
      {String? uid,
      String? name,
      String? avatar,
      String? phoneNumber,
      String? email,
      String? aboutMe}) {
    return AppUser(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        aboutMe: aboutMe ?? this.aboutMe);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'avatar': avatar,
      'phoneNumber': phoneNumber,
      'email': email,
      'aboutMe': aboutMe,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        uid: map['uid']?.toString() ?? '',
        name: map['name']?.toString() ?? '',
        avatar: map['avatar']?.toString() ?? '',
        phoneNumber: map['phoneNumber']?.toString() ?? '',
        email: map['email']?.toString() ?? '',
        aboutMe: map['aboutMe']?.toString() ?? '');
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) {
    return AppUser.fromMap(json.encode(source) as Map<String, dynamic>);
  }

  @override
  String toString() {
    return 'AppUser(uid: $uid, name: $name, avatar: $avatar, phoneNumber: $phoneNumber, email: $email, aboutMe: $aboutMe)';
  }

  @override
  List<Object> get props => [uid, name, avatar, phoneNumber, email, aboutMe];
}
