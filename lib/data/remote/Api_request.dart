import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get_storage/get_storage.dart';

class ApiRequest {
  final String url;
  Map<String, String>? queryParameters;
  var data;

  final box = GetStorage();

  ApiRequest({
    required this.url,
    this.queryParameters,
    this.data,
  });

  Dio _dio() {
    var dio = Dio(
        BaseOptions(
          connectTimeout: 5000,
          receiveTimeout: 5000,
        ));
    dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
    var token = box.read('token');
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          if (token != null && token != '') {
            request.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(request);
        },

      ),
    );
    return dio;
  }


  Future get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    _dio().get(
      url,
      queryParameters: queryParameters,
      options: buildCacheOptions(const Duration(days: 0), forceRefresh: true),
    ).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future post({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {

    _dio().post(url,data: data).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future put({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    _dio().put(url,data: data).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

  Future delete({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    _dio().delete(url).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }

}