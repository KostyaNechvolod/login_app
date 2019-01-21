import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_app/user_repository.dart';

import 'package:login_app/bloc/authentication/autentication.dart';
import 'package:login_app/page/splash_screen.dart';
import 'package:login_app/page/login_screen.dart';
import 'package:login_app/page/home_screen.dart';
import 'package:login_app/widget/loading_indicator.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStart());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            List<Widget> widgets = [];

            if (state.isAuthenticated) {
              widgets.add(MyHomePage());
            } else {
              widgets.add(LoginPage(userRepository: _userRepository));
            }

            if (state.isInitializing) {
              widgets.add(SplashPage());
            }

            if (state.isLoading) {
              widgets.add(LoadingIndicator());
            }

            return Stack(
              children: widgets,
            );
          },
        ),
      ),
    );
  }
}
