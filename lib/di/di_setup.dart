import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_clean/data/repository/firebase_auth_repository.dart';
import 'package:pokedex_clean/data/repository/user_account_repository_impl.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';
import 'package:pokedex_clean/domain/repository/user_account_repository.dart';
import 'package:pokedex_clean/domain/use_case/get_user_account_use_case.dart';
import 'package:pokedex_clean/domain/use_case/login_use_case.dart';
import 'package:pokedex_clean/domain/use_case/remove_user_account_use_case.dart';
import 'package:pokedex_clean/presentation/splash/splash_view_model.dart';

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
  //getIt.registerSingleton<RegisterUseCase>(RegisterUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));
  //getIt.registerSingleton<RequestVerifyUseCase>(RequestVerifyUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));
  //getIt.registerSingleton<CheckVerifyUseCase>(CheckVerifyUseCase(authRepository: getIt<AuthRepository<EmailPassword>>()));

  getIt.registerFactory<SplashViewModel>(() => SplashViewModel(
      loginUseCase: getIt<LoginUseCase>(),
      getUserAccountUseCase: getIt<GetUserAccountUseCase>(),
      removeUserAccountUseCase: getIt<RemoveUserAccountUseCase>()));
}
