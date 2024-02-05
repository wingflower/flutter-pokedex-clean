import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:pokedex_clean/core/result.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository<EmailPassword> {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<Result<bool>> login(EmailPassword model) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: model.email, password: model.password);
      if (userCredential.user?.emailVerified ?? false) {
        return const Result.success(true);
      }
      return const Result.success(false);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      if (e.code == 'user-not-found') {
        return const Result.error('유저 정보를 찾을 수 없습니다');
      } else if (e.code == 'wrong-password') {
        return const Result.error('패스워드가 잘못되었습니다');
      } else if (e.code == 'user-disabled') {
        return const Result.error('해당 계정은 사용할 수 없습니다. 관리자에게 문의하세요.');
      }
    }
    return const Result.error('이메일 또는 패스워드를 확인해주세요');
  }

  @override
  Future<Result<void>> register(EmailPassword model) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: model.email, password: model.password);
      if (userCredential.user == null) {
        return const Result.error('가입 실패');
      }
      return const Result.success(null);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('FirebaseAuthException ${e.code}');
      }
      if (e.code == 'weak-password') {
        return const Result.error('패스워드는 최소 6글자 이상으로 등록해야 합니다');
      } else if (e.code == 'email-already-in-use') {
        return const Result.error('해당 계정은 이미 등록되어있습니다');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return const Result.error('가입 실패');
  }

  @override
  Future<Result<void>> logout() async {
    await _firebaseAuth.signOut();
    return const Result.success(null);
  }

  @override
  Future<Result<void>> requestVerify() async {
    if (_firebaseAuth.currentUser == null) {
      return const Result.error('인증 오류');
    }

    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
      return const Result.error('이메일 재전송에 실패했습니다. 잠시 후 다시 시도하세요');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return const Result.error('이메일 재전송에 실패했습니다. 잠시 후 다시 시도하세요');
    }
    return const Result.success(null);
  }

  @override
  Future<Result<bool>> isVerified() async {
    if (_firebaseAuth.currentUser == null) {
      return const Result.error('사용자 정보가 없습니다.');
    }
    await _firebaseAuth.currentUser!.reload();

    return Result.success(_firebaseAuth.currentUser!.emailVerified);
  }

  @override
  Future<Result<void>> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return const Result.error('이메일 형식이 유효하지 않습니다');
      }
      return Result.error(e.code);
    }

    return const Result.success(null);
  }
}
