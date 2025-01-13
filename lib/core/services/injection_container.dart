import 'package:get_it/get_it.dart';
import 'package:tbb/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tbb/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:tbb/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tbb/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tbb/src/testcase/create_user.dart';
import 'package:tbb/src/testcase/get_users.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl()),
    )

    // Use Cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(()=>GetUsers(sl()))

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))

    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
