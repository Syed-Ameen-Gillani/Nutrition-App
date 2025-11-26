part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String age;
  final String gender;
  final String dob;
  final String city;

  const AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.age,
    required this.gender,
    required this.dob,
    required this.city,
  });

  @override
  List<Object> get props => [email, password, name, age, gender, dob, city];
}

class AuthLogoutEvent extends AuthEvent {}
