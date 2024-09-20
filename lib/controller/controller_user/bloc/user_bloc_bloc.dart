import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stockwatch_app/controller/controller_user/user_controller.dart';

import '../../../model/user_model.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UserBlocBloc extends Bloc<UserBlocEvent, UserBlocState> {
  UserBlocBloc() : super(UserBlocInitial()) {
    on<LoginUser>(_onLoginUser);
    on<RegisterUser>(_onRegisterUser);
  }
  Future<void> _onLoginUser(
      LoginUser event, Emitter<UserBlocState> emit) async {
    emit(UserBlocLoading());
    try {
      final user = await UserServices().loginUser(event.email, event.password);
      emit(UserBlocLoaded(user));
    } catch (e) {
      emit(UserBlocError(e.toString()));
    }
  }

  Future<void> _onRegisterUser(RegisterUser event, Emitter<UserBlocState> emit) async{
    emit(UserBlocLoading());
    try {
      final user = await UserServices().register(event.username, event.email, event.password);
      emit(UserBlocLoaded(user));
    } catch (e) {
      emit(UserBlocError(e.toString()));
    }
  }
}
