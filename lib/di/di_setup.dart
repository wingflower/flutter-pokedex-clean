import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_clean/data/repository/firebase_auth_repository.dart';
import 'package:pokedex_clean/data/repository/user_account_repository_impl.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';
import 'package:pokedex_clean/domain/repository/user_account_repository.dart';
import 'package:pokedex_clean/domain/use_case/user/check_verify_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/get_user_account_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/login_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/logout_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/register_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/remove_user_account_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/request_verify_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/reset_password_use_case.dart';
import 'package:pokedex_clean/domain/use_case/user/store_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/login/login_view_model.dart';
import 'package:pokedex_clean/presentation/login/reset_password/reset_password_view_model.dart';
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:pokedex_clean/presentation/splash/splash_view_model.dart';
import 'package:pokedex_clean/presentation/verify/verify_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  getIt.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage(aOptions: getAndroidOptions()));

  getIt.registerSingleton<AuthRepository<EmailPassword>>(FirebaseAuthRepository(firebaseAuth: FirebaseAuth.instance));
  getIt.registerSingleton<UserAccountRepository<String, String>>(UserAccountRepositoryImpl(flutterSecureStorage: getIt<FlutterSecureStorage>()));

  getIt.registerSingleton<GetUserAccountUseCase>(GetUserAccountUseCase(userAccountRepository: getIt<UserAccountRepository<String, String>>()));
  getIt.registerSingleton<RemoveUserAccountUseCase>(RemoveUserAccountUseCase(userAccountRepository: getIt<UserAccountRepository<String, String>>()));
  getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));
  getIt.registerSingleton<RequestVerifyUseCase>(RequestVerifyUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));
  getIt.registerSingleton<CheckVerifyUseCase>(CheckVerifyUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));
  getIt.registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));
  getIt.registerSingleton<StoreUserAccountUseCase>(StoreUserAccountUseCase(userAccountRepository: getIt<UserAccountRepository<String, String>>()));
  getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));

  getIt.registerFactory<SplashViewModel>(() => SplashViewModel(
      loginUseCase: getIt<LoginUseCase>(),
      getUserAccountUseCase: getIt<GetUserAccountUseCase>(),
      removeUserAccountUseCase: getIt<RemoveUserAccountUseCase>()));
  getIt.registerFactory<LoginViewModel>(() => LoginViewModel(
      loginUseCase: getIt<LoginUseCase>(), registerUseCase: getIt<RegisterUseCase>(), storeUserAccountUseCase: getIt<StoreUserAccountUseCase>()));
  getIt.registerFactory<VerifyViewModel>(() => VerifyViewModel(
      verifyUseCase: getIt<RequestVerifyUseCase>(),
      checkVerifyUseCase: getIt<CheckVerifyUseCase>(),
      storeUserAccountUseCase: getIt<StoreUserAccountUseCase>()));
  getIt.registerFactory<ResetPasswordViewModel>(() => ResetPasswordViewModel(resetPasswordUseCase: getIt<ResetPasswordUseCase>()));
  getIt.registerFactory<MainViewModel>(() => MainViewModel(logoutUseCase: getIt<LogoutUseCase>(), removeUserAccountUseCase: getIt<RemoveUserAccountUseCase>()));
}
