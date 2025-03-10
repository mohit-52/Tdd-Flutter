import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tbb/core/errors/exceptions.dart';
import 'package:tbb/core/utils/constants.dart';
import 'package:tbb/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:tbb/src/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test('should complete successfully when the status code 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'), headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response('User Created Successfully', 201),
      );

      final methodCall = remoteDataSource.createUser;

      expect(
          methodCall(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          ),
          completes);

      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar'
          },),
      headers: {
        'Content-Type' : 'application/json'
      })).called(1);

      verifyNoMoreInteractions(client);
    });

    test('should throw [APIException] when the status code is not 200 or 201',
        () async {
      when(() => client.post(any(), body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      final methodCall = remoteDataSource.createUser;
      expect(
          () => methodCall(
                createdAt: 'createdAt',
                name: 'name',
                avatar: 'avatar',
              ),
          throwsA(
              APIException(message: 'Invalid email address', statusCode: 400)));
      verify(() => client.post(Uri.https(kBaseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': 'createdAt',
            'name': 'name',
            'avatar': 'avatar'
          }),
      headers: {
        'Content-Type' : 'application/json'
      })).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];
    test('Should return the [List<Users>] if the status code is 200', () async {
      when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200));

      final result = await remoteDataSource.getUsers();

      expect(result, equals(tUsers));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUserEndpoint))).called(1);
      verifyNoMoreInteractions(client);
    });

    test('Should throw [APIException] if the status code is not 200', () async {
      final tMessage =
          'Server Down , Server Down, Mayday, Mayday , AHHHHHHHHHHHHHHHHHHHHHHHHHHHH';

      when(() => client.get(any()))
          .thenAnswer((_) async => http.Response(tMessage, 500));

      final methodCall = await remoteDataSource.getUsers;

      expect(() => methodCall(),
          throwsA(APIException(message: tMessage, statusCode: 500)));

      verify(() => client.get(Uri.https(kBaseUrl, kGetUserEndpoint))).called(1);
      verifyNoMoreInteractions(client);
    });
  });
}
