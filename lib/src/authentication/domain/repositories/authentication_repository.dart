import 'package:dartz/dartz.dart';
import 'package:tbb/core/errors/failure.dart';
import 'package:tbb/core/utils/typedef.dart';

import '../entities/user.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();

}
