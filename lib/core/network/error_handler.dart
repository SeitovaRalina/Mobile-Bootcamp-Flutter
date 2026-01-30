import 'package:dio/dio.dart';

import '../error/failures.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return const NetworkFailure();
      } else if (error.type == DioExceptionType.badResponse) {
        return ServerFailure(error.response?.data['message'] ?? 'Server error');
      } else {
        return const UnknownFailure();
      }
    }

    if (error is FormatException || error is TypeError) {
      return const CacheFailure();
    }

    return const UnknownFailure();
  }
}
