part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class SignInEvent extends AuthEvent {


  @override
  List<Object?> get props => [];
}
