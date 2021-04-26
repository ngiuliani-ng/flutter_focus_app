import 'dart:io';
import 'dart:convert';

import 'package:flutter_focus_app/repositories/repository.dart';

import 'package:flutter_focus_app/models/plansType.dart';
import 'package:flutter_focus_app/models/user.dart';

class UserRepository {
  Repository repository;

  UserRepository(this.repository);

  Future<String> login(
    String email,
    String password,
  ) async {
    final response = await repository.http.post(
      '/login',
      bodyParameters: {
        'email': email,
        'password': password,
      },
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final token = data['token'];
      return token;
    }

    throw RequestError(data['error']);
  }

  Future<String> register(
    String name,
    String surname,
    String email,
    String password,
    PlansType planType,
    File avatarFile,
  ) async {
    final response = await repository.http.postMultipart(
      '/register',
      bodyParameters: {
        'fullName': '$name $surname',
        'email': email,
        'password': password,
        'planType': planType?.toString(),
      },
      fileParameters: {
        /// Quando l'utente, durante la fase di registrazione, non seleziona l'immagine del profilo
        /// non devo passare l'[avatarFile] uguale a null.
        if (avatarFile != null) 'avatarFile': avatarFile,
      },
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final token = data['token'];
      return token;
    }

    throw RequestError(data['error']);
  }

  Future<UserModel> profile() async {
    final response = await repository.http.get(
      '/profile',
    );

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromData(data);
    }

    throw RequestError(data['error']);
  }
}
