// What does the class depend on
// --> AuthenticationRepository
// How can we create a fake version of dependency
// --> Mocktail
// How do we control what our dependency do
// --> Using Mocktail API

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tbb/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tbb/src/testcase/create_user.dart';

import 'authentiation_repository.mock.dart';


void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test('should call the [AuthRepo.createUser]', () async {
    //1. Arrange
    //         Stub
    when(() => repository.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')))
        .thenAnswer((_) async => const Right(null));

    //2. Act
    final result = await usecase(params);

    //3. Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createUser(
          createdAt: params.createdAt,
          name: params.name,
          avatar: params.avatar,
        )).called(1);
    
    verifyNoMoreInteractions(repository);
  });

  
}
