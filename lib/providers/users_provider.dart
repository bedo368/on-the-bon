import 'package:flutter/material.dart';
import 'package:on_the_bon/type/types.dart';

class Users with ChangeNotifier {
  final UserList _users = {};

  get users {
    return {..._users};
  }
}
