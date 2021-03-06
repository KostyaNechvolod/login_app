import 'package:meta/meta.dart';

import 'package:flutter/widgets.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginButtonPressed &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          password == other.password;

  @override
  int get hashCode => username.hashCode ^ password.hashCode;

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class GoogleLoginButtonPressed extends LoginEvent {
  @override
  String toString() => 'LoginButtonPressed';
}

class LoggedIn extends LoginEvent {
  @override
  String toString() => 'LoggedIn';
}
