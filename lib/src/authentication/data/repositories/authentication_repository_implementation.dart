import 'package:dartz/dartz.dart';
import 'package:tbb/core/errors/exceptions.dart';
import 'package:tbb/core/errors/failure.dart';
import 'package:tbb/core/utils/typedef.dart';
import 'package:tbb/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tbb/src/authentication/domain/entities/user.dart';
import 'package:tbb/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation implements AuthenticationRepository{

  const AuthenticationRepositoryImplementation(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({required String createdAt, required String name, required String avatar}) async {
    // Test Driven Development
    // Call the remote datasource
    // check if method return the proper data
    // make sure  it returns the proper data if there is no exception
    // if remoteData throws an exception, we'll return a failure

    try{
      await _remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar);
      return Right(null);
    }on APIException catch (e){
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers()async {
    try{
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    }on APIException catch (e){
      return Left(APIFailure.fromException(e));
    }
  }

}