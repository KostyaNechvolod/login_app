import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_app/user_repository.dart';

import 'package:login_app/bloc/authentication/autentication.dart';
import 'package:login_app/bloc/login/login.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc(userRepository: widget.userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginScreen(
        authBloc: BlocProvider.of<AuthenticationBloc>(context),
        loginBloc: _loginBloc,
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}

/////////////////////////////////////

class LoginScreen extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authBloc;

  LoginScreen({
    Key key,
    @required this.loginBloc,
    @required this.authBloc,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum FormMode { SIGNIN, SIGNUP }

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  FormMode _formMode = FormMode.SIGNIN;
  final formKey = new GlobalKey<FormState>();
  bool _obscureText = true;
  bool _showProgress = false;

  void _signUp() {
    formKey.currentState.reset();
    setState(() {
      _formMode = FormMode.SIGNIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: widget.loginBloc,
      builder: (
        BuildContext context,
        LoginState loginState,
      ) {
        if (_loginSucceeded(loginState)) {
          widget.authBloc.dispatch(Login(token: loginState.token));
          widget.loginBloc.dispatch(LoggedIn());
        }

        if (_loginFailed(loginState)) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${loginState.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return _form(loginState);
      },
    );
  }

  Widget _form(LoginState loginstate) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[200],
      body: Container(
//        padding: EdgeInsets.all(8.0),
        child: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.all(8.0),
//              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 50.0),
                _logo(),
                SizedBox(height: 80.0),
                _emailInput(_usernameController),
                SizedBox(height: 10.0),
                _passwordInput(_passwordController),
                SizedBox(height: 5.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _submitGoogleButton(context, loginstate),
                    SizedBox(
                      width: 8.0,
                    ),
                    _submitButton(context, loginstate),
                  ],
                ),
                _label()
              ],
            )),
      ),
    );
  }

  bool _loginSucceeded(LoginState state) => state.token.isNotEmpty;

  bool _loginFailed(LoginState state) => state.error.isNotEmpty;

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget _logo() {
    return Hero(
      tag: 'hero',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 190.0,
              height: 190.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/blank-profile-picture.png')))),
        ],
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  Widget _emailInput(TextEditingController usernameController) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: usernameController,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: true,
          fillColor: Colors.grey[400],
          hintText: 'Email',
          icon: Icon(
            Icons.mail,
            color: Colors.black87,
          )),
      validator: validateEmail,
    );
  }

  Widget _passwordInput(TextEditingController passwordController) {
    return TextFormField(
      validator: (value) {
        if (value.length < 6) {
          return 'Password must be longer than 6 symbols!';
        }
      },
      obscureText: _obscureText,
      controller: passwordController,
      autofocus: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: true,
          fillColor: Colors.grey[400],
          hintText: 'Password',
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            color: _obscureText ? Colors.black87 : Colors.blue,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          icon: Icon(Icons.lock, color: Colors.black87)),
    );
  }

  Widget _submitGoogleButton(BuildContext context, LoginState loginState) {
    if (_formMode == FormMode.SIGNIN) {
      return RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.red,
          child: Text(
            'Login with Google',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: () {
            loginState.isLoginButtonEnabled
                ? _onGoogleLoginButtonPressed()
                : null;
          });
    }
  }

  Widget _submitButton(BuildContext context, LoginState loginState) {
    if (_formMode == FormMode.SIGNIN) {
      return RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: () {
            if (formKey.currentState.validate()) {
              setState(() {
                loginState.isLoginButtonEnabled
                    ? _onLoginButtonPressed()
                    : null;
              });
            }
          });
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: Text(
            'Sign up',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: () {
            formKey.currentState.validate();
          },
        ),
      );
    }
  }

  Widget _label() {
    if (_formMode == FormMode.SIGNIN) {
      return Column(
        children: <Widget>[
          Container(
            child: FlatButton(
              child: Text('Don\'t have an account? Sign up',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300)),
              onPressed: () {},
            ),
            height: 30.0,
          ),
          Container(
            child: FlatButton(
              child: Text('Forgot password?',
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300)),
              onPressed: () {},
            ),
            height: 30.0,
          ),
        ],
      );
    } else {
      return FlatButton(
        child: Text('Have an account? Sign in',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: _signUp,
      );
    }
  }

  _onLoginButtonPressed() {
    widget.loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }

  _onGoogleLoginButtonPressed() async {
    widget.loginBloc.dispatch(GoogleLoginButtonPressed());
  }
}
