import 'package:tbb/core/usecase/usecase.dart';
import 'package:tbb/core/utils/typedef.dart';
import 'package:tbb/src/authentication/domain/entities/user.dart';
import 'package:tbb/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParam<List<User>>{
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();

}