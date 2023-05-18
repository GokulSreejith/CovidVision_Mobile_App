import 'package:covid_detective/src/domain/core/api_endpoints.dart';
import 'package:dio/dio.dart';

final BaseOptions dioOptions = BaseOptions(
  baseUrl: ApiEndpoints.baseURL,
  contentType: 'application/json',
  followRedirects: false,
  validateStatus: (status) {
    return true;
    // return status! < 500;
  },
);

class JwtInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // final token = Prefs.getString(SharedPreferenceKeys.userToken);

    // if (token.isNotEmpty) {
    //   options.headers["Authorization"] = 'Bearer $token';
    // }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 403) {
      // return handler.reject(DioError(requestOptions: ));
    }
    handler.resolve(response);
  }
}

final dioClient = Dio()
  ..options = dioOptions
  ..interceptors.add(JwtInterceptor());
