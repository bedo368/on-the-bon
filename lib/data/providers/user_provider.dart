import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  final String id;
  final String name;
  final String email;
  final bool isAdmin;
  final String? phone;
  final String? photo;
  UserData({
    required this.id,
    required this.email,
    required this.isAdmin,
    required this.name,
    required this.phone,
    required this.photo,
  });
}
