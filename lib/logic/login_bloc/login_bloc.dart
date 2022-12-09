import 'dart:async';

import 'package:authorization_test_task/data/models/login_request_model.dart';
import 'package:authorization_test_task/data/models/register_request_model.dart';
import 'package:authorization_test_task/data/repositories/auth_repository.dart';
import 'package:authorization_test_task/services/api_service.dart';
import 'package:authorization_test_task/ui/pages/picture_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../data/local_data_store/local_data_store.dart';
import '../../ui/pages/login_page.dart';
import '../form_submission_status.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepository}) : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

  final AuthRepository authRepository;

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    await LocalDataStore.init();

    if (event is LoginUsernameChangedEvent) {
      emit(state.copyWith(username: event.username));
    } else if (event is LoginPasswordChangedEvent) {
      emit(state.copyWith(password: event.password));
    } else if (event is LoginCheckEvent) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      //real
      LoginRequestModel model =
          LoginRequestModel(username: state.username, password: state.password);
      try {
        APIService.login(model).then((response) {
          if (response) {
            emit(state.copyWith(formStatus: SubmissionSuccess()));
            Navigator.of(event.context).push(MaterialPageRoute(
                builder: (context) =>
                    const PicturePage(isSuccessfulEntry: true)));
          }
        });

        //imitation
        bool successfulEnter = await authRepository.login(
            state.username, state.password, event.context);
        if (successfulEnter) {
          Navigator.of(event.context).push(MaterialPageRoute(
              builder: (context) =>
                  const PicturePage(isSuccessfulEntry: true)));
        } else {
          Navigator.of(event.context).push(MaterialPageRoute(
              builder: (context) =>
                  const PicturePage(isSuccessfulEntry: false)));
        }
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
        Navigator.of(event.context).push(MaterialPageRoute(
            builder: (context) => const PicturePage(isSuccessfulEntry: false)));
      }
    } else if (event is LoginRegistrationEvent) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      //real
      RegisterRequestModel model = RegisterRequestModel(
          username: state.username, password: state.password);

      try {
        APIService.register(model).then((response) {
          if (response.token != null) {
            emit(state.copyWith(formStatus: SubmissionSuccess()));
            const snackBar = SnackBar(
                content: Text('Register Successful! Pls login to the account'));
            ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
            Navigator.of(event.context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          }
        });

        //imitation
        bool successfulRegister = await authRepository.register(
            state.username, state.password, event.context);
        if (successfulRegister) {
          const snackBar = SnackBar(
              content: Text('Register Successful! Pls login to the account'));
          ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
          Navigator.of(event.context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          const snackBar = SnackBar(
              content: Text('The user with this login already exists'));
          ScaffoldMessenger.of(event.context).showSnackBar(snackBar);
        }
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    } else if (event is LoginSwitchingToRegistrationEvent) {
      emit(state.copyWith(isRegistration: event.isRegistration));
    }
  }
}
