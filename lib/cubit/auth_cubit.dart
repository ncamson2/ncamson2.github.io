import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vildi1/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String? photoUrl,
    required String? shortBio,
    // required bool? isPerformer,
  }) async {
    try {
      final userCredential =
          await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final authUser = userCredential.user!;
      final userId = authUser.uid;

      // If we get here, it succeeded.
      await FirebaseFirestore.instance.doc('users/$userId').set({
        'email': email,
        'name': name,
        'last_name': lastName,
        'photoUrl': photoUrl,
        // 'isPerformer': isPerformer
        // Type of user should be here.
      });

      final vinylUser = User.empty.copyWith(
        email: email,
        name: name,
        photoUrl: photoUrl,
        // isPerformer: isPerformer,
      );

      emit(
        state.copyWith(
          user: vinylUser,
        ),
      );
    } catch (e) {
      print(e);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

/// This will serve as the apps primary fucntion for signing users in. 
  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading));

    print('Running sign up');

    try {
      final userCredential =
          await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final authUser = userCredential.user!;
      final userId = authUser.uid;

      // if (userId.isEmpty) {
      //   emit(state.copyWith(
      //       status: AuthStatus.error, errorMessage: 'UserId empty'));
      //   return;
      // }
      final userDoc =
          await FirebaseFirestore.instance.doc('users/$userId').get();
      final DocumentSnapshot venueDoc =
          await FirebaseFirestore.instance.doc('venues/$userId').get();

      if (userDoc.exists) {
        // Check to make sure the user doc exists. If it doesn't, we should take them to some profile creation screen.

        final name = userDoc.data()?['name'] ?? '';
        // final photoUrl = userDoc.data()?['photoUrl'] ?? '';

        print('NAME :$name');

        final vildiUser = User.fromDocument(userDoc);
        // print(vinylUser.name + '123');
        // If we make it here, no error was thrown, which means it succeeded.
        emit(state.copyWith(user: vildiUser, status: AuthStatus.authenticated));
      }
    } catch (e) {
      emit(
          state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
    if (state.status == AuthStatus.unknown) {
      print('test');
      return;
    }
  }

  @override
  Future<void> logOut() async {
    await auth.FirebaseAuth.instance.signOut();

    emit(state.copyWith(
      status: AuthStatus.unknown,
    ));
  }
}
