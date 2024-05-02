part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSignUp extends AuthEvent {
  const AuthSignUp(this.user);
  final UserModel user;
}

final class AuthSignIn extends AuthEvent {
  const AuthSignIn({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

final class AuthSignOut extends AuthEvent {
  const AuthSignOut();
}
