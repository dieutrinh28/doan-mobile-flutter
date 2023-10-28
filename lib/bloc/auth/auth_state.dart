part of 'auth_bloc.dart';

enum AuthStatus { init, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? accessToken;

  const AuthState({
    required this.status,
    this.accessToken,
  });

  @override
  List<Object?> get props => [];

  AuthState copyWith({
    AuthStatus? status,
    String? accessToken,
  }) {
    return AuthState(
      status: status ?? this.status,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
