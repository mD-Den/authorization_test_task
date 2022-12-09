import 'package:authorization_test_task/data/repositories/auth_repository.dart';
import 'package:authorization_test_task/logic/form_submission_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/login_bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: AuthRepository(),
        ),
        child: _loginForm(),
      ),
    );
  }

  Widget _loginForm() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _loginField(),
                _passwordField(),
                _loginButton(),
                _registrationButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _loginField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.person,
            ),
            hintText: 'Username',
          ),
          validator: (value) =>
              state.isValidUsername ? 'Username is too short' : null,
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginUsernameChangedEvent(username: value),
              ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.security,
            ),
            hintText: 'Password',
          ),
          validator: (value) =>
              state.isValidPassword ? 'Password is too short' : null,
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginPasswordChangedEvent(password: value),
              ),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const Padding(
                padding: EdgeInsets.only(top: 40),
                child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        state.isRegistration) {
                      context
                          .read<LoginBloc>()
                          .add(LoginRegistrationEvent(context));
                    } else if (_formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginCheckEvent(context));
                    }
                  },
                  child: Text(
                    state.isRegistration ? 'Registration' : 'Login',
                  ),
                ),
              );
      },
    );
  }

  Widget _registrationButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.isRegistration || state.formStatus is FormSubmitting
            ? Container()
            : TextButton(
                onPressed: () async {
                  context
                      .read<LoginBloc>()
                      .add(LoginSwitchingToRegistration(true));
                },
                child: const Text(
                  'Don\'t have an account? Register now!',
                ),
              );
      },
    );
  }
}
