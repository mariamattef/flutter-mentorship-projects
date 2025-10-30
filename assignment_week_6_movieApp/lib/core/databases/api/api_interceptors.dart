import 'package:dio/dio.dart';
import 'package:themeandpagination/core/databases/api/end_points.dart';
import 'package:themeandpagination/core/databases/cache/cache_helper.dart';
import 'package:themeandpagination/core/di/service_locator.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = CacheHelper().getData(key: 'token');
    print(token);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final prefs = CacheHelper();
    if (err.response?.statusCode == 401) {
      final refreshToken = await CacheHelper().getData(key: 'refresh_token');

      if (refreshToken != null) {
        try {
          final dio = Dio(BaseOptions(baseUrl: EndPoints.baserUrl));
          final response = await dio.post(
            'EndPoints.refreshToken',
            data: {'refreshToken': refreshToken},
          );

          if (response.statusCode == 200) {
            final newAccessToken = response.data['accessToken'];

            await prefs.saveData(key: 'token', value: newAccessToken);

            err.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            final opts = Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            );
            final cloneReq = await sl<Dio>().request(
              err.requestOptions.path,
              options: opts,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
            );

            return handler.resolve(cloneReq);
          }
        } catch (e) {
          await prefs.removeData(key: 'token');
          await prefs.removeData(key: 'refresh_token');
        }
      }
    }
    super.onError(err, handler);
  }
}
