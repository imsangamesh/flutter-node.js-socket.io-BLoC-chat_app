import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/auth/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(const AuthInitial()) {
    //
    on<AuthEvent>((event, emit) => emit(const AuthLoading()));
    on<AuthSignUp>(_onSignUp);
    on<AuthSignIn>(_onSignIn);
    on<AuthSignOut>(_onSignOut);
  }

  final AuthRepo _authRepo;

  /// - - - - - - - - - - - - - - - - - - - - - - - - - - - -  `GETTERS`

  UserModel? get user => _authRepo.user;

  /// - - - - - - - - - - - - - - - - - - - - - - - - - - - -  `METHODS`

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final result = await _authRepo.signUp(event.user);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (r) => emit(const AuthSuccess()),
    );
  }

  Future<void> _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final result = await _authRepo.signIn(event.email, event.password);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (r) => emit(const AuthSuccess()),
    );
  }

  Future<void> _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    final result = await _authRepo.signOut();

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (r) => emit(const AuthSuccess()),
    );
  }
}
