import 'package:application/bloc/login_event.dart';
import 'package:application/bloc/login_state.dart';
import 'package:application/data/service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService _authenticationService;

  LoginBloc(this._authenticationService) : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      emit(LoginLoading());
      var user =
          await _authenticationService.login(event.email, event.password);
      if (user != null &&
          !_authenticationService.isTokenExpired(user.tokenExpired!)) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure());
      }
    });
  }
}
