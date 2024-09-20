part of 'user_bloc_bloc.dart';

sealed class UserBlocEvent extends Equatable {
  const UserBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends UserBlocEvent {
  final String email;
  final String password;

  const LoginUser({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}


class RegisterUser extends UserBlocEvent {
  final String username;
  final String email;
  final String password;

  const RegisterUser(
      {required this.username, required this.email, required this.password});

  @override
  List<Object> get props => [username, email, password];
}
