// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chat_firebase/data/datasource/auth_remote_datasource.dart'
    as _i878;
import 'package:chat_firebase/data/datasource/chat_remote_datasource.dart'
    as _i227;
import 'package:chat_firebase/data/repository/auth_repository_impl.dart'
    as _i1028;
import 'package:chat_firebase/data/repository/chat_repository_impl.dart'
    as _i567;
import 'package:chat_firebase/domain/repository/auth_repository.dart' as _i353;
import 'package:chat_firebase/domain/repository/chat_repository.dart' as _i250;
import 'package:chat_firebase/domain/usecases/auth_usecases/get_current_user_usecase.dart'
    as _i479;
import 'package:chat_firebase/domain/usecases/auth_usecases/sign_in_usecase.dart'
    as _i803;
import 'package:chat_firebase/domain/usecases/auth_usecases/sign_out_usecase.dart'
    as _i418;
import 'package:chat_firebase/domain/usecases/auth_usecases/sign_up_usecase.dart'
    as _i507;
import 'package:chat_firebase/domain/usecases/chat_usecases/get_messages_usecase.dart'
    as _i600;
import 'package:chat_firebase/domain/usecases/chat_usecases/get_users_usecase.dart'
    as _i100;
import 'package:chat_firebase/domain/usecases/chat_usecases/send_message_usecase.dart'
    as _i1072;
import 'package:chat_firebase/feature/auth/bloc/auth_bloc.dart' as _i701;
import 'package:chat_firebase/feature/chat/bloc/chat_bloc.dart' as _i415;
import 'package:chat_firebase/feature/main/bloc/home_bloc.dart' as _i511;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i878.AuthRemoteDataSource>(
      () => _i878.AuthRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i353.AuthRepository>(
      () => _i1028.AuthRepositoryImpl(
        remoteDataSource: gh<_i878.AuthRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i227.ChatRemoteDataSource>(
      () => _i227.ChatRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i250.ChatRepository>(
      () => _i567.ChatRepositoryImpl(
        remoteDataSource: gh<_i227.ChatRemoteDataSource>(),
      ),
    );
    gh.factory<_i803.SignInUseCase>(
      () => _i803.SignInUseCase(repository: gh<_i353.AuthRepository>()),
    );
    gh.factory<_i507.SignUpUseCase>(
      () => _i507.SignUpUseCase(repository: gh<_i353.AuthRepository>()),
    );
    gh.factory<_i418.SignOutUseCase>(
      () => _i418.SignOutUseCase(repository: gh<_i353.AuthRepository>()),
    );
    gh.factory<_i479.GetCurrentUserUseCase>(
      () => _i479.GetCurrentUserUseCase(repository: gh<_i353.AuthRepository>()),
    );
    gh.factory<_i600.GetMessagesUseCase>(
      () => _i600.GetMessagesUseCase(repository: gh<_i250.ChatRepository>()),
    );
    gh.factory<_i100.GetUsersUseCase>(
      () => _i100.GetUsersUseCase(repository: gh<_i250.ChatRepository>()),
    );
    gh.factory<_i1072.SendMessageUseCase>(
      () => _i1072.SendMessageUseCase(repository: gh<_i250.ChatRepository>()),
    );
    gh.lazySingleton<_i701.AuthBloc>(
      () => _i701.AuthBloc(
        signInUseCase: gh<_i803.SignInUseCase>(),
        signUpUseCase: gh<_i507.SignUpUseCase>(),
        signOutUseCase: gh<_i418.SignOutUseCase>(),
        getCurrentUserUseCase: gh<_i479.GetCurrentUserUseCase>(),
      ),
    );
    gh.singleton<_i511.HomeBloc>(
      () => _i511.HomeBloc(getUsersUseCase: gh<_i100.GetUsersUseCase>()),
    );
    gh.factory<_i415.ChatBloc>(
      () => _i415.ChatBloc(
        getMessagesUseCase: gh<_i600.GetMessagesUseCase>(),
        sendMessageUseCase: gh<_i1072.SendMessageUseCase>(),
      ),
    );
    return this;
  }
}
