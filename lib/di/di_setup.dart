import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_clean/app_timer.dart';
import 'package:pokedex_clean/data/data_source/local/user_account_storage.dart';
import 'package:pokedex_clean/data/data_source/remote/pokemon_api.dart';
import 'package:pokedex_clean/data/data_source/remote/type_api.dart';
import 'package:pokedex_clean/data/repository/firebase_auth_repository.dart';
import 'package:pokedex_clean/data/repository/firestore_user_info_repository.dart';
import 'package:pokedex_clean/data/repository/pokemon_repository_impl.dart';
import 'package:pokedex_clean/data/repository/type_repository_impl.dart';
import 'package:pokedex_clean/data/repository/user_account_repository_impl.dart';
import 'package:pokedex_clean/domain/model/email_password.dart';
import 'package:pokedex_clean/domain/repository/auth_repository.dart';
import 'package:pokedex_clean/domain/repository/pokemon_repository.dart';
import 'package:pokedex_clean/domain/repository/type_repository.dart';
import 'package:pokedex_clean/domain/repository/user_account_repository.dart';
import 'package:pokedex_clean/domain/repository/user_info_repository.dart';
import 'package:pokedex_clean/domain/use_case/collection/draw_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/collection/get_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/collection/refresh_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/collection/search_by_name_pokemon_use_case.dart';
import 'package:pokedex_clean/domain/use_case/collection/sort_pokemon_list_use_case.dart';
import 'package:pokedex_clean/domain/use_case/info/add_and_update_user_info_use_case.dart';
import 'package:pokedex_clean/domain/use_case/info/get_user_info_use_case.dart';
import 'package:pokedex_clean/domain/use_case/type/get_type_use_case.dart';
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
import 'package:pokedex_clean/presentation/main/main_view_model.dart';
import 'package:pokedex_clean/presentation/main/roulette/roulette_view_model.dart';
import 'package:pokedex_clean/presentation/splash/splash_view_model.dart';

final getIt = GetIt.instance;

void diSetup() {
  // ============================================================
  // ETC Declaration START >>>
  // ============================================================
  AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  getIt.registerSingleton<FlutterSecureStorage>(
    FlutterSecureStorage(
      aOptions: getAndroidOptions(),
    ),
  );
  // ============================================================
  //                                      <<< ETC Declaration END
  // ============================================================

  // ============================================================
  // DATA Declaration START >>>
  // ============================================================
  getIt.registerSingleton<PokemonApi>(
    PokemonApi(),
  );
  getIt.registerSingleton<TypeApi>(
    TypeApi(),
  );
  getIt.registerSingleton<UserAccountStorage>(
    UserAccountStorage(flutterSecureStorage: getIt<FlutterSecureStorage>()),
  );
  // ============================================================
  //                                     <<< DATA Declaration END
  // ============================================================

  // ============================================================
  // REPOSITORIES Declaration START >>>
  // ============================================================
  getIt.registerSingleton<AuthRepository<EmailPassword>>(
    FirebaseAuthRepository(firebaseAuth: FirebaseAuth.instance),
  );
  getIt.registerSingleton<UserAccountRepository<String, String>>(
    UserAccountRepositoryImpl(
      userAccountStorage: getIt<UserAccountStorage>(),
    ),
  );
  getIt.registerSingleton<PokemonRepository>(
    PokemonRepositoryImpl(
      pokemonApi: getIt<PokemonApi>(),
    ),
  );
  getIt.registerSingleton<UserInfoRepository>(
    FirestoreUserInfoRepository(
      instance: FirebaseFirestore.instance,
    ),
  );
  getIt.registerSingleton<TypeRepository>(
    TypeRepositoryImpl(
      typeApi: getIt<TypeApi>(),
    ),
  );
  // ============================================================
  //                             <<< REPOSITORIES Declaration END
  // ============================================================

  // ============================================================
  // USE_CASES Declaration START >>>
  // ============================================================
  getIt.registerSingleton<GetUserAccountUseCase>(
    GetUserAccountUseCase(
      userAccountRepository: getIt<UserAccountRepository<String, String>>(),
    ),
  );
  getIt.registerSingleton<RemoveUserAccountUseCase>(
    RemoveUserAccountUseCase(
      userAccountRepository: getIt<UserAccountRepository<String, String>>(),
    ),
  );
  getIt.registerSingleton<RegisterUseCase>(
    RegisterUseCase(
      authRepository: getIt<AuthRepository<EmailPassword>>(),
    ),
  );
  getIt.registerSingleton<RequestVerifyUseCase>(
    RequestVerifyUseCase(
      authRepository: getIt<AuthRepository<EmailPassword>>(),
    ),
  );
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(
      authRepository: getIt<AuthRepository<EmailPassword>>(),
    ),
  );
  getIt.registerSingleton<CheckVerifyUseCase>(
    CheckVerifyUseCase(
      authRepository: getIt<AuthRepository<EmailPassword>>(),
    ),
  );
  getIt.registerSingleton<ResetPasswordUseCase>(
    ResetPasswordUseCase(
      authRepository: getIt<AuthRepository<EmailPassword>>(),
    ),
  );
  getIt.registerSingleton<StoreUserAccountUseCase>(
    StoreUserAccountUseCase(
      userAccountRepository: getIt<UserAccountRepository<String, String>>(),
    ),
  );
  getIt.registerSingleton<LogoutUseCase>(
    LogoutUseCase(
      authRepository: getIt<AuthRepository<EmailPassword>>(),
    ),
  );
  getIt.registerSingleton<AddAndUpdateUserInfoUseCase>(
    AddAndUpdateUserInfoUseCase(
      userInfoRepository: getIt<UserInfoRepository>(),
    ),
  );
  getIt.registerSingleton<GetUserInfoUseCase>(
    GetUserInfoUseCase(
      userInfoRepository: getIt<UserInfoRepository>(),
    ),
  );
  getIt.registerSingleton<GetPokemonUseCase>(
    GetPokemonUseCase(
      pokemonRepository: getIt<PokemonRepository>(),
    ),
  );
  getIt.registerSingleton<SortedByOptionPokemonUseCase>(
    SortedByOptionPokemonUseCase(),
  );
  getIt.registerSingleton<DrawPokemonUseCase>(
    DrawPokemonUseCase(),
  );
  getIt.registerSingleton<SearchByNamePokemonUseCase>(
    SearchByNamePokemonUseCase(),
  );
  getIt.registerSingleton<GetTypeUseCase>(
    GetTypeUseCase(
      pokemonRepository: getIt<TypeRepository>(),
    ),
  );
  getIt.registerSingleton<RefreshPokemonUseCase>(
    RefreshPokemonUseCase(),
  );
  // ============================================================
  //                                <<< USE_CASES Declaration END
  // ============================================================

  // ============================================================
  // VIEW_MODELS Declaration START >>>
  // ============================================================
  getIt.registerFactory<SplashViewModel>(
    () => SplashViewModel(
      loginUseCase: getIt<LoginUseCase>(),
      getUserAccountUseCase: getIt<GetUserAccountUseCase>(),
      removeUserAccountUseCase: getIt<RemoveUserAccountUseCase>(),
    ),
  );
  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      storeUserAccountUseCase: getIt<StoreUserAccountUseCase>(),
      resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
      requestVerifyUseCase: getIt<RequestVerifyUseCase>(),
      checkVerifyUseCase: getIt<CheckVerifyUseCase>(),
    ),
  );
  getIt.registerFactory<MainViewModel>(
    () => MainViewModel(
      logoutUseCase: getIt<LogoutUseCase>(),
      removeUserAccountUseCase: getIt<RemoveUserAccountUseCase>(),
      getPokemonUseCase: getIt<GetPokemonUseCase>(),
      getUserAccountUseCase: getIt<GetUserAccountUseCase>(),
      getUserInfoUseCase: getIt<GetUserInfoUseCase>(),
      addAndUpdateUserInfoUseCase: getIt<AddAndUpdateUserInfoUseCase>(),
      searchByNamePokemonUseCase: getIt<SearchByNamePokemonUseCase>(),
      sortedByOptionPokemonUseCase: getIt<SortedByOptionPokemonUseCase>(),
      getTypeUseCase: getIt<GetTypeUseCase>(),
      refreshPokemonUseCase: getIt<RefreshPokemonUseCase>(),
    ),
  );
  getIt.registerFactory<RouletteViewModel>(
    () => RouletteViewModel(
      drawPokemonUseCase: getIt<DrawPokemonUseCase>(),
      addAndUpdateUserInfoUseCase: getIt<AddAndUpdateUserInfoUseCase>(),
    ),
  );
  getIt.registerFactory<AppTimer>(
    () => AppTimer(),
  );
  // ============================================================
  //                              <<< VIEW_MODELS Declaration END
  // ============================================================
}
