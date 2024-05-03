import 'package:application/bloc/auth_event.dart';
import 'package:application/bloc/auth_state.dart';
import 'package:application/data/service/auth_service.dart';
import 'package:bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInEvent) {
      yield AuthLoading();
      try {
        final String token =
            await authService.signIn(event.email, event.password);
        yield AuthSuccess(token);
      } catch (e) {
        yield AuthError(e.toString());
      }
    }
  }
}
