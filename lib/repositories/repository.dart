import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:query_params/query_params.dart';

import 'package:flutter_focus_app/repositories/userRepository.dart';

const String HOST = "https://tmpserver.vercel.app";

class Repository {
  HttpClient http;

  UserRepository userRepository;

  Repository() {
    http = HttpClient(this);

    userRepository = UserRepository(this);
  }
}

class HttpClient {
  final Repository repository;
  http.Client client;

  HttpClient(this.repository) {
    client = http.Client();
  }

  Uri buildUrl(String url, Map queryParameters) {
    final params = URLQueryParams();

    /// `x?.p` null-aware access:
    /// `x?.p` restituisce `x.p` se `x` non è `null`, altrimenti restituisce `null`.
    queryParameters?.removeWhere((key, value) => value == null);
    queryParameters?.forEach((key, value) => params.append(key, value));

    return Uri.parse('$HOST/api/v2$url?${queryParameters.toString()}');
  }

  Map<String, String> encodeBody(Map<String, dynamic> body) {
    body.removeWhere((key, value) => value == null);

    return body.map((key, value) => MapEntry(key, value.toString()));
  }

  Future<http.Response> get(
    String url, {
    Map queryParameters,
  }) {
    return http.get(buildUrl(url, queryParameters));
  }

  Future<http.Response> post(
    String url, {
    Map queryParameters,
    Map<String, dynamic> bodyParameters,
  }) {
    return http.post(buildUrl(url, queryParameters), body: encodeBody(bodyParameters));
  }

  Future<http.Response> patch(
    String url, {
    Map queryParameters,
    Map<String, dynamic> bodyParameters,
  }) {
    return http.patch(buildUrl(url, queryParameters), body: encodeBody(bodyParameters));
  }

  Future<http.Response> delete(
    String url, {
    Map queryParameters,
  }) {
    return http.delete(buildUrl(url, queryParameters));
  }

  Future<http.Response> postMultipart(
    String url, {
    Map queryParameters,
    Map<String, dynamic> bodyParameters = const {},
    Map<String, File> fileParameters = const {},
  }) async {
    var request = http.MultipartRequest('POST', buildUrl(url, queryParameters ?? {}));

    bodyParameters.forEach((key, value) {
      request.fields[key] = value;
    });

    fileParameters.forEach((key, file) async {
      var requestFile = await http.MultipartFile.fromPath(key, file.path);
      request.files.add(requestFile);
    });

    var response = await request.send();
    return http.Response.fromStream(response);
  }
}

class RequestError implements Exception {
  final String error;

  RequestError(this.error);
}
