import 'package:dio/dio.dart';
import 'package:movie_app/interceptor.dart';
import 'package:movie_app/movie_response.dart';

class AppClient {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        connectTimeout: 5000,
        receiveTimeout: 3000),
  );

  AppClient() {
    _dio.interceptors.add(Logging());
  }

  Future<MovieResponse?> getUpcoming(String category) async {
    MovieResponse? movieResponse;
    String searchBy = "upcoming";

    if (category == "tv") searchBy = "airing_today";

    try {
      final response = await _dio.get(
          '/$category/$searchBy?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      print('Error sending request ${e.message}!');
    }

    return movieResponse;
  }

  Future<MovieResponse?> getTrending(String category) async {
    MovieResponse? movieResponse;

    try {
      final response = await _dio.get(
          '/$category/popular?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      print('Error sending request ${e.message}!');
    }

    return movieResponse;
  }

    Future<MovieResponse?> getTopRated(String category) async {
    MovieResponse? movieResponse;

    try {
      final response = await _dio.get(
          '/$category/top_rated?api_key=6dd04502cb6dddf5bb7c93bf6f5174d4&page=1');
      movieResponse = MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      // ignore: avoid_print
      print('Error sending request ${e.message}!');
    }

    return movieResponse;
  }
}
