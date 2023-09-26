part of 'auth_cubit.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;

  final String errorMessage;
  // put a bool here that you can carry through state ...

  const AuthState({
    required this.status,
    required this.user,
    required this.errorMessage,
  });

  factory AuthState.initial() {
    return const AuthState(
      user: User.empty,
      status: AuthStatus.unknown,
      errorMessage: '',
    );
  }

  @override
  List<Object?> get props => [
        user,
        status,
        errorMessage,
      ];

  AuthState copyWith({
    User? user,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
