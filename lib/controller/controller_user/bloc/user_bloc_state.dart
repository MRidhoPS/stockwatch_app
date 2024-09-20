part of 'user_bloc_bloc.dart';

sealed class UserBlocState extends Equatable {
  const UserBlocState();
  
  @override
  List<Object> get props => [];
}

final class UserBlocInitial extends UserBlocState {}

class UserBlocLoading extends UserBlocState {}

class UserBlocLoaded extends UserBlocState {
  final User user;

  const UserBlocLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserBlocError extends UserBlocState {
  final String message;

  const UserBlocError(this.message);

  @override
  List<Object> get props => [message];
}
