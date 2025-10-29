import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nutrovite/features/auth/repositories/auth_repository.dart';
import '../../models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthRegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userModel = await authRepository.createUser(
          name: event.name,
          email: event.email,
          password: event.password,
          age: event.age,
          gender: event.gender,
          dob: event.dob,
          city: event.city,
        );
        emit(AuthAuthenticated(userModel));
      } catch (e) {
        emit(AuthError('Registration failed: ${e.toString()}'));
      }
    });

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userModel = await authRepository.signin(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(userModel));
      } catch (e) {
        emit(AuthError('Login failed: ${e.toString()}'));
      }
    });

    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signOut();
        emit(AuthUnauthenticated());
      } catch (e) {
        emit(AuthError('Logout failed: ${e.toString()}'));
      }
    });
  }
}
