import 'dart:io';

import 'package:dio/dio.dart';

class NetworkConfiguration {
  static const String BASE_URL = "http://dummy.restapiexample.com/api/v1";
  static const String EMPLOYEE_URL = "/employees";

  static const int CONNECTION_TIMEOUT = 5000;
  static const int RECEIVE_TIMEOUT = 30000;

  static const String HEADER_KEY_CONTENT_TYPE =
      "application/x-www-form-urlencoded";

  static final baseOptions = BaseOptions(
    baseUrl: BASE_URL,
    connectTimeout: CONNECTION_TIMEOUT,
    receiveTimeout: RECEIVE_TIMEOUT,
    contentType: ContentType.parse(HEADER_KEY_CONTENT_TYPE).toString(),
    headers: {
      HttpHeaders.contentTypeHeader: HEADER_KEY_CONTENT_TYPE,
    },
  );





}