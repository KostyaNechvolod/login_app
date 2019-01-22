import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:login_app/user_repository.dart';

import 'package:login_app/bloc/login/login.dart';
import 'package:login_app/bloc/auth_methods.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({@required this.userRepository}) : assert(userRepository != null);

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(
    LoginState currentState,
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginState.loading();

      try {
        final token = await userRepository.authenticate(
            username: event.username,
            password: event.password,
            authMethod: AuthMethod.EMAIL_PASSWORD);

        yield LoginState.success(token);
      } catch (error) {
        yield LoginState.failure(error.toString());
      }
    }

    if (event is GoogleLoginButtonPressed) {
      yield LoginState.loading();

      try {
        final token = await userRepository.authenticate(
            username: '', password: '', authMethod: AuthMethod.GOOGLE);

        yield LoginState.success(token);
      } catch (error) {
        yield LoginState.failure(error.toString());
      }
    }

    if (event is LoggedIn) {
      yield LoginState.initial();
    }
  }
}
