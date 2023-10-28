import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/service/auth_firebase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(status: AuthStatus.init)) {
    on<SignInEvent>((event, emit) async {
      final GoogleAuth googleAuth = GoogleAuth();
      final UserCredential? userCredential = await googleAuth.signInWithGoogle();
      if (userCredential != null) {
        final accessToken = await googleAuth.getAccessToken();
        print('accessToken: $accessToken');
        emit(state.copyWith(status: AuthStatus.authenticated, accessToken: accessToken));
      }
      else {
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    });
  }
}
